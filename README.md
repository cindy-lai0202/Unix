Programming Assignment #1
displaying cards and identifying whether your cards are all the same suit, which is called a "flush".

Line 1: Change the directory to the place indicated by the passed-in argument.

Line 2: This line is responsible for printing the 5 cards.

         1. Use ls (with any needed flags or arguments) in order to find the
            names of the cards in the hand.
         2. Use xargs (with any needed flags or arguments) in order to convert
            the ls output into arguments.
            (As a hint for this one, Section 2, above, has discussed the use of
            the -l flag with xargs).
         3. Use fgrep to look in the "allcards" file to find the line that
            matches to the argument that is passed to fgrep from xargs.
            (As a hint for this one, Section 2, above, has discussed the use of
            the -e flag with fgrep).
         4. Use cut to remove the first two characters from the input stream.
            For example, a passed-in input of "2D2♦", would create an output
            of "2♦". Or if the input was "TC10♣", the output would be "10♣".

Lines 3-6: These four lines identify how many cards match to each of the four
           suits. The result of running these four lines is the creation of a
           temporary file containing four lines, where each line holds a number
           and where these four numbers always add up to 5 (because there are
           always five cards in a hand).

           So for example, consider that hand represented by sample5:
              % ls sample5
              3S  4D  4H  4S  QS
              %

           This hand has 3 Spades(♠), 1 Diamond(♦), 1 Heart(♥) and no Clubs(♣).
           So the four lines of the created temporary file would hold the
           numbers 3, 1, 1, and 0 (the order is not important). And, indeed,
           3+1+1+0 = 5.
          
Line 7:   This line creates a file containing the word "Flush!".
          
Line 8:   This line is responsible for displaying the word "Flush!", when it
          is appropriate to display it. And when is it appropriate to display
          it? The answer is: when the temporary file creates on lines 3-6 holds
          a line with the number "5". (If you think about it, you will see that
          that is the appropriate test for a hand being a flush.)

          Now, to implement Line 8, execute the following commands (in the
          following order):
           1. Use fgrep to see if there is a "5" in the temporary file created
              in Lines 3-6.
           2. Use paste to combine the input stream from fgrep along with the
              file you created on Line 7 (which holds the word "Flush!").
              (As a hint for this one, Section 2, above, has discussed how the
              "paste" command can be used to combine things for a later fgrep.)
           3. Use fgrep to see if there is a line containing a "5" in the input
              stream.  But wait! Didn't step 1 already check for a "5"? Yes, it
              did. But not the paste command has created an input stream, even
              if there was no output from the earlier fgrep. 
           4. Use cut to remove the "5" and the "\t" from the input stream.
              (The "5" came from fgrep, and the "\t" was the paste delimiter.)

Line 9:   This line removes any temporary files created by the flushtest script.


<img width="648" alt="screen" src="https://github.com/cindy-lai0202/Unix/assets/72913466/5360b5e6-53dd-47d2-8c5e-c8929d4635a1">

-------------------------------------------------------------------------------


Programming Assignment #2

	#!/usr/bin/tcsh
 
The line above here will be the first line of your PA2 script. You can change
the path, however, if your tcsh file is in a different place.

Your previous programming assignment (PA1) displayed cards and then told you
if you had a flush. Now, this new assignment (PA2) will extend that to also
print messages for straights and for matching cards (eg three-of-a-kind).

In this assignment: only use commands from Lectures 1-4, and don't use any ";".
When filling in the blanks indicated below, you may use any piping sequence
of commands, and you may use "&&" and "||". So, for example, if you saw:

	__________________ echo forexample
 
Then something must go before the "echo" that would not break UNIX syntax.
So it could be "... | echo forexample" or "... | xargs echo forexample" or
"... || echo forexample" or "... && echo forexample". (But not "...; echo",
because I am not allowing you to use ";" in this programming assignment.

Below, I comment PA1's solution, and I indicate what to add or to change:

PA1 line #1
This was PA2. But for PA2, you must use the first parameter, not $*.

          cd ____  <= Your job is to fill in the blank

PA1 lines #2-6
The next 5 lines are the same in PA2 as they were in PA1 (so copy these lines):

	ls ?? | xargs -l fgrep ../allcards -e | cut --complement -c1-2
	ls ?H 2> /dev/null | wc -l > ___tempfile1
	ls ?C 2> /dev/null | wc -l >> ___tempfile1
	ls ?D 2> /dev/null | wc -l >> ___tempfile1
	ls ?S 2> /dev/null | wc -l >> ___tempfile1

PA1 lines #7-9
The next 3 lines printed "Flush!", but they needed a tempfile:

	echo Flush! > ___tempfile2
	fgrep 5 ___tempfile1 | paste - ___tempfile2 | cut --complement -c1-2 | fgrep F
	rm ___tempfile?

In PA2, however, we now know about command coordination with || and &&. This
will allow us to only print "Flush!" if there is a "5" in the tempfile. So,
on the following line you must achieve printing Flush! using only fgrep & echo:

	_______________________________ echo Flush!  <= Your job is to fill in the blank

That is the end of the section that is like PA1. Now for the new behavior:
In PA2, we do not only check for flushes (all cards being one suit). We also
check for straights (all cards are in sequence), and for matching card faces.
For these checks, the suit of the cards does not matter. Therefore, on the
next two lines of your answer, you will create a file for just the faces (not
the suits). Moreover, the faces of the T, J, Q, K, and A will be converted into
the numbers 10, 11, 12, 13, and 14, respectively.

Not clear? Then consider the following example, where I have already run the
two lines to create the faces file:

	% basename `pwd`
	sample1
	% ls
	2C  3C  5C  AC  TC  faces
	% ls ?[CSHD] | paste - faces
	2C      2
	3C      3
	5C      5
	AC      14
	TC      10
	% 

Understand? The cards 2-9 display their filenames' first character; the other
cards display a number code.

As I said above, you will need 2 lines of code to accomplish this. The first
line is for all cards from 2 to 9:

	____________________________ > faces   <= Fill in the blank

The second line is for the ten, jack, queen, king and ace. This line is harder,
because the letters for these cards need to be converted to numbers. To make
things even harder, these are 2-digit numbers. The solution will need to do two
things: 1) Insert a "1" in front of each of these cards, and 2) Convert T to 0,
J to 1, Q to 2, K to 3, and A to 4. The harder of these parts is the putting
of the "1" in the front, because we can only use commands from lectures 1-4,
and that does not give us many ways to put something in from of each line of
input. The answer is to use "cat -n" to put a "\t" in front of each line (along
with some other things that "cat -n" will insert, but that you can then remove.

	____________________________ >> faces  <= Fill in the blank

Now that we have a list of faces, we can analyze which cards match each other.
To this end, we wish to create a file, facecounts, that contains a list of
numbers, 1 number per line. If we add these numbers, they always add up to 5.

Not clear? Here are all of the cases (in each case line order is unimportant).

If you had:                                  Then facecounts will have:

	4-of-a-kind (eg 4 fives + 1 side card)       Two lines: a '4' and a '1'
	3-of-a-kind (eg 3 tens + 2 side cards)       Three lines: a '3' and two '1'
	2-of-a-kind (eg 2 sevens + 3 side cards)     Four lines: a '2' and three '1'
	2-pair (eg 2 aces + 2 twos + 1 side card)    Three lines: a '1' and two '2'
	Full-house (eg 2 fives + 3 kings)            Two lines: a '2' and a '3'
	No matches (ie, either a flush or garbage)   Five lines: all '1'
 
So put that line here. (Hint: uniq -c)

	____________________________  > facecounts  <= Fill in the blank

The next line controls whether to print "One pair!"
Hint: In this case facecounts would have 4 lines.
Hint: expr understands the "==" operator.

	_______________________________ echo One pair! <= Fill in the blank

The next line controls whether to print "Two pair!"
Hint: In this case facecounts would have 3 lines. <= But so would 3-of-a-kind
Hint: facecounts would have a '2'

	_______________________________ echo Two pair!  <= Fill in the blank

The next line controls whether to print "Three of a kind!"
Hint: In this case facecounts would have 3 lines. <= But so would 2-pair
Hint: facecounts would have a '3'

	_______________________________ echo Three of a kind! <= Fill in the blank

The next line controls whether to print "Four of a kind!"
Hint: In this case facecounts would have 2 lines. <= But so would full-house
Hint: facecounts would have a '4'

	_______________________________ echo Four of a kind! <= Fill in the blank

The next line controls whether to print "Full house!"
Hint: In this case facecounts would have 2 lines. <= But so would 4-of-a-kind
Hint: facecounts would have a '3'

	_______________________________ echo Full house! <= Fill in the blank

The next line controls whether to print "Straight!" (which means that all of)
the cards are sequential). Note that, when you have a straight, you might also
have flush -- and that is OK, you script will just print both messages.
Further note that, when you have a straight, facecount will be all '1's.
Finally, note that there is a special kind of straight that this current line
will not catch: the ace-low straight (14, 2, 3, 4, 5).

So how to do it? First, you will test facecounts to make sure that all of
the cards are different, then you will use expr, ``, sort, tail, and head,
in order to test whether the value difference between the high card and low
the card is 4. In that case, you have a straight.

Q: "Do I have to use expr, ``, sort, tail, and head?"  A: "Yes."

	_______________________________ echo Straight! <= Fill in the blank

This final line handles the ace-low straight (14, 2, 3, 4, 5). Implement it
any way that you want, but only using commands from lectures 1-4 

	_______________________________ echo Straight! <= Fill in the blank
	
And that is the end of your script. You will notice that there is no output for
garbage hands (ie, hands that have no matches or straights or flushes).

-------------------------------------------------------------------------------
Programming Assignment #3、4

In this homework, you will write a cshell script to deal and score a poker hand.

The homework is due in two parts. Lines 1-11 are PA3.
The second part, Lines 12-end are PA4

Here are some sample runs, assuming that your program works:

	   % ./PA3.csh
	     8♦  6♠  4♣  5♣  7♣: Straight!
	   % ./PA3.csh
	     2♦  2♠  7♠  8♠  J♣: One pair!
	   % ./PA3.csh
	     4♦  5♥  7♥  3♠  6♠: Straight!
	   % ./PA3.csh
	     6♦  10♦  10♥  Q♠  Q♣: Two pair!
	   % ./PA3.csh
	     2♣  4♣  6♣  8♣  Q♣: Flush!
	   % ./PA3.csh
	     3♥  5♥  7♥  2♠  A♠: Ace high!
	   % ./PA3.csh
	     2♦  Q♦  2♠  Q♠  2♣: Full house!
	   %

There are some rules for the assignment:
You can never use ";", except with breaksw or exit (ie, ";breaksw" or ";exit").
You can never use "||", except on Line #9 (the card display line, see below).
You can never use "&&".
You can never create any files.
You must complete each line listed below in a single line of your script.

Line 1:  #!/usr/bin/tcsh
         (In your computer, it might be #!/bin/tcsh.)
  
Line 2: This creates an array of 13 zeroes (ie, '0').
        There are are 13 card faces (2 - 10, J, Q, K, and A).
        This array will be used to count how many of each face are seen.

Line 3: This creates an array of 4 zeroes (ie, '0').
        There are are 13 card suits (♦, ♥, ♠, and ♣).
        This array will be used to count how many of each suit are seen.

Line 4: This creates an array of 4 elements, with the values ♦, ♥, ♠, and ♣.

Line 5: This starts a foreach loop, with a loop index variable of "i".
        It loops over 5 distinct random numbers that are between 0 and 51.
        These numbers must be sorted from smallest to largest.
        This line's implementation must meaningfully use ``, seq, and sort (it
        can also use other things).
        (Hint: sort has -R flag).

Line 6: This uses the following idea: If "i" is a number between 0 and 51, then
        i/13 will be a number between 0 and 3. (Note that expr will return a
        rounded-down integer for "/", just like C would do.)
        The purpose of all of this is to create an index to access the elements
        of the array created on line 3. And that array is a Cshell array, which
        means that the indexing starts at 1 (ie, not at 0 as it would in C).

        Q. So, what does it all mean?
        A. Line 6 defines a variable that holds the number 1+i/13.
           Note: You must use Cshell's @ command.
           Also, in Cshell, always remember to add spaces between things.

Line 7: This uses the idea that i%13 will be a number between 0 and 12 (which
        indicates 13 different values, just like there are 13 cards per suit).
        Also, a trick on Line 8 will be easier if we add a 1 to the answer.

        Q. So, what does it all mean?
        A. Line 7 defines a variable that holds the number 1+i%13.


Line 8: This line prints the card. It does not use color (unlike the earlier
        homeworks). It has this format:
           echo -n \  `echo  _1_ | grep _2_ | cut _3_ | tr _4_ || expr _5_`$_6_

           where:
             _1_: This is the variable created on Line 7.
             _2_: This SINGLE regular expression matches to numbers 10 to 13 (it
                  may also match numbers like 14-19 if you want it to, because
                  such numbers are not valid inputs anyway.)
             _3_: Since the grep must have matched, in order to reach here, we
                  must have a 2-digit number beginning with 1. This cut command
                  is now used to remove the leading "1". (Note, we couldn't just
                  do "tr -d 1", because then a number "11" would've become "".)
             _4_: This turns a 0 into a  J, 1 into Q, 2 into K, and 3 into A.
             _5_: Note that this is preceded by a "||", not a "|". That means
                  that _5_ only executes if _3_ did NOT find a match. From this,
                  we can know, in reaching _5_, that the variable defined back
                  on line 7 holds a 1-digit number.
                  That 1-digit number is valued from 1 to 9, but the numbered
                  cards in a deck from 2 to 10.
                  Therefore, the job of _5_ is to add one to the variable
                  defined on line 7. (Note it re-accesses the variable, it does
                  not read input from the pipe.)
             _6_: Parts _1_-_5_ have printed the face, so _6_ prints the suit by
                  accessing the correct element of the array created on line 4.
  
Line 9:  This line adds 1 to the appropriate element of the array thay you had
         created on Line 2, based on what the face value of the current card is.
         Note, you must use @.

Line 10: This line adds 1 to the appropriate element of the array thay you had
         created on Line 3, based on what the suit value of the current card is.
         Note, you must use @.

Line 11: end    <= Write this as-is. It ends the loop that you bagan on line 5.

Line 12: echo -n ": " <= Write this as-is.

Line 13: 

	switch ( `_1_ | _2_ | _3_ | _4_` )
	         _1_ Print all of the elements of the array updated on Line 9.
	         _2_ Put each element on its own line.
	         _3_ Sort them so that the bigger numbers are at the top.
	         _4_ Erase all spaces and newlines. This will create one of six cases,
	             which you will deal with as follows:

Lines 14-24: Copy the following lines, as-is:   

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

Line 25: To reach this line, the face cards must be all different.
         But there are 4 possible situations for this:
           - A flush, meaning that all cards are the same suit.
           - A straight, meaning that the cards are in sequence. (A special
             case of this is when the Ace is below a 2-5 sequence.)
           - A straight flush, when both of the above are true.
           - A junk hand. In this case, the score is based on what the highest
             card is.
      
Line 26:set flush = "" <= Write this as-is.

Line 27: 

	if ( __1__ ) set flush = \ Flush!
         Note that this line uses Cshell's 1-line if (that doesn't get a "then")
         The details of __1__ are up to you. Its purpose is to see if there
         is a "5" in the array that you updated on Line 10.

         Note: the reason the we created a variable that may-or-may-not contain
               the string "Flush!" is because we must handle straight flushes.

Lines 27-28:

        if ( `__1__`  =~ '__2__' ) then
            echo Straight$flush!
            
        __1__: Print all of the elements of the array updated on Line 9.
        __2__: A wildcard pattern that matches to a sequence of 5 straight 1s.
               Note: this is a wilcard pattern. Wildcard patterns default to
                     matching the whole string, which is not what you want.

Lines 29-30:
        if ( `__1__`  == '1 1 1 1 1' ) then
            echo Straight$flush!

        __1__: This is for handling the special case where that sequence is
               A, 2, 3, 4, 5. In this case ,we can just list those array
               elements, and see if they are all 1.

Lines 31-33: (Copy these lines as-is)
        else if ( $flush != "" ) then
            echo Flush!
        else

Line 34: This line must use a foreach, and an seq to count down from 13 to 1. 

Line 35:

	if ( __1__ ) then

         This line checks array of face values (the one you update on line 9)
         to see if the count down counter has reached a card that you have.
         
Lines 36 to end-5: These lines are a switch block to print what the high card's
                   name is. Eg Ace high!, or Queen high, or 10 high!, or 7 high!

Lines end-5 to end: (Copy as-is)
	
	                    endsw
	                endif
	            end
	        endif
	endsw

This final line handles the ace-low straight (14, 2, 3, 4, 5). Implement it
any way that you want, but only using commands from lectures 1-4 

	_______________________________ echo Straight! <= Fill in the blank

#And that is the end of your script. You will notice that there is no output for
#garbage hands (ie, hands that have no matches or straights or flushes).

-------------------------------------------------------------------------------
Programming Assignment #5
Two part 
Part 1: must use only sed commands we learned in lecture 8.It prints the 5 cards in the 
hand and detects if they are either a Flush or Four of a kind. You will notice that it 
uses some sed syntax from Lecture 9 to get specific sets of 5 cards. This isn't a real 
issue, however, because of three reasons. 1) It's code I'm giving you, so you can type 
it even if you haven't learned Lecture 9. 2) We will get to Lecture 9 quite soon, and 
then it will make sense. 3) The real way that the game would really be played is shown
on the last line of the screenshot: "sort -R allcards | head -5 | sort -g" -- which 
doesn't require the use of any sed.

#!________________
# The above line defines the path to sed and the flags to sed

#The following lines print a pretty card (meaning that everything except for
#the first 2 characters is printed). These lines also take those first two
#characters and append them onto the end of the hold space.

 .
 .    <= lines go here
 .

#The following line loads the hold space into the pattern space:
____

#The following _____ is a single pattern that detects any flush:
s/____/Flush/p

#The following ____ pattern detects if the last 4 cards all have the same face:
s/____/Four of a kind/p

#The following ____ pattern detects if the first 4 cards have the same face:
s/____/Four of a kind/p

# Note that the input file will always be sorted based on the face. This is
# why the above only needed to check for two cases (ie, first 4 & last 4).
<img width="958" alt="UNIXPA5a" src="https://github.com/cindy-lai0202/Unix/assets/72913466/bfbe8960-19ed-4b7d-b786-c440350df515">


Part2: As for this present Part 2, it involves filling in the blanks
in the testertemplate.csh script:You should fill in the blanks according to the instructions
given in the template, then remove all of the comments, then
rename the file to "tester.csh", then make it an executable.

<img width="947" alt="testeroutput" src="https://github.com/cindy-lai0202/Unix/assets/72913466/fa899ee0-c1bb-49b4-937e-b37ee2d685bc">

#!/usr/bin/csh
@ f = _______ # Use seq, sort & head to create a random number between 1 and 13

./topface $f
switch ( $1 )
   case "[Rr]*":
      cat allcards | sort -R | sed ______ # prints first 5 lines
      exit
   case "[Ff]*":
      @ suit = ___ #Use seq, sort & head to randomly choose from 1, 14, 27 & 40

      #Now, the value of "suit" is the line number of "allcards" on which one
      #suit begins. And the next 12 lines of "allcards" will also be that suit.

      cat allcards | sed -n ______ | sort -R | sed 5q
      #The above _____ is a sed program to select the 13 lines of the "suit".
      #This must be achieved using expr, and using sed's "," range operator.
      exit
   case "[Ss]*":
      @ f = ___ # Use seq, sort & head to create a random number from 1 and 8
      set h
      foreach i ( `seq 0 4`)
         @ suit = __________ # This is the same as the earlier "@ suit =" line. 
         set h = ( $h ____ ) # Add next card to the straight, using above suit. 
      end
      echo $h | tr " " "\n" | sort -R > nums
      breaksw
   case "4*":
      cat topdeck | sed 5q > nums
      breaksw
   case "3*":
      cat topdeck | sed 1d\;6q > nums
      breaksw
   case "2*":
      cat topdeck | sed 3,7\!d > nums
      breaksw
   case "1*":
      cat topdeck | sed 1,3d > nums
      breaksw
   case "[Hh]*":
      cat topdeck | sed -n 3p > nums
   case "[Pp]*":
      cat topdeck | sed 2q >> nums
      @ f2 = `cat topdeck | sed 5\!\d | xargs expr 0 - 1 +` % 13 + 1
      ./topface $f2
      cat topdeck | sed 2q >> nums
      @ f3 = `cat topdeck | sed 5\!\d | xargs expr 0 - 1 +` % 13 + 1
      if ( $f3 != $f ) cat topdeck | sed 5\!d >> nums
      if ( $f3 == $f ) cat topdeck | sed 6\!d >> nums
      breaksw
   default:
      echo "This program is meant to receive one argument:"
      echo '  (R) Random'
      echo '  (F) Flush'
      echo '  (S) Straight'
      echo '  (H) Full House'
      echo '  (P) Two Pair'
      echo '  (4) Four of a kind'
      echo '  (3) Three of a kind'
      echo '  (2) Two of a kind (ie, 1 pair)'
      echo '  (1) "One" of a kind (ie, no matching cards)'
      echo
      exit
endsw

# The first 5 lines of the "nums" file represent line numbers in the "allcards"
# file. The following ________ will produce a sed program to print those lines.
sed -n `head -5 nums|sed _______________________________` allcards
rm nums

-------------------------------------------------------------------------------
Programming Assignment #6

Let's look at the provided files:
    % ls
    DatabaseAndLogExpected                   README
    QuantumQuest:_A_ChatGPT_Space_Adventure  testawk.sh
    %

Also, you can see that I have given you an Expected output file.

And I have given you a test script to check your answer with.

Aside from this README file, there one more file, a big text file:
    % wc -c QuantumQuest:_A_ChatGPT_Space_Adventure
      206634 QuantumQuest:_A_ChatGPT_Space_Adventure
    %

Q1. What is this huge, 200KB file?
A1. It is a copy of a chat session I had with ChatGPT.

Q2. Why am I showing it to you:
A2a.Because I have been trying to convince you, all semester long,
    that plain text files are important. And now there is chatGPT.
    How do you interact with it? Oh, that's right: in plain text.
    So it is a good use case for the demonstrating the value of
    tools for working on text files.
A2b.Because I am trying to wake students up to the need to learn
    ChatGPT for programming. (In fact I will be teaching a class
    on that topic in the coming fall semester, on Monday afternoons.
    Just letting you know, in case you may be interested.)
    Reading the QuantumQuest:_A_ChatGPT_Space_Adventure file
    will show something about what ChatGPT does well, and where it
    makes mistakes.
A2c.Because the output of ChatGPT was, in this case, pretty good.
    However, it needs to be cleaned up a little. And that is just
    what a tool like awk is good at.

Q3. So, what will you see if you read the chat file?
A3. It is a record of my conversation with ChatGPT, in planning how
    to design a text adventure game. NOTE: you do not need to read
    all of the file in order to do this assignment, but I gave you
    the full file just to show you what ChatGPT can do.

But, to spare you the reading of the full file (in case you are not
interested to read it), I started out talking to ChatGPT about what
puzzle I can put into the game. Eventually, through discussing with
ChatGPT, I settled on a puzzle where my spaceship has encountered
an alien artifact with quantum entanglement properties that lead to
a puzzle the player will need to solve. The solution will involve
using the quantum stabilizer unit (QSU) of the quantum computer that
is onboard my spaceship. In deciding how the player can figure out
the puzzle, I ended up with the idea that the player will have access
to the ship's computer records. And that is where we get to the
homework assignment:

At some point in the conversation with ChatGPT, I began asking it
to generate database entries for a variety of topics.
I also asked it generate some Captain's Log Entries.

We can see what those entries are by looking at just the Entry Names
in the provided DatabaseAndLogExpected file:
    % grep '^[CD]a.* [LE]' DatabaseAndLogExpected|sort
    Captain's Log - Mission Day 113, Supplemental 2:
    Captain's Log - Mission Day 113, Supplemental:
    Captain's Log - Mission Day 113:
    Captain's Log - Mission Day 1:
    Captain's Log - Mission Day 2:
    Database Entry: Command and Control System:
    Database Entry: Communication System:
    Database Entry: Crew Manifest:
    Database Entry: Current Mission:
    Database Entry: Deep Space Hibernation:
    Database Entry: Dilithium:
    Database Entry: Environmental Monitoring System:
    Database Entry: Life Support System:
    Database Entry: Navigation and Guidance System:
    Database Entry: Nexus Prime:
    Database Entry: Nova Lumen:
    Database Entry: Payload Systems:
    Database Entry: Power Generation and Distribution:
    Database Entry: Propulsion System:
    Database Entry: QuantaCore Q-7000:
    Database Entry: Quantum Computing:
    Database Entry: Quantum Data Processor (QDP):
    Database Entry: Quantum Encryption and Communication (QEC):
    Database Entry: Quantum Entanglement:
    Database Entry: Quantum Resource Allocation (QRA):
    Database Entry: Quantum Sensor Integration (QSI):
    Database Entry: Quantum Stabilizer Unit (QSU):
    Database Entry: Ship Systems:
    Database Entry: Weapons System:
    %

The idea of the database file is that I can easily have chatGPT write
code to display individual entries. For example, here is how easy it
is to display a specific entry in sed:
    % cat DatabaseAndLogExpected | sed -n '/Weapons/,/--/p;1i\\t'

    Database Entry: Weapons System:
    Although primarily designed for peaceful trading operations, the trading barge is equipped with a basic defensive weapons system. The system features lightweight plasma pulse emitters capable of emitting controlled bursts of energy to repel potential threats. Its primary purpose is to provide a deterrent and basic defense capability against minor spaceborne hazards or rogue elements encountered during trade missions. The weapons system is supported by a simple deflector shield system that provides a limited level of protection to the ship.
    
    ------------------------
    %


Well, that is nice, cleaned-up output from DatabaseAndLogExpected.

The problem is that ChatGPT's output was less-clean in several ways:
  1) It has a few inconsistencies in format that need to be fixed,
     for a small number of entries.
  2) It has lines of text that are not database entries.
  3) It has duplicate entries. This is because I would sometimes
     tell it to try again. So, when there are duplicates, the one
     that appears later in the file wins. (One exception to this is
     the 8 ship systems: Command and Control, Communication,
     Environmental Monitoring, Life Support, Navigation and Guidance,
     Payload, Power Generation and Distribution, and Propulsion. For
     these systems, the earlier description is better than the later
     one -- but that won't matter, because the later ones end up
     getting skipped anyway because their format is different.)

So the job of your awk script is to clean up the chatGPT output.

To begin understanding how we will do that, let's look at the script
I gave you for testing:
     % cat testawk.sh
     cat QuantumQuest:_A_ChatGPT_Space_Adventure | \
         awk -f PA6.awk | uniq | \
         sed 's/[[]Insert Ship Name]/Fortune Céleste/'>DatabaseAndLog
     
     sort DatabaseAndLog > sortedDatabaseAndLog
     sort DatabaseAndLogExpected > sortedDatabaseAndLogExpected
     echo
     diff -q sortedDatabaseAndLogExpected sortedDatabaseAndLog && \
          echo Matches\! || echo doesn\'t match\!
     echo
     rm -f sortedDatabaseAndLog sortedDatabaseAndLogExpected
     %

From the above see that if first does this:
     cat QuantumQuest:_A_ChatGPT_Space_Adventure | awk -f PA6.awk|...

So your PA6 soultion is an awk script that runs directly on the
QuantumQuest:_A_ChatGPT_Space_Adventure file.


Next, we notice that the PA6,awk output gets a little more clean-up:
         ...
         awk -f PA6.awk | uniq | \
         sed 's/[[]Insert Ship Name]/Fortune Céleste/'>DatabaseAndLog

The uniq command removes duplicate lines. The only time that this
output will have duplicate lines is for empty lines. So this uniq is
just limitting gaps between paragraphs to only single empty lines.

Next, a sed command inserts the spaceship's name, because the ship's
name was not yet known at the time that the database entry that says
"[Insert Ship Name]" was written. Don't understand? Then forget about
it, because it is not something you need to worry about-- I already
gave you the tester.sh script that uses sed to fix it, as you see
above.

Now let's look at the rest of the test script:
     % tail -8 testawk.sh
     
     sort DatabaseAndLog > sortedDatabaseAndLog
     sort DatabaseAndLogExpected > sortedDatabaseAndLogExpected
     echo
     diff -q sortedDatabaseAndLogExpected sortedDatabaseAndLog && \
          echo Matches\! || echo doesn\'t match\!
     echo
     rm -f sortedDatabaseAndLog sortedDatabaseAndLogExpected
     %

Here we see that it just compares your output to the expected output.
But we do see that it sorts the outputs before comparing them. This is
because the individual entries may not list in the same order on every
computer system (and that is OK, the database entries are unordered).



OK. So now, how to implement PA6.awk?

First, I will clarify: you want to use an associative array, named DB.
The index is the "Database Entry: ..." line. The value inside of the
associative array is the description text for that Entry. Then, when you
reach the END, the array gets printed.
 Q. Why create an array named DB?
 A. Because we need to only use the final entry when there are duplicates
    (the earlier array value will get overwritten by a later value). 


Now here is the line-by-line:

Line 1. This defines DE="Database Entry: ". It must do this only 1 time,
        at the beginning of execution.

Line 2. This uses the next() function to skip over this input line, if the
        line begins with "End of". Why? because ChatGPT sometimes generated 
        a useless "End of Database Entry" line.

Line 3. The database entry for Dylithium is a little-bit wrongly formatted:
           % cat QuantumQuest:_A_ChatGPT_Space_Adventure | sed -n 448p
           Ship's Database - Dilithium
           %
         Line 3 changes it into: "Database Entry: Dilithium:"

Line 4. The database for the hybernation and weapons systems are illformated:
           % cat QuantumQuest\:_A_ChatGPT_Space_Adventure| sed -n '987,989p' |\
           ? sed 's/\(.\{60\}\).*/\1.../'
           Deep Space Hibernation: The deep space hibernation system al...
           
           Weapons System: Although primarily designed for peaceful tra...
           %

        They should instead be: "Database Entry: Deep Space Hibernation" and
        "Database Entry: Weapons Systems".
        But there is another issue: The text for those two database entries
        are placed on the same line, rather than on the next line (see above,
        the words "The deep space hibernation system al...").

        So, how to do line 4?
        1. You need a pattern that catches both the hibernation and weapons
           systems. 
        2. You need to use split() to separate the line by the ": " symbol,
           and placing it the result into array A.
        3. You need to set the array element for those systems. That is to say:
           The index for the DB array is A[1] and the value is A[2]"\n".
	
Line 5. This converts "Log, Day 113" to "Log - Mission Day 113".

Line 6. This converts ", Supplemental" to " - Mission Day 113, Supplemental".

Line 7. The Pattern catches the lines that begin "Database" or "Captain's Log".
       -One Action is to create a variable, K, that is set to $0. That variable
        will become the SB index.
       -Another action is to create an entry in DB with an index of K and a
        value of "". (Why empty? Because the DB contents are in the next line.)
       -Finally, there is one more part of the action. It uses getline, to put
        the next line into $0.

Line 8. The pattern is lines that begin with "User".
        The action is to set the K value to "".
        Why? Because the line with "User" indicates that ChatGPT finished.

Line 9. The pattern is to check whether K is not "".
        The action is to append a "\n"$0 into DB[K].

LINE 10.The pattern is END.
        The action is to use a for loop to print all of the elements of DB.
	After each, you also print "------------------------".



