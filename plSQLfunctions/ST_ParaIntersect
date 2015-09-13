CREATE OR REPLACE FUNCTION st_paraintersect(
    obj1 jsonb,
    obj2 jsonb)
  RETURNS boolean AS
$BODY$
DECLARE
 	cl1 geometry;
 	cl2 geometry;
 	
 	cl1p1 geometry;
 	cl1p2 geometry;
 	r1 float;
 	
 	cl2p1 geometry;
 	cl2p2 geometry;
 	r2 float;

 	dis float;

 	sline geometry;
BEGIN
	-- compute centerlines
	cl1p1 := ST_MakePoint((((obj1::json->'PointBegin')->'"X"')::text)::float, (((obj1::json->'PointBegin')->'"Y"')::text)::float, (((obj1::json->'PointBegin')->'"Z"')::text)::float);
	cl1p2 := ST_MakePoint((((obj1::json->'PointEnd')->'"X"')::text)::float, (((obj1::json->'PointEnd')->'"Y"')::text)::float, (((obj1::json->'PointEnd')->'"Z"')::text)::float);
	cl2p1 := ST_MakePoint((((obj2::json->'PointBegin')->'"X"')::text)::float, (((obj2::json->'PointBegin')->'"Y"')::text)::float, (((obj2::json->'PointBegin')->'"Z"')::text)::float);
	cl2p2 := ST_MakePoint((((obj2::json->'PointEnd')->'"X"')::text)::float, (((obj2::json->'PointEnd')->'"Y"')::text)::float, (((obj2::json->'PointEnd')->'"Z"')::text)::float);

	cl1 := ST_MakeLine(cl1p1,cl1p2);
	cl2 := ST_MakeLine(cl2p1,cl2p2);

	r1 := ((obj1::json->'Radius')::text)::float;
	r1 := ((obj2::json->'Radius')::text)::float;

	-- compute para intersection
	dis := ST_3DDistance(cl1,cl2);

	IF dis <( r1+r2) THEN
		--intersection candidate
		IF dis = 0 THEN
			return true;
		ELSE
			sline := ST_3DShortestLine(cl1,cl2);

			IF ST_3DIntersects(sline,cl1p1) IS TRUE THEN
				return ST_3DIntersection(ST_3Dreconstruct(obj1),ST_3Dreconstruct(obj2));
			END IF;

			IF ST_3DIntersects(sline,cl1p2) IS TRUE THEN
				return ST_3DIntersection(ST_3Dreconstruct(obj1),ST_3Dreconstruct(obj2));
			END IF;

			IF ST_3DIntersects(sline,cl2p1) IS TRUE THEN
				return ST_3DIntersection(ST_3Dreconstruct(obj1),ST_3Dreconstruct(obj2));
			END IF;

			IF ST_3DIntersects(sline,cl2p2) IS TRUE THEN
				return ST_3DIntersection(ST_3Dreconstruct(obj1),ST_3Dreconstruct(obj2));
			ELSE
				return true;
			END IF;
		END IF;
	ELSE
		return false;
	END IF;
END $BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
