INSERT INTO
    nodes
SELECT
    -id AS id,
    version,
    user_id,
    tstamp,
    changeset_id,
    tags,
    ST_Centroid(linestring) AS geom
FROM
    ways
WHERE
    ways.tags?'addr:housenumber'
;

UPDATE
    relation_members
SET
    member_id = -ways.id,
    member_type = 'N'
FROM
    ways
WHERE
    member_type = 'W' AND
    relation_members.member_id = ways.id AND
    ways.tags?'addr:housenumber'
;
