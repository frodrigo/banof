SELECT
    array_agg(CASE
        WHEN ways.id IS NOT NULL THEN 'W'
    END) AS osm_type,
    array_agg(ways.id) AS osm_id,
    array_agg(ways.tags->'name') AS osm_nom,
    array_agg(substring(tags->'ref:FR:FANTOIR' FROM 1 FOR 5)) AS osm_insee,
    array_agg(substring(tags->'ref:FR:FANTOIR' FROM 6 FOR 5)) AS osm_fantoir,
    ARRAY[cadastre_street.nom] AS cadastre_nom,
    ARRAY[cadastre_street.insee] AS cadastre_insee,
    array_agg(cadastre_fantoir.fantoir) AS cadastre_fantoir,
    ARRAY[cadastre_street.id] AS cadastre_id,
    array_agg(cadastre_osm_way.match_level) AS match_level
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
    cadastre_street.nom
;
