DROP TABLE IF EXISTS pernis.pipe3dp;

CREATE TABLE pernis.pipe3dp
(
   pipeid integer,
   attributes jsonb,
   bbox3d box3d,
      CONSTRAINT "FK_pernis_pipe3dp_pipes" FOREIGN KEY (pipeid)
         REFERENCES pernis.pipes (pipeid) MATCH SIMPLE
         ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
   OIDS=FALSE
);

DROP TABLE IF EXISTS pernis.pipe3d;

CREATE TABLE pernis.pipe3d
(
   pipeid integer,
   geometry3d geometry,
   CONSTRAINT "FK_pernis_pipe3dgeo_pipes" FOREIGN KEY (pipeid)
      REFERENCES pernis.pipes (pipeid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
   OIDS=FALSE
);

CREATE INDEX pipe3dpernis_index
  ON pernis.pipe3d
  USING gist
  (geometry3d);
