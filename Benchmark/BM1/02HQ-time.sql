EXPLAIN ANALYZE
SELECT b.*
FROM inter a, inter b
WHERE a.pipeid <> b.pipeid
AND ST_3DIntersects(a.geometry3d,b.geometry3d) IS TRUE;
