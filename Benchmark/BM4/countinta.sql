SELECT count (a.*)
FROM inter a, inter b
WHERE a.pipeid <> b.pipeid;
