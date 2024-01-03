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
echo -n ": "
switch (`echo $num_faces | tr " " "\n" | sort -r | tr -d " \n0"` )
	case 41:
        	echo Four of a kind! ;breaksw
    	case 32:
        	echo Full house! ;breaksw
    	case 311:
        	echo Three of a kind! ;breaksw
    	case 221:
        	echo Two pair! ;breaksw
    	case 2111:
        	echo One pair! ;breaksw
    	case 11111:
		#11111	
		set flush = ""
		if ( `echo $num_suits | fgrep -c 5` ) set flush = \ Flush!
		if ( `echo $num_faces ` =~ '*1 1 1 1 1*') then
			echo Straight$flush!
		else if ( `echo $num_faces[$#num_faces] $num_faces[1-4]` == '1 1 1 1 1' )then
			echo Straight$flush!
		else if ( $flush != "" ) then
	    		echo Flush!
        	else
			foreach i ( `seq 13 -1 1` )
				if ( $num_faces[$i] == '1' ) then
					switch ( $i )
						case 13:
							echo Ace high! ;break
						case 12:
							echo King high! ;break
						case 11:
							echo Queen high! ;break
						case 10:
							echo Jack high! ;break
						default: 
							echo `expr 1 + $i` high! ;break
				
					endsw
				endif
	    		end
		endif 
endsw


		
