DROP TABLE IF EXISTS interp;

CREATE TABLE interp AS
SELECT a.*
FROM pernis.pipe3dp a JOIN bpt ON ST_3DDWithin(bbox3d, rpoint, 5)
WHERE ST_3DDWithin(ST_3Dreconstruct(attributes), rpoint, 5) is true;

SELECT COUNT(a.*) total, COUNT(distinct a.pipeid) totalpipeid
FROM pernis.pipe3dp a JOIN bpt ON ST_3DDWithin(bbox3d, rpoint, 5)
WHERE ST_3DDWithin(ST_3Dreconstruct(attributes), rpoint, 5) is true;
