CREATE TABLE geo3d.pipe3dp2
(
  pipeid integer,
  attributes jsonb,
  bbox3d geometry,
  CONSTRAINT "FK_pipe3dp_pipes" FOREIGN KEY (pipeid)
      REFERENCES geo3d.pipes (pipeid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

CREATE INDEX pipe3dp2_index
  ON geo3d.pipe3dp2
  USING gist
  (bbox3d);
  
INSERT INTO geo3d.pipe3dp2
SELECT pipeid, attributes, ST_bbox(attributes)
FROM geo3d.pipe3dp;
