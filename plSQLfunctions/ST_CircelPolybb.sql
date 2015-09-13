CREATE OR REPLACE FUNCTION st_circelpolybb(
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

 	tp geometry;
 	hp geometry;
 	p1 geometry;
 	p2 geometry;
 	p3 geometry;
 	p4 geometry;

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

 	centerpt := ST_MakePoint(cx, cy, cz);
 	basenormal := ST_MakePoint(cx, cy, cz+h);

 	p1 := ST_MakePoint(cx-r,cy+r,cz);
 	p2 := ST_MakePoint(cx+r,cy+r,cz);
 	p3 := ST_MakePoint(cx+r,cy-r,cz);
 	p4 := ST_MakePoint(cx-r,cy-r,cz);

	--base reconstruction
	base := ST_MakePolygon(ST_MakeLine(ARRAY[p1,p2,p3,p4,p1]));

	IF hx <> cx AND hy <> cy THEN
		-- rotation computations
		angle := __ST_DotProd(centerpt, basenormal, h_point);

		-- rotation incl. translation to y-axis thus x=0
		temp_pt := ST_Translate(ST_RotateY(ST_Translate(basenormal, -cx, 0, -cz), angle), cx,0, cz);
		base_r := ST_Translate(ST_RotateY(ST_Translate(base, -cx, 0, -cz), angle), cx, 0, cz);

		-- second rotation computation
		angle2 := ST_Azimuth(temp_pt, h_point)*2; --noodoptie beste
		ret := ST_Rotate(base_r, -angle2,centerpt);
	ELSE
		ret := base;
	END IF;
	
	return ret;
	
END $BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
