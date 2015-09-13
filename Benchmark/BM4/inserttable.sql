INSERT INTO pernis.pipe3dp
SELECT *, ST_bboxlinebox(attributes)
FROM temptable
WHERE (attributes->'Type')::text='"Cylinder"';

INSERT INTO pernis.pipe3d
SELECT pipeid, ST_3Dreconstruct(attributes)
FROM pernis.pipe3dp;
