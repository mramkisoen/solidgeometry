DROP TABLE IF EXISTS inter;
CREATE TABLE inter AS
SELECT a.*
FROM geo3d.pipe3d a JOIN benchpoints ON ST_3DDWithin(geometry3d, rpoint, 5);

SELECT COUNT(a.*) total, COUNT(distinct a.pipeid) totalpipeid
FROM geo3d.pipe3d a JOIN benchpoints ON ST_3DDWithin(geometry3d, rpoint, 5);
