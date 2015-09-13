select count (a.*)
from interp a, interp b
where a.pipeid <> b.pipeid;
