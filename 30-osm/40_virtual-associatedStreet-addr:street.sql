INSERT INTO
    relations
SELECT
    -MIN(ABS(nodes.id)) AS id,
    0 AS version,
    MIN(nodes.user_id) AS user_id,
    MIN(nodes.tstamp) AS tstamp,
    MIN(nodes.changeset_id) AS changeset_id,
    hstore(ARRAY[
        ['type', 'associatedStreet'],
        ['name', MIN(nodes.tags->'addr:street')],
        ['addr:city', MIN(nodes.tags->'addr:city')]
    ]) AS tags
FROM
    nodes
    LEFT JOIN relation_members ON
        relation_members.member_type = 'N' AND
        relation_members.member_id = nodes.id
    LEFT JOIN relations ON
        relations.id = relation_members.relation_id AND
        relations.tags->'type' = 'associatedStreet'
    JOIN ways ON
        ST_DWithin(ways.linestring, nodes.geom, 0.005) AND -- FIXME Unité en degrés, passer en m
        ways.tags?'highway' AND
        ways.tags?'name' AND
        ways.tags->'name' = nodes.tags->'addr:street'
WHERE
    relations.id IS NULL AND
    nodes.tags?'addr:housenumber' AND
    nodes.tags?'addr:street' AND
    nodes.tags?'addr:city'
GROUP BY
    nodes.tags->'addr:street',
    nodes.tags->'addr:city'
;


INSERT INTO
    relation_members
SELECT
    relation_id,
    id AS member_id,
    'N' AS member_type,
    'house' AS member_role,
    row_number() over() AS sequence_id
FROM
    nodes
    JOIN (SELECT
        -MIN(ABS(nodes.id)) AS relation_id,
        nodes.tags->'addr:street' AS street,
        nodes.tags->'addr:city' AS city
    FROM
        nodes
        LEFT JOIN relation_members ON
            relation_members.member_type = 'N' AND
            relation_members.member_id = nodes.id
        LEFT JOIN relations ON
            relations.id = relation_members.relation_id AND
            relations.tags->'type' = 'associatedStreet'
        JOIN ways ON
            ST_DWithin(ways.linestring, nodes.geom, 0.005) AND -- FIXME Unité en degrés, passer en m
            ways.tags?'highway' AND
            ways.tags?'name' AND
            ways.tags->'name' = nodes.tags->'addr:street'
    WHERE
        relations.id IS NULL AND
        nodes.tags?'addr:housenumber' AND
        nodes.tags?'addr:street' AND
        nodes.tags?'addr:city'
    GROUP BY
        nodes.tags->'addr:street',
        nodes.tags->'addr:city'
    ) AS t ON
        nodes.tags->'addr:street' = street AND
        nodes.tags->'addr:city' = city
WHERE
    nodes.tags?'addr:housenumber' AND
    nodes.tags?'addr:street' AND
    nodes.tags?'addr:city'
;
