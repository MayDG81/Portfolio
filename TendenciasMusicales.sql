-- #1
-- Table: public.artists
-- DROP TABLE IF EXISTS public.artists;

CREATE TABLE IF NOT EXISTS public.artists
(
    artist_id character varying COLLATE pg_catalog."default" NOT NULL,
    name_artist character varying COLLATE pg_catalog."default",
    CONSTRAINT artists_pkey PRIMARY KEY (artist_id)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.artists
    OWNER to postgres;
	
-- Table: public.statistic
-- DROP TABLE IF EXISTS public.statistic;

CREATE TABLE IF NOT EXISTS public.statistic
(
    artist_id character varying COLLATE pg_catalog."default",
    dates character varying COLLATE pg_catalog."default",
    popularity numeric,
    followers numeric
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.statistic
    OWNER to postgres;	

-- Se cargan los datos desde fichero csv
-- Se añaden primary y foreign keys a las tablas

ALTER TABLE statistic
ADD COLUMN codigo SERIAL PRIMARY KEY;

SELECT COUNT(artist_id), COUNT(DISTINCT artist_id)
FROM statistic;

/*Seria necesario dividir tabla para añadir clave foránea
ALTER TABLE statistic
ADD CONSTRAINT statistic_artist_id_key UNIQUE (artist_id);
ALTER TABLE artists
ADD CONSTRAINT artists_artist_id_fkey FOREIGN KEY (artist_id)
        REFERENCES public.statistic (artist_id);*/

--	#2 Información contenida en las tablas
SELECT COUNT(*)
  FROM artists
 WHERE name_artist ISNULL OR artist_id ISNULL;

SELECT COUNT(name_artist) AS "Name", COUNT(DISTINCT name_artist) AS "UName",
       COUNT(artist_id) AS "Id", COUNT(DISTINCT artist_id) AS "UId"  
  FROM artists;
       
SELECT COUNT(*)
  FROM statistic
 WHERE artist_id ISNULL OR dates ISNULL OR popularity ISNULL OR followers ISNULL;

SELECT COUNT(artist_id) AS "Id", COUNT(DISTINCT artist_id) AS "UId",
       COUNT(dates) AS "Date", COUNT(DISTINCT dates) AS "UDate",
	   COUNT(popularity) AS "Popularity", COUNT(DISTINCT popularity) AS "UPopularity",
	   COUNT(followers) AS "Folllowers", COUNT(DISTINCT followers) AS "UFollowers"
  FROM statistic;

SELECT COUNT(DISTINCT s.artist_id) 
  FROM artists a
  JOIN statistic s ON  a.artist_id = s.artist_id; --1022 de 1022 artistas con estadisticas

SELECT COUNT(s.artist_id)
  FROM artists  a
 RIGHT JOIN statistic s ON  a.artist_id = s.artist_id
 WHERE a.artist_id ISNULL; --1026 registros de artistas no en artists
 
-- #3 Exploración de valores generales en statistic
SELECT MIN(popularity) AS "MinPopularity", MAX(popularity) AS "MaxPopularity", ROUND(AVG(popularity), 2) AS "AvgPopularity", 
       MIN(followers) AS "MinFollowers", MAX(followers) AS "MaxFollowers", ROUND(AVG(followers), 2) AS "AvgFollowers"
  FROM statistic;

SELECT MIN(popularity) AS "MinPopularity", MAX(popularity) AS "MaxPopularity", ROUND(AVG(popularity), 2) AS "AvgPopularity", 
       MIN(followers) AS "MinFollowers", MAX(followers) AS "MaxFollowers", ROUND(AVG(followers), 2) AS "AvgFollowers"
  FROM artists a
  JOIN statistic s ON  a.artist_id = s.artist_id;
  
SELECT s.dates, MIN(popularity) AS "MinPopularity", MAX(popularity) AS "MaxPopularity", ROUND(AVG(popularity), 2) AS "AvgPopularity", 
       MIN(followers) AS "MinFollowers", MAX(followers) AS "MaxFollowers", ROUND(AVG(followers), 2) AS "AvgFollowers"
  FROM artists a
  JOIN statistic s ON  a.artist_id = s.artist_id
 GROUP BY s.dates
 ORDER BY s.dates DESC;
 
 -- #4 Creación de vistas
CREATE VIEW d1 AS 
     SELECT a.artist_id, a.name_artist, s.popularity, s.followers
       FROM artists a
       JOIN statistic s ON  a.artist_id = s.artist_id
	  WHERE s.dates = '04/21/2020';
	  
CREATE VIEW d2 AS 
     SELECT a.artist_id, a.name_artist, s.popularity, s.followers
       FROM artists a
       JOIN statistic s ON  a.artist_id = s.artist_id
	  WHERE s.dates = '04/22/2020';	  

CREATE VIEW d3 AS 
     SELECT a.artist_id, a.name_artist, s.popularity, s.followers
       FROM artists a
       JOIN statistic s ON  a.artist_id = s.artist_id
	  WHERE s.dates = '04/23/2020';	
	  
CREATE VIEW d4 AS 
     SELECT a.artist_id, a.name_artist, s.popularity, s.followers
       FROM artists a
       JOIN statistic s ON  a.artist_id = s.artist_id
	  WHERE s.dates = '04/24/2020';	
	  
CREATE VIEW d5 AS 
     SELECT a.artist_id, a.name_artist, s.popularity, s.followers
       FROM artists a
       JOIN statistic s ON  a.artist_id = s.artist_id
	  WHERE s.dates = '04/25/2020';	
	  
CREATE VIEW d6 AS 
     SELECT a.artist_id, a.name_artist, s.popularity, s.followers
       FROM artists a
       JOIN statistic s ON  a.artist_id = s.artist_id
	  WHERE s.dates = '04/27/2020';	
	  
CREATE VIEW d7 AS 
     SELECT a.artist_id, a.name_artist, s.popularity, s.followers
       FROM artists a
       JOIN statistic s ON  a.artist_id = s.artist_id
	  WHERE s.dates = '05/02/2020';
	  
CREATE VIEW d8 AS 
     SELECT a.artist_id, a.name_artist, s.popularity, s.followers
       FROM artists a
       JOIN statistic s ON  a.artist_id = s.artist_id
	  WHERE s.dates = '05/03/2020';
	  
CREATE VIEW d9 AS 
     SELECT a.artist_id, a.name_artist, s.popularity, s.followers
       FROM artists a
       JOIN statistic s ON  a.artist_id = s.artist_id
	  WHERE s.dates = '05/09/2020';
	  
CREATE VIEW d10 AS 
     SELECT a.artist_id, a.name_artist, s.popularity, s.followers
       FROM artists a
       JOIN statistic s ON  a.artist_id = s.artist_id
	  WHERE s.dates = '05/16/2020';
	  
CREATE VIEW d11 AS 
     SELECT a.artist_id, a.name_artist, s.popularity, s.followers
       FROM artists a
       JOIN statistic s ON  a.artist_id = s.artist_id
	  WHERE s.dates = '05/23/2020';
	  
CREATE VIEW d12 AS 
     SELECT a.artist_id, a.name_artist, s.popularity, s.followers
       FROM artists a
       JOIN statistic s ON  a.artist_id = s.artist_id
	  WHERE s.dates = '05/30/2020';
	  
CREATE VIEW d13 AS 
     SELECT a.artist_id, a.name_artist, s.popularity, s.followers
       FROM artists a
       JOIN statistic s ON  a.artist_id = s.artist_id
	  WHERE s.dates = '06/06/2020';
	  
-- #5 Análisis por fechas TOP10
CREATE VIEW d1t10 AS 
SELECT d1.name_artist, d1.popularity, d1.followers
  FROM d1
 ORDER BY d1.popularity DESC, d1.followers DESC
 LIMIT 10;

CREATE VIEW d2t10 AS 
SELECT d2.name_artist, d2.popularity, d2.followers
  FROM d2
 ORDER BY d2.popularity DESC, d2.followers DESC
 LIMIT 10;

CREATE VIEW d3t10 AS 
SELECT d3.name_artist, d3.popularity, d3.followers
  FROM d3
 ORDER BY d3.popularity DESC, d3.followers DESC
 LIMIT 10;

CREATE VIEW d4t10 AS 
SELECT d4.name_artist, d4.popularity, d4.followers
  FROM d4
 ORDER BY d4.popularity DESC, d4.followers DESC
 LIMIT 10;
 
CREATE VIEW d5t10 AS 
SELECT d5.name_artist, d5.popularity, d5.followers
  FROM d5
 ORDER BY d5.popularity DESC, d5.followers DESC
 LIMIT 10;
 
CREATE VIEW d5t10 AS 
SELECT d5.name_artist, d5.popularity, d5.followers
  FROM d5
 ORDER BY d5.popularity DESC, d5.followers DESC
 LIMIT 10;
 
CREATE VIEW d6t10 AS 
SELECT d6.name_artist, d6.popularity, d6.followers
  FROM d6
 ORDER BY d6.popularity DESC, d6.followers DESC
 LIMIT 10;
 
CREATE VIEW d7t10 AS 
SELECT d7.name_artist, d7.popularity, d7.followers
  FROM d7
 ORDER BY d7.popularity DESC, d7.followers DESC
 LIMIT 10;
 
CREATE VIEW d8t10 AS 
SELECT d8.name_artist, d8.popularity, d8.followers
  FROM d8
 ORDER BY d8.popularity DESC, d8.followers DESC
 LIMIT 10; 
 
CREATE VIEW d9t10 AS 
SELECT d9.name_artist, d9.popularity, d9.followers
  FROM d9
 ORDER BY d9.popularity DESC, d9.followers DESC
 LIMIT 10;

CREATE VIEW d10t10 AS 
SELECT d10.name_artist, d10.popularity, d10.followers
  FROM d10
 ORDER BY d10.popularity DESC, d10.followers DESC
 LIMIT 10;
 
CREATE VIEW d11t10 AS 
SELECT d11.name_artist, d11.popularity, d11.followers
  FROM d11
 ORDER BY d11.popularity DESC, d11.followers DESC
 LIMIT 10; 

CREATE VIEW d12t10 AS 
SELECT d12.name_artist, d12.popularity, d12.followers
  FROM d12
 ORDER BY d12.popularity DESC, d12.followers DESC
 LIMIT 10;

CREATE VIEW d13t10 AS 
SELECT d13.name_artist, d13.popularity, d13.followers
  FROM d13
 ORDER BY d13.popularity DESC, d13.followers DESC
 LIMIT 10;

-- #6 Artistas escuchados en todos los TOP10 y por meses
SELECT d1t10.name_artist
  FROM d1t10
  JOIN d2t10 ON d1t10.name_artist = d2t10.name_artist
  JOIN d3t10 ON d1t10.name_artist = d3t10.name_artist
  JOIN d4t10 ON d1t10.name_artist = d4t10.name_artist
  JOIN d5t10 ON d1t10.name_artist = d5t10.name_artist
  JOIN d6t10 ON d1t10.name_artist = d6t10.name_artist
  JOIN d7t10 ON d1t10.name_artist = d7t10.name_artist
  JOIN d8t10 ON d1t10.name_artist = d8t10.name_artist
  JOIN d9t10 ON d1t10.name_artist = d9t10.name_artist
  JOIN d10t10 ON d1t10.name_artist = d10t10.name_artist
  JOIN d11t10 ON d1t10.name_artist = d11t10.name_artist
  JOIN d12t10 ON d1t10.name_artist = d12t10.name_artist
  JOIN d13t10 ON d1t10.name_artist = d13t10.name_artist;

-- Excluyendo Junio
SELECT d1t10.name_artist
  FROM d1t10
  JOIN d2t10 ON d1t10.name_artist = d2t10.name_artist
  JOIN d3t10 ON d1t10.name_artist = d3t10.name_artist
  JOIN d4t10 ON d1t10.name_artist = d4t10.name_artist
  JOIN d5t10 ON d1t10.name_artist = d5t10.name_artist
  JOIN d6t10 ON d1t10.name_artist = d6t10.name_artist
  JOIN d7t10 ON d1t10.name_artist = d7t10.name_artist
  JOIN d8t10 ON d1t10.name_artist = d8t10.name_artist
  JOIN d9t10 ON d1t10.name_artist = d9t10.name_artist
  JOIN d10t10 ON d1t10.name_artist = d10t10.name_artist
  JOIN d11t10 ON d1t10.name_artist = d11t10.name_artist
  JOIN d12t10 ON d1t10.name_artist = d12t10.name_artist;
  
-- Abril
SELECT d1t10.name_artist
  FROM d1t10
  JOIN d2t10 ON d1t10.name_artist = d2t10.name_artist
  JOIN d3t10 ON d1t10.name_artist = d3t10.name_artist
  JOIN d4t10 ON d1t10.name_artist = d4t10.name_artist
  JOIN d5t10 ON d1t10.name_artist = d5t10.name_artist
  JOIN d6t10 ON d1t10.name_artist = d6t10.name_artist;
  
--Mayo
SELECT d7t10.name_artist
  FROM d7t10
  JOIN d8t10 ON d7t10.name_artist = d8t10.name_artist
  JOIN d9t10 ON d7t10.name_artist = d9t10.name_artist
  JOIN d10t10 ON d7t10.name_artist = d10t10.name_artist
  JOIN d11t10 ON d7t10.name_artist = d11t10.name_artist
  JOIN d12t10 ON d7t10.name_artist = d12t10.name_artist;
  
-- #7 Artistas escuchados en todas las fechas
SELECT DISTINCT d1.name_artist
  FROM d1
  JOIN d2 ON d1.artist_id = d2.artist_id
  JOIN d3 ON d1.artist_id = d3.artist_id
  JOIN d4 ON d1.artist_id = d4.artist_id
  JOIN d5 ON d1.artist_id = d5.artist_id
  JOIN d6 ON d1.artist_id = d6.artist_id
  JOIN d7 ON d1.artist_id = d7.artist_id
  JOIN d8 ON d1.artist_id = d8.artist_id
  JOIN d9 ON d1.artist_id = d9.artist_id
  JOIN d10 ON d1.artist_id = d10.artist_id
  JOIN d11 ON d1.artist_id = d11.artist_id
  JOIN d12 ON d1.artist_id = d12.artist_id
  JOIN d13 ON d1.artist_id = d13.artist_id;
  
  -- # 8 Perfiles
  
  -- #Valor seguro en el momento actual
SELECT ROUND(AVG(s.popularity), 2) AS "AvgPopularity", ROUND(AVG(s.followers), 2) AS "AvgFollowers"
  FROM artists a
  JOIN statistic s ON  a.artist_id = s.artist_id
 WHERE a.name_artist IN ('The Weeknd', 'Bad Bunny', 'Billie Eilish', 'Drake',
						 'Dua Lipa', 'J Balvin', 'Justin Bieber', 'Post Malone','Travis Scott');
						  
 -- #Valor estable
SELECT ROUND(AVG(s.popularity), 2) AS "AvgPopularity", ROUND(AVG(s.followers), 2) AS "AvgFollowers"
 FROM artists a
 JOIN statistic s ON  a.artist_id = s.artist_id
WHERE a.name_artist IN (SELECT DISTINCT d1.name_artist
						FROM d1
						JOIN d2 ON d1.artist_id = d2.artist_id
						JOIN d3 ON d1.artist_id = d3.artist_id
						JOIN d4 ON d1.artist_id = d4.artist_id
						JOIN d5 ON d1.artist_id = d5.artist_id
						JOIN d6 ON d1.artist_id = d6.artist_id
						JOIN d7 ON d1.artist_id = d7.artist_id
						JOIN d8 ON d1.artist_id = d8.artist_id
						JOIN d9 ON d1.artist_id = d9.artist_id
						JOIN d10 ON d1.artist_id = d10.artist_id
						JOIN d11 ON d1.artist_id = d11.artist_id
						JOIN d12 ON d1.artist_id = d12.artist_id
						JOIN d13 ON d1.artist_id = d13.artist_id);
 