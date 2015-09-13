CREATE OR REPLACE FUNCTION st_3dreconstruct(j jsonb)
  RETURNS geometry AS
$BODY$
DECLARE
 	geo geometry;
 BEGIN
	geo := __st_3dcylinder((j -> 'PointBegin'::text)::json, (j -> 'PointEnd'::text)::json, ((j -> 'Radius'::text)::text)::double precision);
 	return geo;
END $BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
