CREATE TEMP TABLE thull AS
SELECT
    cadastre_street.insee,
    cadastre_street.id,
    ST_Buffer(ST_ConvexHull(ST_Collect(ST_MakePoint(lon, lat)))::geography, 200)::geometry AS hull
FROM
    cadastre_street
    JOIN cadastre_number ON
        cadastre_number.insee = cadastre_street.insee AND
        cadastre_number.street_id = cadastre_street.id
GROUP BY
    cadastre_street.insee,
    cadastre_street.id
;


UPDATE
    cadastre_street
SET
    geom = hull
FROM
    thull
WHERE
    thull.insee = cadastre_street.insee AND
    thull.id = cadastre_street.id
;
