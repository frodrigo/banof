psql -t -A -F"," < 40_export_street-cadastre_osm_street.sql > banof-street.csv
psql -t -A -F"," < 40_export_street-cadastre_osm_way.sql >> banof-street.csv
