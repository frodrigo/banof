DROP TABLE IF EXISTS osm_street CASCADE;
CREATE TABLE osm_street (
  id BIGINT PRIMARY KEY,
  insee CHAR(5) NOT NULL,
  fantoir CHAR(5),
  nom VARCHAR(255),
  nom_can VARCHAR(255)
);

SELECT AddGeometryColumn('osm_street', 'geom', 4326, 'GEOMETRY', 2);
CREATE INDEX idx_osm_street ON osm_street USING gist(geom);


DROP TABLE IF EXISTS osm_number CASCADE;
CREATE TABLE osm_number (
  street_id BIGINT NOT NULL,
  numero VARCHAR(255) NOT NULL,
  numero_i INT,
  ext VARCHAR(255),
  lat NUMERIC(10,8) NOT NULL,
  lon NUMERIC(10,8) NOT NULL,
  FOREIGN KEY(street_id) REFERENCES osm_street(id)
);
