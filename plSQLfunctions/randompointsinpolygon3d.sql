CREATE OR REPLACE FUNCTION randompointsinpolygon3d(
    geom geometry,
    num_points integer)
  RETURNS SETOF geometry AS
$BODY$
DECLARE
  target_proportion numeric;
  n_ret integer := 0;
  loops integer := 0;
  x_min float8;
  y_min float8;
  z_min float8;
  x_max float8;
  y_max float8;
  z_max float8;
  srid integer;
  rpoint geometry;
BEGIN
  -- Addapted version of https://trac.osgeo.org/postgis/wiki/UserWikiRandomPoint 
  
  -- This function may give a constant Z-value of 0. In this case please translate the point randomly in the z axis with:
  -- random()*(z_max - z_min) + z_min)
  -- z_max and z_min are the minimum and maxmum z-value of the generated Box3D geometry (output of ST_3DExtent)
  -- This error is caused by PostgreSQL's Box3d geometry, which is automatically casted to a 2D polygon without Z-value.
  -- This error can be resolved when the z-value will not be ignored.
  
  -- Get envelope and SRID of source polygon
  SELECT ST_XMin(geom), ST_YMin(geom), ST_ZMin(geom), ST_XMax(geom), ST_YMax(geom), ST_ZMax(geom), ST_SRID(geom)
    INTO x_min, y_min, z_min, x_max, y_max, z_max, srid;
  -- Get the area proportion of envelope size to determine if a
  -- result can be returned in a reasonable amount of time
  SELECT ST_Area(geom)/ST_Area(ST_Envelope(geom)) INTO target_proportion;
  RAISE DEBUG 'geom: SRID %, NumGeometries %, NPoints %, area proportion within envelope %',
                srid, ST_NumGeometries(geom), ST_NPoints(geom),
                round(100.0*target_proportion, 2) || '%';
  IF target_proportion < 0.0001 THEN
    RAISE EXCEPTION 'Target area proportion of geometry is too low (%)', 
                    100.0*target_proportion || '%';
  END IF;
  RAISE DEBUG 'bounds: % % % % % %', x_min, y_min, z_min, x_max, y_max, z_max;
  
  WHILE n_ret < num_points LOOP
    loops := loops + 1;
    SELECT ST_SetSRID(ST_MakePoint(random()*(x_max - x_min) + x_min,
                                   random()*(y_max - y_min) + y_min,
                                   random()*(z_max - z_min) + z_min),
                      srid) INTO rpoint;
    IF ST_Contains(geom, rpoint) THEN
      n_ret := n_ret + 1;
      RETURN NEXT rpoint;
    END IF;
  END LOOP;
  RAISE DEBUG 'determined in % loops (% efficiency)', loops, round(100.0*num_points/loops, 2) || '%';
END $BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100
  ROWS 1000;
