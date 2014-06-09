psql -c "DELETE FROM relation_members WHERE relation_id < 0 OR member_id < 0"
psql -c "DELETE FROM nodes WHERE id < 0"
psql -c "DELETE FROM ways WHERE id < 0"
psql -c "DELETE FROM relations WHERE id < 0"
psql < 40_virtual-addr:housenumber.sql
psql < 40_virtual-associatedStreet-fantoir.sql
psql < 40_virtual-associatedStreet-addr:street.sql
