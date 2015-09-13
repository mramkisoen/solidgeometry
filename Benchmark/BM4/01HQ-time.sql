EXPLAIN ANALYZE
SELECT a.*
FROM pernis.pipe3d a JOIN bpt ON ST_3DDWithin(geometry3d, rpoint, 5);
