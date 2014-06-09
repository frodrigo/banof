# as user postgres
psql fred < /usr/share/postgresql/9.1/contrib/postgis-1.5/postgis.sql
psql fred < /usr/share/postgresql/9.1/contrib/postgis-1.5/spatial_ref_sys.sql
psql -d fred -c "GRANT ALL ON geometry_columns TO PUBLIC;"
psql -d fred -c "GRANT ALL ON geography_columns TO PUBLIC;"
psql -d fred -c "GRANT ALL ON spatial_ref_sys TO PUBLIC;"
psql -d fred -c "CREATE EXTENSION hstore";
psql -d fred -c "CREATE EXTENSION fuzzystrmatch";
