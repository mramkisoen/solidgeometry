DROP TABLE IF EXISTS bpt;

CREATE TABLE bpt as
SELECT randompointsinpolygon3d(st_3dextent(pipe3d.geometry3d), 200) AS rpoint
FROM pernis.pipe3d;
