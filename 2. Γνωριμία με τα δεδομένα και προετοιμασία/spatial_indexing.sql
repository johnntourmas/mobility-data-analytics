CREATE INDEX spatial_index
ON unipi_kinematic_ais
USING GIST (geom);


-- Ερωτήματα που χρησιμοποιούν το ευρετήριο
SELECT * 
FROM unipi_kinematic_ais
WHERE ST_DWithin(geom, ST_SetSRID(ST_MakePoint(23.65298 ,37.94176), 4326), 0.1);

SELECT *
FROM unipi_kinematic_ais
WHERE st_contains(ST_Buffer(ST_GeomFromText('POINT(23.65298 37.94176)', 4326), 0.01), unipi_kinematic_ais.geom) = false;


-- Ερωτήματα που δεν χρησιμοποιούν το ευρετήριο
select * 
from Unipi_Kinematic_AIS 
where geom < ST_MakePoint(23.65298 ,37.94176)