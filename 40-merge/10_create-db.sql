DROP TABLE IF EXISTS cadastre_osm_street CASCADE;
CREATE TABLE cadastre_osm_street (
    insee CHAR(5) NOT NULL,
    cadastre_street_id BIGINT NOT NULL,
    osm_street_id BIGINT NOT NULL,
    match_level SMALLINT,
    --PRIMARY KEY(dep, insee, fantoir, osm_street_id),
    FOREIGN KEY(insee, cadastre_street_id) REFERENCES cadastre_street(insee, id),
    FOREIGN KEY(osm_street_id) REFERENCES osm_street(id)
);


DROP TABLE IF EXISTS cadastre_osm_way CASCADE;
CREATE TABLE cadastre_osm_way (
    insee CHAR(5) NOT NULL,
    cadastre_street_id BIGINT NOT NULL,
    osm_way_id BIGINT NOT NULL,
    match_level SMALLINT,
    --PRIMARY KEY(dep, insee, fantoir, way_id),
    FOREIGN KEY(insee, cadastre_street_id) REFERENCES cadastre_street(insee, id),
    FOREIGN KEY(osm_way_id) REFERENCES ways(id)
);


DROP TABLE IF EXISTS cadastre_osm_number CASCADE;
CREATE TABLE cadastre_osm_number (
    insee CHAR(5) NOT NULL,
    cadastre_street_id BIGINT NOT NULL,
    osm_street_id BIGINT NOT NULL,
    numero_i INT,
    ext VARCHAR(255)--,
--    FOREIGN KEY(insee, cadastre_street_id) REFERENCES cadastre_street(insee, id),
--    FOREIGN KEY(osm_street_id) REFERENCES osm_street(id)
);
