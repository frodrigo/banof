DROP TABLE IF EXISTS fantoir CASCADE;
CREATE TABLE fantoir (
    insee CHAR(5) NOT NULL,
    fantoir CHAR(5) NOT NULL,
    nature_voie VARCHAR(4),
    libelle_voie VARCHAR(26) NOT NULL,
    caractere_annul CHAR(1),
    type_voie CHAR(1),
    lieu_dit_bati CHAR(1),
    nom_can VARCHAR(255),
    PRIMARY KEY(insee, fantoir)
);

CREATE INDEX idx_fantoir_insee ON fantoir(insee);
