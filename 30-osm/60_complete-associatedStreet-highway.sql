INSERT INTO
    relation_members
SELECT
    relations.id AS relation_id,
    ways.id AS member_id,
    'W' AS member_type,
    'street' AS member_role,
    row_number() over() AS sequence_id
FROM
    relations
    JOIN ways ON
        ways.linestring && relations.geom AND
        ways.id NOT IN (
            SELECT
                relation_members.member_id
            FROM
                relation_members
            WHERE
                relation_members.relation_id = relations.id AND
                relation_members.member_type = 'W' AND
                relation_members.member_role = 'street'
        ) AND
        ways.tags?'highway' AND
        ways.tags->'name' = relations.tags->'name'
WHERE
    relations.tags->'type' = 'associatedStreet'
;
