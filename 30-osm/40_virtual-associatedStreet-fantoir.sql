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
        ['name', MIN(nodes.tags->'name')],
        ['ref:FR:FANTOIR', nodes.tags->'ref:FR:FANTOIR']
    ]) AS tags
FROM
    nodes
    LEFT JOIN relation_members ON
        relation_members.member_type = 'N' AND
        relation_members.member_id = nodes.id
    LEFT JOIN relations ON
        relations.id = relation_members.relation_id AND
        relations.tags->'type' = 'associatedStreet'
WHERE
    relations.id IS NULL AND
    nodes.tags?'addr:housenumber' AND
    nodes.tags?'ref:FR:FANTOIR'
GROUP BY
    nodes.tags->'ref:FR:FANTOIR'
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
        nodes.tags->'ref:FR:FANTOIR' AS fantoir
    FROM
        nodes
        LEFT JOIN relation_members ON
            relation_members.member_type = 'N' AND
            relation_members.member_id = nodes.id
        LEFT JOIN relations ON
            relations.id = relation_members.relation_id AND
            relations.tags->'type' = 'associatedStreet'
    WHERE
        relations.id IS NULL AND
        nodes.tags?'addr:housenumber' AND
        nodes.tags?'ref:FR:FANTOIR'
    GROUP BY
        nodes.tags->'ref:FR:FANTOIR'
    ) AS t ON
        nodes.tags->'ref:FR:FANTOIR' = fantoir
WHERE
    nodes.tags?'addr:housenumber' AND
    nodes.tags?'ref:FR:FANTOIR'
;

-- TODO ajouter les way avec fantoir
-- completer la relation fantoir s'il existe
