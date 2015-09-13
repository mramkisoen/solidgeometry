CREATE OR REPLACE FUNCTION st_circelpoly(
    centerpoint json,
    r double precision,
    h double precision,
    h_point geometry)
  RETURNS geometry AS
$BODY$
DECLARE
 	cx float;
 	cy float;
 	cz float;
 	hx float;
 	hy float;

 	qs integer;

 	base geometry;
	base_r geometry;
	centerpt geometry;

 	centerline geometry;
 	basenormal geometry;
 	temp_pt geometry;
 	ret geometry;

 	angle float;
 	angle2 float;

 BEGIN
 	--extract xyz and construct normals and centerpoint
 	cx := ((centerpoint->'X')::text)::float;
 	cy := ((centerpoint->'Y')::text)::float;
 	cz := ((centerpoint->'Z')::text)::float;
 	hx := ST_X(h_point);
 	hy := ST_Y(h_point);

 	--quad segment
 	qs := 8; --set 16 for 3D visualization
 	
--  	IF r>0.3 THEN --only for 3D visualization
-- 		qs := 32; 
-- 	END IF;

 	centerpt := ST_MakePoint(cx, cy, cz);
 	basenormal := ST_MakePoint(cx, cy, cz+h);

	--base reconstruction
	base := ST_Translate(ST_Force3DZ(ST_Buffer(ST_MakePoint(0,0,0),r,qs)), cx, cy, cz);

	IF hx <> cx AND hy <> cy THEN
		-- rotation computations
		angle := __ST_DotProd(centerpt, basenormal, h_point);

		-- rotation incl. translation to y-axis thus x=0
		temp_pt := ST_Translate(ST_RotateY(ST_Translate(basenormal, -cx, 0, -cz), angle), cx,0, cz);
		base_r := ST_Translate(ST_RotateY(ST_Translate(base, -cx, 0, -cz), angle), cx, 0, cz);

		-- second rotation computation
		angle2 := ST_Azimuth(temp_pt, h_point)*2;
		ret := ST_Rotate(base_r, -angle2,centerpt);
	ELSE
		ret := base;
	END IF;
	
	return ret;
	
END $BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
