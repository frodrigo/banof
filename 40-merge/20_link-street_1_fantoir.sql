INSERT INTO
    cadastre_osm_street
SELECT
    cadastre_street.insee,
    cadastre_street.id,
    osm_street.id,
    1
FROM
    osm_street
    JOIN cadastre_street ON
        cadastre_street.insee = osm_street.insee
    JOIN cadastre_fantoir ON
        cadastre_fantoir.insee = cadastre_street.insee AND
        cadastre_fantoir.street_id = cadastre_street.id AND
        cadastre_fantoir.fantoir = osm_street.fantoir
    LEFT JOIN cadastre_osm_street ON -- Pas de correspondance déjà trouvé
        cadastre_osm_street.insee = cadastre_street.insee AND
        cadastre_osm_street.osm_street_id = osm_street.id
WHERE
    cadastre_osm_street.insee IS NULL AND
    osm_street.fantoir IS NOT NULL
;
