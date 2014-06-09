INSERT INTO
    cadastre_osm_number
SELECT
    cadastre_osm_street.insee,
    cadastre_osm_street.cadastre_street_id,
    cadastre_osm_street.osm_street_id,
    cadastre_number.numero_i,
    cadastre_number.ext
FROM
    cadastre_osm_street
    JOIN osm_number ON
        osm_number.street_id = cadastre_osm_street.osm_street_id
    JOIN cadastre_number ON
        cadastre_number.insee = cadastre_osm_street.insee AND
        cadastre_number.street_id = cadastre_osm_street.cadastre_street_id
WHERE
    cadastre_number.numero_i = osm_number.numero_i AND
    (cadastre_number.ext IS NULL AND osm_number.ext IS NULL) OR (cadastre_number.ext = osm_number.ext)
;
