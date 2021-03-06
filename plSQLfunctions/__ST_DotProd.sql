CREATE OR REPLACE FUNCTION __st_dotprod(
    center geometry,
    basept geometry,
    hpt geometry)
  RETURNS double precision AS
$BODY$
DECLARE
	scalar float;
	la float;
	lb float;
BEGIN
	scalar := (ST_X(basept)-ST_X(center))*(ST_X(hpt)-ST_X(center))+ (ST_Y(basept)- ST_Y(center)) *(ST_Y(hpt) - ST_Y(center)) +(ST_Z(basept)-ST_Z(center)) * (ST_Z(hpt) -ST_Z(center));
	la := sqrt((ST_X(basept)-ST_X(center))*(ST_X(basept)-ST_X(center))+(ST_Y(basept)-ST_Y(center))*(ST_Y(basept)-ST_Y(center))+(ST_Z(basept)-ST_Z(center))*(ST_Z(basept)-ST_Z(center)));
	lb := sqrt((ST_X(hpt)-ST_X(center))*(ST_X(hpt)-ST_X(center))+(ST_Y(hpt)-ST_Y(center))*(ST_Y(hpt)-ST_Y(center))+(ST_Z(hpt)-ST_Z(center))*(ST_Z(hpt)-ST_Z(center)));
	return acos(scalar/(la*lb));
END$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
