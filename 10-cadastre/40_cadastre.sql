DROP TABLE IF EXISTS cadastre_street CASCADE;
CREATE TABLE cadastre_street (
  insee CHAR(5) NOT NULL,
  id BIGINT NOT NULL,
  nom VARCHAR(255) NOT NULL,
  nom_can VARCHAR(255),
  PRIMARY KEY(insee, id)
);

SELECT AddGeometryColumn('cadastre_street', 'geom', 4326, 'GEOMETRY', 2);
CREATE INDEX idx_cadastre_street ON cadastre_street USING gist(geom);


DROP TABLE IF EXISTS cadastre_number CASCADE;
CREATE TABLE cadastre_number (
  insee CHAR(5) NOT NULL,
  street_id BIGINT NOT NULL,
  lat NUMERIC(10,8) NOT NULL,
  lon NUMERIC(10,8) NOT NULL,
  numero VARCHAR(255) NOT NULL,
  numero_i INT,
  ext VARCHAR(255),
  FOREIGN KEY(insee, street_id) REFERENCES cadastre_street(insee, id)
);



DROP TABLE IF EXISTS cadastre_noms CASCADE;
CREATE TABLE cadastre_noms (
  insee CHAR(5) NOT NULL,
  lat NUMERIC(10,8) NOT NULL,
  lon NUMERIC(10,8) NOT NULL,
  dir NUMERIC(3) NOT NULL,
  nom VARCHAR(255) NOT NULL
);
