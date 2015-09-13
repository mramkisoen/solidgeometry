CREATE OR REPLACE FUNCTION __st_3dcylinderbb(
    bp json,
    ep json,
    r double precision)
  RETURNS geometry AS
$BODY$
DECLARE

BEGIN
	return ST_Extrude(
		ST_CircelPolybb(bp, r, ST_3DLength(ST_MakeLine(ST_MakePoint(((bp->'X')::text)::float, ((bp::json->'Y')::text)::float, ((bp::json->'Z')::text)::float), ST_MakePoint(((ep::json->'X')::text)::float, ((ep::json->'Y')::text)::float, ((ep::json->'Z')::text)::float)))::float
		, ST_MakePoint(((ep::json->'X')::text)::float, ((ep::json->'Y')::text)::float, ((ep::json->'Z')::text)::float))
		, ((ep::json->'X')::text)::float - ((bp::json->'X')::text)::float
		, ((ep::json->'Y')::text)::float - ((bp::json->'Y')::text)::float
		, ((ep::json->'Z')::text)::float - ((bp::json->'Z')::text)::float
	);
END $BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
