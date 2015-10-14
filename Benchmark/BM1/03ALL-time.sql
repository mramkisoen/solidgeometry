SELECT a.pipeid, a.geometry3d, b.attributes, ST_3DArea(a.geometry3d), St_CylinderArea(b.attributes)
FROM geo3d.pipe3d a JOIN geo3d.pipe3dp b ON a.pipeid = b.pipeid
WHERE a.pipeid = 1
OR a.pipeid = 3
OR a.pipeid = 5
OR a.pipeid = 7
OR a.pipeid = 233;
