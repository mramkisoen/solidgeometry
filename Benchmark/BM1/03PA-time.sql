EXPLAIN ANALYZE
SELECT a.pipeid, st_cylinderarea(a.attributes)
FROM geo3d.pipe3dp a
WHERE pipeid = 233;

--pipeid is changed to 1,3,5,7
