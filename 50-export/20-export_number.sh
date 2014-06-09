psql -t -A -F"," < 20_export_number-cadastre_osm_way.sql > banof-raw-number.csv
psql -t -A -F"," < 20_export_number-cadastre_osm_street-cadastre.sql >> banof-raw-number.csv
psql -t -A -F"," < 20_export_number-cadastre_osm_street-matched.sql >> banof-raw-number.csv
