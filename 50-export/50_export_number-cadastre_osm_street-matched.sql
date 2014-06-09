SELECT
    'osm'||osm_number.street_id AS id,
    osm_number.lat AS lat,
    osm_number.lon AS lon,
    osm_number.numero AS numero
FROM
    osm_number
GROUP BY
    'osm'||osm_number.street_id,
    osm_number.lat,
    osm_number.lon,
    osm_number.numero
;
