SELECT COUNT(b.*) total, COUNT(distinct b.pipeid) totalpipeid
FROM interpara a, interpara b
WHERE a.pipeid <> b.pipeid
AND ST_ParaIntersect(a.attributes,b.attributes) IS TRUE;
