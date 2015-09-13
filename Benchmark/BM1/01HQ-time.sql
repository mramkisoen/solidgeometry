EXPLAIN ANALYZE
SELECT a.*
FROM geo3d.pipe3d a JOIN benchpoints ON ST_3DDWithin(geometry3d, rpoint, 5);
