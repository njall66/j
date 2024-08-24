NB. Play around with sequential machines
NB.
NB. they may even turn out to be useful at some point
NB.

NB. X ;: Y
NB.
NB. X =: output style - f ; action table ; input classes - m ; i,j,r,d - initial values
NB.
NB. i - current location in input Y
NB. j - start of current word
NB. r - current state (row in action table)
NB. d - final input
NB.
NB.
NB. Input classes - m:
NB. - if Y is characters - can be a numeric list giving classification for each character 0 - 255
NB. - input class used as column index of action table
NB.
NB. action table:
NB. - Two Dimensional Array
NB. - (number of states , number of input classes)
NB. - each item of table - 2 element vector specifying new state and action code (see below)
NB.
NB. Output style f:
NB. 0 - boxed word - items of y between j and i-1 boxed
NB. 1 - unboxed word items of y between j and i-1
NB. 2 - j, i-j --- effectively index and length of word
NB. 3 - coded row and column - c + r*number of columns in action table (where c and r are ???)
NB. 4 - j, (i-j) , c+r*number of columns in action table
NB. 5 - i,j,r,c,(<r,c){action table  ---- dumps everything - done for every iteration regardless of action codes
NB.
NB. Actions Codes:
NB. 0 - no output, no change to j
NB. 1 - no output, j =. i      ---- set start of word pointer
NB. 2 - add single word - ouputs current word , j =. i    ---- outputs current word (j ==> i - 1) and starts new word at current location
NB. 3 - add single word , j =. _1   ----- output current word and set "no current word"
NB. 4 - add multiple words , j =. i   ----- puts current word in list to be output, output coalesces sequential words that have same state (????)
NB. 5 - add multiple words , j =. _1
NB. 6 - stop - nothing more is done, nothing is output
NB. 7 - backtrack i ==> i - 1, no output 
NB. 8 - no output, j =. i+1  ---- don't output current word, set start of word to next location
NB. 9 - add single word , j =. i + 1
NB. 10 - add multiple words , j =. i + 1 
NB.
NB. d - final action - _1 - 

NB. Try to build sequential machine that takes blob of text and spits out just the words and numbers - no punctuation, context, etc.
NB.
NB. states:
NB. 0 - not in word
NB. 1 - in word
NB.
NB. input classes:
NB. 0 - other char
NB. 1 - word char
NB.
NB. so our action table should be something like:
NB. - not in word ; other char ==>  no output; no change to word pointer j -- stay in state not in word, action 0 
NB. - not in word; word char ==> no output ; set start of word j =. i -- go to state in word ; action 1
NB. - in word ; other char ==> output current word ; set start of word j =. _1 -- go to state not in word ; action 3
NB. - in word ; word char ==> no output ; no change to start of word j -- go to state in word ; action 0
NB.

sw_act =: 1 2 2 $ 0 0 1 1
sw_act =: sw_act , 2 2 $ 0 3 1 0

NB. input classes - since input is characters we can use numeric list.   All "word characters" - input class 1.  All "non-word characters" - input class 0 

sw_m =: 1 (<"0 a. i. 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ''-')} (256 # 0)

emitWordsSM =: (0 ; sw_act ; sw_m ; 0 _1 0 0)&;:

NB. try to make it work with unicode characters - comes close but doesn't really work - just treating all characters 128+ as "word" characters just doesn't work 

sw_m_uni =: 1 ((<"0) 128 + i.128)} 1 (<"0 a. i. 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ''-')} (256 # 0)
emitWordsSM_UNI =: (0 ; sw_act ; sw_m_uni ; 0 _1 0 0)&;:

