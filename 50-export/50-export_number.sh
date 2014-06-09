psql -t -A -F"," < 50_export_number-cadastre_osm_way.sql > banof-number.csv
psql -t -A -F"," < 50_export_number-cadastre_osm_street-cadastre.sql >> banof-number.csv
psql -t -A -F"," < 50_export_number-cadastre_osm_street-matched.sql >> banof-number.csv
