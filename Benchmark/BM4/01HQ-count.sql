DROP TABLE IF EXISTS inter;
CREATE TABLE inter AS
SELECT a.*
FROM pernis.pipe3d a JOIN bpt ON ST_3DDWithin(geometry3d, rpoint, 5);

SELECT COUNT(a.*) total, COUNT(distinct a.pipeid) totalpipeid
FROM pernis.pipe3d a JOIN bpt ON ST_3DDWithin(geometry3d, rpoint, 5);
