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
 	bpx := (((j::json->'PointBegin')->'"X"')::text)::float;
 	bpy := (((j::json->'PointBegin')->'"Y"')::text)::float;
 	bpz := (((j::json->'PointBegin')->'"Z"')::text)::float;

 	epx := (((j::json->'PointEnd')->'"X"')::text)::float;
 	epy := (((j::json->'PointEnd')->'"Y"')::text)::float;
 	epz := (((j::json->'PointEnd')->'"Z"')::text)::float;

 	r := ((j::json->'Radius')::text)::float;

 	p1 := ST_MakePoint(bpx,bpy,bpz);
 	p2 := ST_MakePoint(epx,epy,epz);

 	IF p1 < p2 THEN
		poly := ST_CircelPoly02bb(j::json->'PointBegin',r,ST_3DLength(ST_MakeLine(p1,p2)),p2);
		xmin := ST_Xmin(poly);
		ymin := ST_Ymin(poly);
		zmin := ST_Zmin(poly);
		poly := ST_CircelPoly02bb(j::json->'PointEnd',r,ST_3DLength(ST_MakeLine(p1,p2)),p1);
		xmax := ST_Xmax(poly);
		ymax := ST_Ymax(poly);
		zmax := ST_Zmax(poly);
	ELSE
		poly := ST_CircelPoly02bb(j::json->'PointEnd',r,ST_3DLength(ST_MakeLine(p1,p2)),p1);
		xmin := ST_Xmin(poly);
		ymin := ST_Ymin(poly);
		zmin := ST_Zmin(poly);
		poly := ST_CircelPoly02bb(j::json->'PointBegin',r,ST_3DLength(ST_MakeLine(p1,p2)),p2);
		xmax := ST_Xmax(poly);
		ymax := ST_Ymax(poly);
		zmax := ST_Zmax(poly);
	END IF;

 	poly := ST_MakeBox2D(ST_MakePoint(xmin,ymin),ST_MakePoint(xmax,ymax))::geometry;
  	poly := ST_Force3D(poly);
  	poly := ST_Translate(poly,0,0,zmin);
   	poly := ST_Extrude(poly,0,0,(zmax-zmin));
  	return poly;		
END $BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
