UPDATE
    fantoir
SET
    nom_can = canonisation(COALESCE(fantoir.nature_voie || ' ', '') || fantoir.libelle_voie)
;
