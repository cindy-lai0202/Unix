#!/usr/bin/tcsh
set num_faces = (0 0 0 0 0 0 0 0 0 0 0 0 0)
set num_suits = (0 0 0 0)
set elements = (♦ ♥ ♠ ♣)
foreach i ( `seq 0 51 | sort -R | head -5 |sort -g` )
	@ x = `expr  1 + $i / 13`
	@ y = `expr 1 + $i % 13`
	echo -n \ `echo $y | grep "1[0-3]" | cut -c 2 | tr '0123' 'JQKA' || expr 1 + $y`$elements[$x]
	@ num_faces[$y] = $num_faces[$y] + 1
	@ num_suits[$x] = $num_suits[$x] + 1	
end
