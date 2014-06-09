INSERT INTO
    cadastre_osm_way
SELECT
    cadastre_street.insee,
    cadastre_street.id,
    ways.id,
    4
FROM
    cadastre_street
    LEFT JOIN cadastre_osm_street ON -- Pas de correspondance déjà trouvé
        cadastre_osm_street.insee = cadastre_street.insee AND
        cadastre_osm_street.cadastre_street_id = cadastre_street.id
    JOIN ways ON
        ways.linestring && cadastre_street.geom AND
        ways.tags?'highway' AND
        ways.tags?'name' AND
        levenshtein(ways.nom_can, cadastre_street.nom_can) <= 3
    LEFT JOIN cadastre_osm_way ON -- Pas de correspondance déjà trouvé
        cadastre_osm_way.insee = cadastre_street.insee AND
        cadastre_osm_way.cadastre_street_id = cadastre_street.id
WHERE
    cadastre_osm_street.insee IS NULL AND
    cadastre_osm_way.insee IS NULL
;
