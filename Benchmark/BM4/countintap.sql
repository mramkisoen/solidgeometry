SELECT COUNT (a.*)
FROM interp a, interp b
WHERE a.pipeid <> b.pipeid;
