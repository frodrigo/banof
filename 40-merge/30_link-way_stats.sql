SELECT
    cadastre_osm_way.match_level,
    COUNT(*)
FROM
    cadastre_osm_way
GROUP BY
    cadastre_osm_way.match_level
;


SELECT
    "way matched",
    total,
    CAST("way matched" AS float) / total AS "percent"
FROM (
SELECT
(SELECT COUNT(DISTINCT osm_way_id) FROM cadastre_osm_way) AS "way matched",
(
SELECT
    COUNT(*)
FROM
    cadastre_street
    LEFT JOIN cadastre_osm_street ON -- Pas de correspondance déjà trouvé
        cadastre_osm_street.insee = cadastre_street.insee AND
        cadastre_osm_street.cadastre_street_id = cadastre_street.id
WHERE
    cadastre_osm_street.insee IS NULL
) AS total
) AS t
;
