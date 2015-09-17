SELECT count (a.*)
FROM interp a, interp b
WHERE a.pipeid <> b.pipeid;
