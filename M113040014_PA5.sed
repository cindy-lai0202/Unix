#!/usr/bin/sed -nf


N;N;N;N;
s/[2-9TJQKA][SCHD]/&,/g;
h;
s/[2-9TJQKA][SCHD],//g;
p;
g;

s/,[^2-9TJQKA][^SCHD][^\n]*//g;s/\n//g;

:J;tJ;

s/.\(.\)\(.\1\)\{4\}/Flush/p;
s/^.*\(.\).\(\1.\)\{3\}$/Four of a kind/p;
s/^\(.\).\(\1.\)\{3\}.*$/Four of a kind/p;
$!d

/Flush/q;
/Four of a kind/q;

s/[SDCH]//g;
s/\n//g;
/\(.\)\(\1\)\{2\}/!bx;
/\(.\)\(\1\)\{1,2\}\(.\)\(\3\)\{1,2\}/ c Full house
/\(.\)\(\1\)\{2\}/ c Three of a kind
:x
/\(.\)\1/!by;
/[^\1\2]*\(.\)\1[^\1\2]*\(.\)\2[^\1\2]*/c Two pair
/\(.\)\1/c One pair
:y
s/.*/&_23456789T/
/^\([2-9T]*\)_\(.\)\{0,4\}\1\(.\)\{0,4\}$/ c Straight
/A2345_/ c Straight
/[9A]JKQT_/ c Straight
/89JQT_/ c Straight
/789JT_/ c Straight
/.*_23456789T/c Nothing
