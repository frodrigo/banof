SELECT
    NULL AS osm_id,
    NULL AS osm_lat,
    NULL AS osm_lon,
    NULL AS osm_numero,
    cadastre_number.insee AS insee,
    cadastre_number.street_id AS cadastre_street_id,
    cadastre_number.lat AS cadastre_lat,
    cadastre_number.lon AS cadastre_lon,
    cadastre_number.numero AS cadastre_numero
FROM
    cadastre_osm_street
    JOIN cadastre_number ON
        cadastre_number.insee = cadastre_osm_street.insee AND
        cadastre_number.street_id = cadastre_osm_street.cadastre_street_id
    LEFT JOIN cadastre_osm_number ON -- Mais le numéro n'est pas retrouvé
        cadastre_osm_number.insee = cadastre_number.insee AND
        cadastre_osm_number.cadastre_street_id = cadastre_number.street_id AND
        cadastre_osm_number.numero_i = cadastre_number.numero_i AND
        ((cadastre_osm_number.ext IS NULL AND cadastre_number.ext IS NULL) OR (cadastre_osm_number.ext = cadastre_number.ext))
WHERE
    cadastre_osm_number.insee IS NULL
;
