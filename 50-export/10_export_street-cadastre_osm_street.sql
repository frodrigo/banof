SELECT
    array_agg(CASE
        WHEN osm_street.id < 0 THEN 'VR'
        ELSE 'R'
    END) AS osm_type,
    ARRAY[osm_street.id] AS osm_id,
    ARRAY[osm_street.nom] AS osm_nom,
    ARRAY[osm_street.insee] AS osm_insee,
    ARRAY[osm_street.fantoir] AS osm_fantoir,
    array_agg(cadastre_street.nom) AS cadastre_nom,
    array_agg(cadastre_street.insee) AS cadastre_insee,
    array_agg(cadastre_fantoir.fantoir) AS cadastre_fantoir,
    array_agg(cadastre_street.id) AS cadastre_street_id,
    array_agg(cadastre_osm_street.match_level) AS match_level
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
