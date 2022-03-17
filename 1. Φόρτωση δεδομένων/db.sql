-- drop table vessels cascade
-- drop table unipi_kinematic_ais cascade


--Δημιουργία του πίνακα των σκαφών.
create table vessels(
	mmsi integer not null unique,
	imo integer,
	name varchar(200),
	flag varchar(100),
	type varchar(100),
	primary key(mmsi)
);

copy vessels from 'C:\Users\Giannis\Desktop\gis\data\static_ais_vessel_id.csv' DELIMITER ';' CSV HEADER;
select * from vessels

--Δημιουργία του πίνακα κινηματικών δεδομένων
create table unipi_kinematic_ais(
	ts double precision,	
	type integer,            
	mmsi integer,           
	status integer,          	
	lon double precision,  
	lat double precision, 	
	heading integer,      		
	turn double precision,  
	speed double precision, 	
	course 	double precision,
	foreign key (mmsi) references vessels(mmsi)
);

--Εισαγωγή δεδομένων στον πίνακα
copy unipi_kinematic_ais from 'C:\Users\Giannis\Desktop\gis\data\unipi_kinematic_AIS_apr2018.csv' DELIMITER ';' CSV HEADER;
copy unipi_kinematic_ais from 'C:\Users\Giannis\Desktop\gis\data\unipi_kinematic_AIS_mar2018.csv' DELIMITER ';' CSV HEADER;

select * from unipi_kinematic_ais

-- Τα tables world_ports, fishing_ports και periphereies τα εισάγαμε με την βοήθεια του QGIS
SELECT * from world_ports
select * from fishing_ports
select * from periphereies


--Δημιουργία στήλης γεωμετρίας
ALTER TABLE unipi_kinematic_AIS ADD COLUMN geom geometry(Point, 4326);
UPDATE unipi_kinematic_AIS SET geom = ST_SetSRID(ST_MakePoint(lon, lat), 4326);