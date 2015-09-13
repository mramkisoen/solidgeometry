DROP TABLE IF EXISTS geo3d.pipe3dp3;

CREATE TABLE geo3d.pipe3dp3
(
  pipeid integer,
  attributes jsonb,
  bbox3d box3d,
  CONSTRAINT "FK_pipe3dp3_pipes" FOREIGN KEY (pipeid)
      REFERENCES geo3d.pipes (pipeid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

INSERT INTO geo3d.pipe3dp3
SELECT pipeid, attributes, ST_bboxlinebox(attributes)
FROM geo3d.pipe3dp;
