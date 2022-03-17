-- Διαγραφή πλοίων εκτός εμβέλειας κεραίας (0.336 μοίρες είναι περίπου 37km)
DELETE 
FROM unipi_kinematic_ais
WHERE st_contains(ST_Buffer(ST_GeomFromText('POINT(23.65298 37.94176)', 4326), 0.336), unipi_kinematic_ais.geom) = false;

-- Διαγραφή περιφερειών που δεν καλύπτονται από την κεραία
DELETE
from periphereies as p
WHERE st_overlaps(ST_Buffer(ST_GeomFromText('POINT(23.65298 37.94176)', 4326), 0.336), ST_Transform(p.geom, 4326)) = false;

-- Διαγραφή πλοίων από την στεριά
DELETE
FROM unipi_kinematic_ais
USING periphereies
WHERE st_contains(ST_Transform(periphereies.geom, 4326), unipi_kinematic_ais.geom) = true;

--Διαγραφή λιμανιών που δεν βρίσκονται εντός της εμβέλειας της κεραίας
DELETE 
FROM fishing_ports
WHERE st_contains(ST_Buffer(ST_GeomFromText('POINT(23.65298 37.94176)', 4326), 0.336), fishing_ports.geom) = false;

DELETE 
FROM world_ports
WHERE st_contains(ST_Buffer(ST_GeomFromText('POINT(23.65298 37.94176)', 4326), 0.336), world_ports.geom) = false;