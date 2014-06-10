INSERT INTO
    cadastre_osm_street
SELECT
    cadastre_street.insee,
    cadastre_street.id,
    osm_street.id,
    2
FROM
    osm_street
    JOIN cadastre_street ON
        cadastre_street.insee = osm_street.insee AND
        cadastre_street.nom_can = osm_street.nom_can
    LEFT JOIN cadastre_osm_street ON -- Pas de correspondance déjà trouvé
        cadastre_osm_street.insee = cadastre_street.insee AND
        cadastre_osm_street.osm_street_id = osm_street.id
WHERE
    cadastre_osm_street.insee IS NULL AND
    osm_street.insee IS NOT NULL
;
