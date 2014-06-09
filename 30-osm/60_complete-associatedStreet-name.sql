UPDATE
    relations
SET
    tags = tags || hstore(ARRAY['name', name])
FROM (
    SELECT
        relations.id,
        COALESCE(ways.tags->'name') AS name
    FROM
        relations
        JOIN relation_members ON
            relation_members.relation_id = relations.id AND
            relation_members.member_type = 'W' AND
            relation_members.member_role = 'street'
        JOIN ways ON
            ways.id = relation_members.member_id AND
            ways.tags?'name'
    WHERE
        relations.tags->'type' = 'associatedStreet' AND
        NOT relations.tags?'name'
    ) AS t
WHERE
    NOT relations.tags?'name' AND
    relations.id = t.id
;
