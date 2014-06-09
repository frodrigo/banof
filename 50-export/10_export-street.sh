psql -t -A -F"," < 10_export_street-cadastre_osm_street.sql > banof-raw-street.csv
psql -t -A -F"," < 10_export_street-cadastre_osm_way.sql >> banof-raw-street.csv
