DROP TABLE IF EXISTS temptable;
CREATE TABLE temptable AS
SELECT pipeid, jsonb_array_elements(geometryjson->'Attributes') attributes
FROM pernis.pipes;
