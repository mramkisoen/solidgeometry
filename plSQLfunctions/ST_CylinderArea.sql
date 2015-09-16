CREATE OR REPLACE FUNCTION st_cylinderarea(att jsonb)
  RETURNS double precision AS
$BODY$
DECLARE
  r float;
  ptb geometry;
  pte geometry;
  ret float;
  l float;
BEGIN
  r := (((att->'Radius')::text)::float);
  ptb := ST_MakePoint((((att->'PointBegin')->'X')::text)::float, (((att->'PointBegin')->'Y')::text)::float, (((att->'PointBegin')->'Z')::text)::float);
  pte := ST_MakePoint((((att->'PointEnd')->'X')::text)::float, (((att->'PointEnd')->'Y')::text)::float, (((att->'PointEnd')->'Z')::text)::float);

  l := ST_3DLength(ST_MakeLine(ptb,pte));

  ret := r*r*pi() + r*2*pi()*l;
  return ret;
  
END $BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
