EXPLAIN ANALYZE
SELECT a.pipeid, ST_3DArea(a.geometry3d)
FROM geo3d.pipe3d a
WHERE pipeid = 233;

--pipeid is changed to 1,3,5,7
