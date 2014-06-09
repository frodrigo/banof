ALTER TABLE ways ADD nom_can VARCHAR(255);
UPDATE ways SET nom_can = canonisation(tags->'name') WHERE tags?'name';
CREATE INDEX idx_ways_nom_can ON ways(nom_can);
