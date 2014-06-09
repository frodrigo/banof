psql < 11_fantoir.sql
bzcat FANTOIR.txt.bz2 | ruby 11_split_fantoir.rb | psql -c "COPY fantoir(insee, fantoir, nature_voie, libelle_voie, caractere_annul, type_voie, lieu_dit_bati) FROM STDIN DELIMITER '~' NULL AS ''"
psql < 11_canonisation.sql
