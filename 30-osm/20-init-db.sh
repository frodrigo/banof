psql <<EOF
DROP TABLE IF EXISTS actions CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS nodes CASCADE;
DROP TABLE IF EXISTS ways CASCADE;
DROP TABLE IF EXISTS way_nodes CASCADE;
DROP TABLE IF EXISTS relations CASCADE;
DROP TABLE IF EXISTS relation_members CASCADE;
DROP TABLE IF EXISTS schema_info CASCADE;
EOF

psql < ./osmosis/script/pgsnapshot_schema_0.6.sql
psql < ./osmosis/script/pgsnapshot_schema_0.6_linestring.sql
psql -c "SELECT AddGeometryColumn('relations', 'geom', 4326, 'GEOMETRY', 2);"
psql -c "CREATE INDEX idx_relation_geom ON cadastre_street USING gist(geom);"

psql -c "CREATE INDEX idx_ways_name_highway ON ways((tags->'name')) WHERE tags?'name' and tags?'highway';"
psql -c "CREATE INDEX idx_nodes_addrcity ON nodes((tags->'addr:city')) WHERE tags?'addr:city';"
