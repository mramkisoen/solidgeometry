CREATE OR REPLACE FUNCTION st_rbbox(j jsonb)
  RETURNS geometry AS
$BODY$
DECLARE
 	poly geometry;
 BEGIN
 	poly := __st_3DCylinder22bb(j::json->'PointBegin', j::json->'PointEnd', ((j::json->'Radius')::text)::float);
 	return poly;
END $BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
