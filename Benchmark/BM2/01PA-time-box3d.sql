EXPLAIN ANALYZE
SELECT a.*
FROM geo3d.pipe3dp a JOIN benchpoints ON ST_3DDWithin(ST_bboxlinebox(attributes), rpoint, 5)
WHERE ST_3DDWithin(ST_3Dreconstruct(attributes), rpoint, 5) is true;
