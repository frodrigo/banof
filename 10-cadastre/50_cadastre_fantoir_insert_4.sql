-- Match nom canonisé approximatif
--
INSERT INTO
    cadastre_fantoir
SELECT
    fantoir.insee,
    fantoir.fantoir,
    cadastre_street.id,
    4
FROM
    cadastre_street
    LEFT JOIN cadastre_fantoir ON -- Pas de correspondance déjà trouvé
        cadastre_fantoir.insee = cadastre_street.insee AND
        cadastre_fantoir.street_id = cadastre_street.id
    JOIN fantoir ON
        fantoir.insee = cadastre_street.insee AND
        levenshtein(fantoir.nom_can, cadastre_street.nom_can) <= 1
WHERE
    cadastre_fantoir.insee IS NULL AND
    cadastre_street.nom IS NOT NULL AND
    cadastre_street.nom != ''
;
