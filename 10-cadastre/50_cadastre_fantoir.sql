DROP TABLE IF EXISTS cadastre_fantoir CASCADE;
CREATE TABLE cadastre_fantoir (
  insee CHAR(5),
  fantoir CHAR(5),
  street_id BIGINT NOT NULL,
  match_level SMALLINT,
  FOREIGN KEY(insee, fantoir) REFERENCES fantoir(insee, fantoir), -- Il peut y avoir des doublons
  FOREIGN KEY(insee, street_id) REFERENCES cadastre_street(insee, id) -- Il peut y avoir des doublons
);
