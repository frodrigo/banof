SELECT
    NULL AS osm_id,
    NULL AS osm_lat,
    NULL AS osm_lon,
    NULL AS osm_numero,
    cadastre_number.insee AS insee,
    cadastre_number.street_id AS cadastre_id,
    cadastre_number.lat AS cadastre_lat,
    cadastre_number.lon AS cadastre_lon,
    cadastre_number.numero AS cadastre_numero
FROM
    cadastre_number
    LEFT JOIN cadastre_osm_street ON -- Pas de correspondance déjà trouvé
        cadastre_osm_street.insee = cadastre_number.insee AND
        cadastre_osm_street.cadastre_street_id = cadastre_number.street_id
WHERE
    cadastre_osm_street.insee IS NULL
;
