SELECT COUNT(a.*) total, COUNT(distinct a.pipeid) totalpipeid
FROM geo3d.pipe3drbb a JOIN benchpoints ON ST_3DDWithin(rbb, rpoint, 5)
WHERE ST_3DDWithin(ST_3Dreconstruct(attributes), rpoint, 5) is true;
