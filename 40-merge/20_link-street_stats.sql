SELECT
    match_level,
    n AS "nb cadastre",
    COUNT(*)
FROM
(
SELECT
    match_level,
    COUNT(*) AS n
FROM
    cadastre_osm_street
GROUP BY
    match_level,
    osm_street_id
) AS t
GROUP BY
    match_level,
    n
ORDER BY
    match_level,
    n
;

SELECT
    (SELECT COUNT(DISTINCT(osm_street_id)) FROM cadastre_osm_street) AS "link cadastre",
    (SELECT COUNT(*) FROM osm_street) AS osm_street,
    (SELECT cast(COUNT(DISTINCT(osm_street_id)) as float) FROM cadastre_osm_street) / (SELECT COUNT(*) FROM osm_street) AS percent
;
