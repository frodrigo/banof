SELECT
    osm_number.street_id AS osm_id,
    osm_number.lat AS osm_lat,
    osm_number.lon AS osm_lon,
    osm_number.numero AS osm_numero,
    cadastre_number.insee AS insee,
    cadastre_number.street_id AS cadastre_street_id,
    cadastre_number.lat AS cadastre_lat,
    cadastre_number.lon AS cadastre_lon,
    cadastre_number.numero AS cadastre_numero
FROM
    osm_number
    LEFT JOIN cadastre_osm_number ON
        cadastre_osm_number.osm_street_id = osm_number.street_id AND
        cadastre_osm_number.numero_i = osm_number.numero_i AND
        ((cadastre_osm_number.ext IS NULL AND osm_number.ext IS NULL) OR (cadastre_osm_number.ext = osm_number.ext))
    LEFT JOIN cadastre_number ON
        cadastre_number.insee = cadastre_osm_number.insee AND
        cadastre_number.street_id = cadastre_osm_number.cadastre_street_id AND
        cadastre_number.numero_i = cadastre_osm_number.numero_i AND
        ((cadastre_number.ext IS NULL AND cadastre_osm_number.ext IS NULL) OR (cadastre_number.ext = cadastre_osm_number.ext))
;
