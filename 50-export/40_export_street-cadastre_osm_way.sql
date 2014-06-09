SELECT
    'cad'||cadastre_street.insee||cadastre_street.id AS id,
    COALESCE(MIN(ways.tags->'name'), MIN(cadastre_street.nom)) AS nom,
    COALESCE(MIN(substring(tags->'ref:FR:FANTOIR' FROM 1 FOR 5)), cadastre_street.insee) AS insee,
    COALESCE(MIN(substring(tags->'ref:FR:FANTOIR' FROM 6 FOR 5)), cadastre_fantoir.fantoir) AS fantoir
FROM
    cadastre_street
    LEFT JOIN cadastre_osm_street ON -- Pas de correspondance déjà trouvé
        cadastre_osm_street.insee = cadastre_street.insee AND
        cadastre_osm_street.cadastre_street_id = cadastre_street.id
    LEFT JOIN cadastre_osm_way ON
        cadastre_osm_way.insee = cadastre_street.insee AND
        cadastre_osm_way.cadastre_street_id = cadastre_street.id
    LEFT JOIN ways ON
        ways.id = cadastre_osm_way.osm_way_id
    LEFT JOIN cadastre_fantoir ON
        cadastre_fantoir.insee = cadastre_street.insee AND
        cadastre_fantoir.street_id = cadastre_street.id
WHERE
    cadastre_osm_street.insee IS NULL
GROUP BY
    cadastre_street.id,
    cadastre_street.insee,
    cadastre_street.nom,
    cadastre_street.insee,
    cadastre_fantoir.fantoir
;
