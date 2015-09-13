EXPLAIN ANALYZE
SELECT b.*
FROM interpara a, interpara b
WHERE a.pipeid <> b.pipeid
AND ST_ParaIntersect(a.attributes,b.attributes) IS TRUE;
