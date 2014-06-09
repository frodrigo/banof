shp2pgsql -W LATIN1 -d communes/communes-20140306-5m.shp communes | bzip2 -- > communes/communes.sql.bz2
bzcat communes/communes.sql.bz2 | psql
psql -c "CREATE UNIQUE INDEX idx_communes_insee ON communes(insee);"
psql -c "CREATE INDEX idx_communes_the_geom ON communes USING gist (the_geom);"
