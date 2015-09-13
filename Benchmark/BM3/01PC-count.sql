SELECT COUNT(a.*) total, COUNT(distinct a.pipeid) totalpipeid
FROM geo3d.pipe3dp3 a JOIN benchpoints ON ST_3DDWithin(bbox3d, rpoint, 5)
WHERE ST_3DDWithin(ST_3Dreconstruct(attributes), rpoint, 5) is true;
