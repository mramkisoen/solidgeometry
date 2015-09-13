CREATE OR REPLACE FUNCTION st_bboxline(j jsonb)
  RETURNS geometry AS
$BODY$
DECLARE
 	bpx float;
 	bpy float;
 	bpz float;

 	epx float;
 	epy float;
 	epz float;

 	r float;

	xmax float;
	ymax float;
 	zmax float;
 	xmin float;
 	ymin float;
 	zmin float;

 	p1 geometry;
 	p2 geometry;

 	poly geometry;
 BEGIN
 	bpx := (((j::json->'PointBegin')->'X')::text)::float;
 	bpy := (((j::json->'PointBegin')->'Y')::text)::float;
 	bpz := (((j::json->'PointBegin')->'Z')::text)::float;

 	epx := (((j::json->'PointEnd')->'X')::text)::float;
 	epy := (((j::json->'PointEnd')->'Y')::text)::float;
 	epz := (((j::json->'PointEnd')->'Z')::text)::float;

 	r := ((j::json->'Radius')::text)::float;

 	poly := ST_MakeLine(ST_MakePoint(bpx,bpy,bpz), ST_MakePoint(epx,epy,epz));
  	xmin := ST_Xmin(poly);
 	ymin := ST_Ymin(poly);
  	zmin := ST_Zmin(poly);
  	xmax := ST_Xmax(poly);
 	ymax := ST_Ymax(poly);
  	zmax := ST_Zmax(poly);

  	poly := ST_MakeBox2D(ST_MakePoint(xmin-r,ymin-r), ST_MakePoint(xmax+r,ymax+r))::geometry;

   	poly := ST_Force3D(poly);
   	poly := ST_Translate(poly,0,0,zmin-r);
    	poly := ST_Extrude(poly,0,0,((zmax+r)-(zmin-r)));	
 	return poly;
END $BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
