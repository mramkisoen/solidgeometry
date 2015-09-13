select count (a.*)
from inter a, inter b
where a.pipeid <> b.pipeid;
