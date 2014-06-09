./osmosis/bin/osmosis \
    --rb france.osm.pbf \
        --tf accept-relations type=associatedStreet \
        --used-way --used-node \
    --rb france.osm.pbf \
        --tf reject-relations \
        --tf accept-ways addr:housenumber=* \
        --used-node \
    --merge \
    --rb france.osm.pbf \
        --tf reject-relations \
        --tf reject-ways \
        --tf accept-nodes addr:housenumber=* \
    --merge \
    --rb france.osm.pbf \
        --tf reject-relations \
        --tf accept-ways highway=* \
        --tf accept-ways name=* \
        --used-node \
    --merge \
    --wb france-addr.osm.pbf

# TODO découper exactement la France
