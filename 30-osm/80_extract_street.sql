INSERT INTO
    osm_street
SELECT
    id,
    substring(tags->'ref:FR:FANTOIR' FROM 1 FOR 5) AS insee,
    substring(tags->'ref:FR:FANTOIR' FROM 6 FOR 5) AS fantoir,
    tags->'name' AS nom -- TODO prend tous les noms, et des ways aussi
FROM
    relations
WHERE
    tags->'type' = 'associatedStreet' AND
    tags?'ref:FR:FANTOIR' AND
    length(tags->'ref:FR:FANTOIR') = 10
;


INSERT INTO
    osm_street
SELECT
    id,
    tags->'ref:FR:INSEE' AS insee,
    NULL AS fantoir,
    tags->'name' AS nom
FROM
    relations
WHERE
    tags->'type' = 'associatedStreet' AND
    NOT tags?'ref:FR:FANTOIR' AND
    tags?'ref:FR:INSEE' AND
    length(tags->'ref:FR:INSEE') = 5
;


UPDATE
    osm_street
SET
    nom_can = canonisation(nom)
;
