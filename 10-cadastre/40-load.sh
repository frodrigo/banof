psql < 40_cadastre.sql
bzcat data/adresses-street.csv.bz2 | psql -c "COPY cadastre_street(insee, id, nom) FROM STDIN WITH CSV"
bzcat data/adresses-number.csv.bz2 | psql -c "COPY cadastre_number(insee, street_id, lat, lon, numero) FROM STDIN WITH CSV"
bzcat data/noms.csv.bz2 | psql -c "COPY cadastre_noms FROM STDIN WITH CSV"
psql < 40_canonisation.sql
psql < 40_split_number.sql
