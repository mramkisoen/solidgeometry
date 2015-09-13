DROP TABLE IF EXISTS interpara;
CREATE TABLE interpara AS
SELECT a.*
FROM geo3d.pipe3dp a JOIN benchpoints ON ST_3DDWithin(ST_bboxline(attributes), rpoint, 5)
WHERE ST_3DDWithin(ST_3Dreconstruct(a.attributes), rpoint, 5) is true;

SELECT COUNT(a.*) total, COUNT(distinct a.pipeid) totalpipeid
FROM geo3d.pipe3dp a JOIN benchpoints ON ST_3DDWithin(ST_bboxline(attributes), rpoint, 5)
WHERE ST_3DDWithin(ST_3Dreconstruct(attributes), rpoint, 5) is true;
