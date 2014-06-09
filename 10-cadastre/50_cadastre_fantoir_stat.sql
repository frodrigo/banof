SELECT
    match_level,
    n AS "nb ref FANTOIR",
    COUNT(*)
FROM
(
SELECT
    match_level,
    COUNT(*) AS n
FROM
    cadastre_street
    JOIN cadastre_fantoir ON
        cadastre_fantoir.insee = cadastre_street.insee AND
        cadastre_fantoir.street_id = cadastre_street.id
    JOIN fantoir ON
        fantoir.insee = cadastre_fantoir.insee AND
        fantoir.fantoir = cadastre_fantoir.fantoir
GROUP BY
    match_level,
    cadastre_street.insee,
    cadastre_street.id
) AS t
GROUP BY
    match_level,
    n
ORDER BY
    match_level,
    n
;

SELECT
    (SELECT COUNT(DISTINCT(insee, street_id)) FROM cadastre_fantoir) AS ref_fantoir,
    (SELECT COUNT(*) FROM cadastre_street) AS cadastre_street,
    (SELECT cast(COUNT(DISTINCT(insee, street_id)) as float) FROM cadastre_fantoir) / (SELECT COUNT(*) FROM cadastre_street) AS percent
;
