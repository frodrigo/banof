-- Match exact sur nom complet
--
INSERT INTO
    cadastre_fantoir
SELECT
    fantoir.insee,
    fantoir.fantoir,
    cadastre_street.id,
    1
FROM
    cadastre_street
    LEFT JOIN cadastre_fantoir ON -- Pas de correspondance déjà trouvé
        cadastre_fantoir.insee = cadastre_street.insee AND
        cadastre_fantoir.street_id = cadastre_street.id
    JOIN fantoir ON
        fantoir.insee = cadastre_street.insee AND
        COALESCE(fantoir.nature_voie || ' ', '') || fantoir.libelle_voie = cadastre_street.nom
WHERE
    cadastre_fantoir.insee IS NULL AND
    cadastre_street.nom IS NOT NULL AND
    cadastre_street.nom != ''
;
