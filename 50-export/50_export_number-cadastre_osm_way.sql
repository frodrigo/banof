SELECT
    'cad'||cadastre_number.insee||cadastre_number.street_id AS id,
    cadastre_number.lat AS lat,
    cadastre_number.lon AS lon,
    cadastre_number.numero AS numero
FROM
    cadastre_number
    LEFT JOIN cadastre_osm_street ON -- Pas de correspondance déjà trouvé
        cadastre_osm_street.insee = cadastre_number.insee AND
        cadastre_osm_street.cadastre_street_id = cadastre_number.street_id
WHERE
    cadastre_osm_street.insee IS NULL
GROUP BY
    'cad'||cadastre_number.insee||cadastre_number.street_id,
    cadastre_number.lat,
    cadastre_number.lon,
    cadastre_number.numero
;
