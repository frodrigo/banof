CREATE TEMP TABLE thull AS
SELECT
    id,
    ST_Buffer(ST_ConvexHull(ST_Collect(ST_MakePoint(lon, lat)))::geography, 200)::geometry AS hull
FROM
    osm_street
    JOIN osm_number ON
        osm_number.street_id = osm_street.id
GROUP BY
    osm_street.id
;


UPDATE
    osm_street
SET
    geom = hull
FROM
    thull
WHERE
    osm_street.id = thull.id
;
