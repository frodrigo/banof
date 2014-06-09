UPDATE
    relations
SET
    tags = t.tags
FROM (
    SELECT
        relations.id,
        tags - 'addr:city'::text || hstore(ARRAY['ref:FR:INSEE', insee]) AS tags
    FROM
        relations
        JOIN communes ON
            relations.geom && communes.the_geom AND
            replace(lower(tags->'addr:city'), '-', ' ') = replace(lower(communes.nom), '-', ' ')
    WHERE
        tags->'type' = 'associatedStreet' AND
        NOT tags?'ref:FR:FANTOIR' AND -- TODO normaliser les FANTOIR
        NOT tags?'ref:FR:INSEE' AND
        tags?'addr:city'
    ) AS t
WHERE
    relations.id = t.id
;
