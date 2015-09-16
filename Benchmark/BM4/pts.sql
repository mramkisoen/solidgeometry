DROP TABLE if exists bpt;

create table bpt as
SELECT randompointsinpolygon3d(st_3dextent(pipe3d.geometry3d), 200) AS rpoint
FROM pernis.pipe3d;
