DROP TABLE if exists bpt;

create table bpt as
SELECT st_translate(randompointsinpolygon3d(st_3dextent(pipe3d.geometry3d)::geometry, 100), 0::double precision, 0::double precision, random() * (st_zmax(st_3dextent(pipe3d.geometry3d)) - st_zmin(st_3dextent(pipe3d.geometry3d))) + st_zmin(st_3dextent(pipe3d.geometry3d))) AS rpoint
FROM pernis.pipe3d;
