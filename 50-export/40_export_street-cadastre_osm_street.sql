SELECT
    'osm'||osm_street.id AS id,
    COALESCE(osm_street.nom, MIN(cadastre_street.nom)) AS nom,
    COALESCE(osm_street.insee, MIN(cadastre_street.insee)) AS insee,
    COALESCE(osm_street.fantoir, MIN(cadastre_fantoir.fantoir)) AS fantoir
FROM
    osm_street
    LEFT JOIN cadastre_osm_street ON
        cadastre_osm_street.insee = osm_street.insee AND
        cadastre_osm_street.osm_street_id = osm_street.id
    LEFT JOIN cadastre_street ON
        cadastre_street.insee = cadastre_osm_street.insee AND
        cadastre_street.id = cadastre_osm_street.cadastre_street_id
    LEFT JOIN cadastre_fantoir ON
        cadastre_fantoir.insee = cadastre_street.insee AND
        cadastre_fantoir.street_id = cadastre_street.id
GROUP BY
    osm_street.id,
    osm_street.insee,
    osm_street.nom
;
