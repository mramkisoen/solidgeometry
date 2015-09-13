DROP TABLE IF EXISTS geo3d.pipe3drbb;

CREATE TABLE geo3d.pipe3drbb
(
   pipeid integer,
   attributes jsonb,
   rbb geometry,
     CONSTRAINT "FK_pipe3dp_pipes" FOREIGN KEY (pipeid)
	REFERENCES geo3d.pipes (pipeid) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

INSERT INTO geo3d.pipe3drbb
select *, ST_RBB(attributes)
from geo3d.pipe3dp;

CREATE INDEX pipe3drbb_index
  ON geo3d.pipe3drbb
  USING gist
  (rbb);
