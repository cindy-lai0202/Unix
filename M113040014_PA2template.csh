#!/bin/tcsh
cd $1
ls ?? | xargs -l fgrep ../allcards -e | cut --complement -c 1-2
ls ?H |& fgrep -v : | wc -l > ___tempfile1
ls ?C |& fgrep -v : | wc -l >> ___tempfile1
ls ?D |& fgrep -v : | wc -l >> ___tempfile1
ls ?S |& fgrep -v : | wc -l >> ___tempfile1
fgrep 5 -q ___tempfile1 && echo Flush!
ls [23456789][CSHD] |& fgrep -v :| cut -c 1 > faces
ls [TJQKA][CSHD] |& fgrep -v :| cat -n | cut -c 7-8 | tr "\tATJQK" "140123" >>faces
cat faces | uniq -c | cut -c 7 > facecounts
expr `cat facecounts | wc -l` == 4 >>/dev/null  && echo One pair!
expr `cat facecounts | wc -l` == 3 >>/dev/null && fgrep -q ./facecounts -e 2 && echo Two pair!
expr `cat facecounts | wc -l` == 3 >>/dev/null && fgrep -q ./facecounts -e 3 && echo Three of a kind!
expr `cat facecounts | wc -l` == 2 >>/dev/null && fgrep -q ./facecounts -e 4 && echo Four of a kind!
expr `cat facecounts | wc -l` == 2 >>/dev/null && fgrep -q ./facecounts -e 3 && echo Full house!
expr `cat facecounts | wc -l` == 5 >>/dev/null && expr `sort -n faces | tail -1` - `sort -n faces | head -1` | expr `xargs` == 4 >> /dev/null && echo Straight!
expr `cat facecounts | wc -l` == 5 >>/dev/null && expr `sort -n faces | tail -1` - `sort -n faces | head -1` | expr `xargs` == 12 >>/dev/null && expr `sort -n faces | tail -1` - `sort -n faces | head -2 | tail -1` | expr `xargs` == 11 >>/dev/null&& expr `sort -n faces | tail -1` - `sort -n faces | head -3 | tail -1` | expr `xargs` == 10 >>/dev/null && expr `sort -n faces | tail -1` - `sort -n faces | head -4 | tail -1` | expr `xargs` == 9 >>/dev/null&& echo Straight!
