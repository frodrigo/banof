TRUNCATE osm_number;
INSERT INTO
    osm_number
SELECT
    relations.id AS street_id,
    nodes.tags->'addr:housenumber' AS number,
    (canonisation_numero(nodes.tags->'addr:housenumber')).numero_i,
    (canonisation_numero(nodes.tags->'addr:housenumber')).ext,
    ST_Y(nodes.geom) AS lat,
    ST_X(nodes.geom) AS lon
FROM
    relations
    JOIN relation_members ON
        relation_members.relation_id = relations.id AND
        relation_members.member_type = 'N'
    JOIN nodes ON
        nodes.id = relation_members.member_id AND
        nodes.tags?'addr:housenumber'
WHERE
    relations.tags->'type' = 'associatedStreet' AND
    (
        relations.tags?'ref:FR:FANTOIR' AND
        length(relations.tags->'ref:FR:FANTOIR') = 10
    ) OR (
        relations.tags?'ref:FR:INSEE' AND
        length(relations.tags->'ref:FR:INSEE') = 5
    )
;
