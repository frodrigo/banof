CREATE TEMP TABLE thull AS
SELECT
    relations.id AS id,
    ST_ConvexHull(ST_Collect(nodes.geom)) AS hull
FROM
    relations
    JOIN relation_members ON
        relation_members.relation_id = relations.id AND
        relation_members.member_type = 'N'
    JOIN nodes ON
        nodes.id = relation_members.member_id AND
        nodes.tags?'addr:housenumber'
WHERE
    relations.tags->'type' = 'associatedStreet'
GROUP BY
    relations.id
;


UPDATE
    relations
SET
    geom = hull
FROM
    thull
WHERE
    relations.id = thull.id
;
