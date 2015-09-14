CREATE OR REPLACE FUNCTION st_bbox(geo geometry)
  RETURNS geometry AS
$BODY$
DECLARE
 	poly geometry;
 	zmin float;
 	zmax float;
 	h float;
 BEGIN
	--box3d creation
	poly := box3d(geo)::geometry;
	
 	--z min and max
 	zmin := ST_Zmin(geo);
 	zmax := ST_Zmax(geo);
 	h := zmax-zmin;
 	
  	poly := ST_Force3D(poly);
  	poly := ST_Translate(poly,0,0,zmin);
  	poly := ST_Extrude(poly,0,0,h);
 	return poly;
END $BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;

CREATE OR REPLACE FUNCTION st_bbox(j jsonb)
  RETURNS geometry AS
$BODY$
DECLARE
 	poly geometry;
 BEGIN
 	poly := __st_3DCylinder22bb(j::json->'PointBegin', j::json->'PointEnd', ((j::json->'Radius')::text)::float);
 	return ST_bbox(poly);
END $BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
