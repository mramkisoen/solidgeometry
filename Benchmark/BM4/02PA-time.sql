EXPLAIN ANALYZE
SELECT b.*
FROM interp a, interp b
WHERE a.pipeid <> b.pipeid
AND ST_ParaIntersect3(a.attributes,b.attributes) IS TRUE;
