coclass 'tui' 

initColors =: {{)v

load '/j9.5/addons/graphics/color/colortab.ijs'

". COLORTABLE 
}}

colorList =: initColors '' 

create =: 3 : 0

NB. put initilization stuff into here 

NB. use somebody else's functions for writing to terminal and reading from the console 

mvt =: conew 'vt' 

1
)

NB. play around with text user interface ideas

NB. redefine my hex to decimal converter

h2d =: [: 16&#. [: ]`(_16&+)@.(16&<) '0123456789abcdefzzzzzzzzzzABCDEF'&i.

NB. redefine db:

db =: %~

NB. useful colors ???

NB. functions to convert RGB <==> HSV

rgb2HSV =: 3 : 0

NB. convert RGB color to HSV
NB.
NB. Y - RGB color - assuming that RGB are specified 0 - 255
NB.

NB. rescale RGB to [0 1]

rgb =. 255&db y 

'r g b' =. rgb 

'M m' =. (max , min) rgb 

C =. M - m

if. (C = 0) do.

  Hp =. 0

else.

  NB. baseHp =. C&db -/ rgb -. M 

  Hp =. ( ([: 6&| [: C&db (g - b)&[)`([: 2&+ [: C&db (b - r)&[)`([: 4&+ [: C&db (r - g)&[) ) @. (rgb&i.) M

end.

S =. (C&%) ` (0:) @. (0&=) M

H =. (pi % 3) * Hp 

(H , S, M) 
)

hsv2RGB =: 3 : 0

NB. convert HSV to RGB
NB.
NB. X - H, S, V
NB.
NB. assumes S, V in [0,1]
NB. H taken mod 2*pi
NB.

'H S V' =. y

H =. (2*pi) | H

C =. V * S

m =. V - C 

Hp =. H % (pi % 3)

X =. C * (1&- | _1&+ 2&| Hp)

<. 0.5&+ 255&* m&+ (C , X , 0) {~ ( ((0 1 2)&[)`((1 0 2)&[)`((2 0 1)&[)`((2 1 0)&[)`((1 2 0)&[)`((0 2 1)&[) ) @. (<.) Hp
)

NB. some cool color combinations

hexRGB2Dec =: [: _2&(h2d@:]\) }. 

C_TABLE =: 0 0 $ 0 

addColor =: 3 : 0 

C_TABLE =: C_TABLE , (] , [: hexRGB2Dec each {:) y

''
)

addColor 'crisp_dramatic';'thunder_cloud';'#505170'
addColor 'crisp_dramatic';'waterfall';'#68829e'
addColor 'crisp_dramatic';'moss';'#aebd38'
addColor 'crisp_dramatic';'meadow';'#598234'
addColor 'autumn_vermont';'crimson';'#8d230f'
addColor 'autumn_vermont';'forest';'#1e434c'
addColor 'autumn_vermont';'rust';'#9b4f0f'
addColor 'autumn_vermont';'gold';'#c99e10'
addColor 'day_night';'dark_navy';'#011a27'
addColor 'day_night';'blueberry';'#063852'
addColor 'day_night';'tangerine';'#f0810f'
addColor 'day_night';'daffodil';'#e6df44'

NB. useful constants

NB. Terminal escape codes for fun and profit 

NB. codes all start with escape - so define a constant that has the opening characters - Esc [ 

CS_SE =: (27&{ a.) , '[' 

NB. simple formatting

NB. invs - insert string x between elements of y

invs =: {{ ; ([ , [: (<x)&, ])/ ": each ;/ y }} 

insXinY =: 4 : 0

NB. insert array into specified location in target array
NB. X - pos ; insert_array
NB. Y - target array

dx =. _1&+ # $ x

NB. p =. > {."dx  x
NB. ia =. > {:"dx  x

NB. xlist =. , x

p =. > {. x
ia =. > {: x 
ly =. # y

NB. sel =. ([: < {. + [: i. {:)"1 (] ,. [: 2&(-~/\) ly&(,~)) 0,p 

NB. (p&{. , ia&[ , p&}.) y
NB. ; (ia,a:) ,.~ y&({~) each sel

px =. {. p
py =. {: p

'iax iay' =. $ ia 

ia (< (px + i. iax) ; (py + i. iay) ) } y 
)

insXinYold =: 4 : 0

NB. insert array into specified location in target array
NB. X - pos ; insert_array
NB. Y - target array

dx =. _1&+ # $ x

p =. > {."dx  x
ia =.  {:"dx  x
ly =. # y

sel =. ([: < {. + [: i. {:)"1 (] ,. [: 2&(-~/\) ly&(,~)) 0,p 

NB. (p&{. , ia&[ , p&}.) y
; (ia,a:) ,.~ y&({~) each sel 
)

NB. DEC Line Drawing stuff - need to enable using decLineOn and disable w/ decLineOf 

CS_DL =: (27 { a.) , '('

decLineOn =: CS_DL , '0'
decLineOf =: CS_DL , 'B'

dlLR =: 'j'
dlUR =: 'k'
dlUL =: 'l'
dlLL =: 'm'
dlCR =: 'n'
dlHL =: 'q'
dlRT =: 't'
dlLT =: 'u'
dlBT =: 'v'
dlUT =: 'w'
dlVL =: 'x' 

NB. Ascii box drawing characters - may not always work ???

alUL =: 16 { a.
alUT =: 17 { a.
alUR =: 18 { a.
alRT =: 19 { a.
alCR =: 20 { a.
alLT =: 21 { a.
alLL =: 22 { a.
alBT =: 23 { a.
alLR =: 24 { a.
alVL =: 25 { a.
alHL =: 26 { a. 

NB. Default Box drawing characters

dalUL =: '+'
dalUT =: '+'
dalUR =: '+'
dalRT =: '+'
dalCR =: '+'
dalLT =: '+'
dalLL =: '+'
dalBT =: '+'
dalLR =: '+'
dalVL =: '|'
dalHL =: '-'

NB. basic escape code setting - note that stc 0 will reset things 

stc =: {{ (27&{ a.) , '[' , (": y) , 'm' }}

NB. set text color to RGB value y 

sttc =: [: stc [: '38;2;'&, ';'&invs

NB. set background color to RGB value y 

stbc =: [: stc [: '48;2;'&, ';'&invs


toXY =: [: CS_SE&, [: 'H'&(,~) ';'&invs 

escCode =: [ ,~ [: CS_SE&, ":@:] 

upN =: 'A'&escCode 
downN =: 'B'&escCode
rightN =: 'C'&escCode
leftN =: 'D'&escCode 
delN =: 'P'&escCode
eraseN =: 'X'&escCode
delNLine =: 'M'&escCode
insNLine =: 'L'&escCode

cNorm =: stc 0 
cBold =: stc 1
cBoldOff =: stc 22
cFaint =: stc 2
cFaintOff =: stc 22 
cUnd =: stc 4
cInv =: stc 7
cStrike =: stc 9 
cUndOff =: stc 24
cInvOff =: stc 27
cStrikeOff =: stc 29

saveScreen =: CS_SE , '?47h'
restScreen =: CS_SE , '?47l' 
saveScreenW =: CS_SE , '?1049h'
restScreenW =: CS_SE , '?1049l' 

clearLine =: 'K'&escCode    NB.  0 - to end of line, 1 - to beginning of line, 2 - whole line  
clearScreen =: 'J'&escCode 2

downNLine =: 'E'&escCode    NB. go to beginning of line N lines down 
upNLine =: 'F'&escCode      NB. go to beginning of line N lines up 

goColN =: 'G'&escCode

insNChar =: '@'&escCode 

saveLoc =: CS_SE , 's' 
restLoc =: CS_SE , 'u' 

txtAtXY =: 4 : 0

NB. put text at (xpos, ypos)
NB.
NB. X - (xpos , ypos) , (xret, yret) 
NB. Y - text to insert

xp =. 0&{ :: 0: x
yp =. 1&{ :: 0: x
xret =. 2&{ :: 0: x
yret =. 3&{ :: 0: x

xx =. puts__mvt (toXY xp, yp) , y , (toXY xret, yret) 

''
)

NB. resetScreen =: [: (2!:0) 'reset'&[ 

NB. getScreenSize =: [: ". [: (10&{ a.)&(-.~) [: (2!:0) 'stty size'&[ 

NB. clearScreen =: [: CS_SE&, '2J'&[ 

NB. try to make simple event loop without an explicit loop

NB. rkey =: 'libc.so.6 getchar i'&cd 
NB. putc =: 0 0 $ ('libc.so.6 putchar  n c') & cd
NB. putwc =: 0 0 $ ('libc.so.6 putwchar n w') & cd 
NB. puts =: putc"0 

randChars =: 3 : 0

numChar =. y

sz =. gethw__mvt ''

cscr__mvt ''

NB. resetScreen ''

NB. ((sttc 255 30 280) , 'a' , (stc 0)) (,~)"(_ 1) (toXY"1) ? 10 # ,: getScreenSize ''

NB. res =: ((sttc 255 30 280) , 'a' , (stc 0)) (,~)"(_ 1) toXY"1 ? numChar # ,: (_1&+) sz 

res =: ( [: < ((stbc 255 30 120),' ',(stc 0),(toXY 0 0))&[ ,~ toXY )"1 ? numChar # ,: (_1&+) sz 

for_currLine. res do.

  xx =. puts__mvt > currLine

end.

toXY 0 ,~ _1&+ {. sz 

upN 1
)

genColorGroup =: 3 : 0

NB. Given RGB color and choice of complementary, triadic, or tetradic
NB.
NB. return line with specified color + complementary / triadic / tetradic colors
NB.
NB. X - specifies complementary (2), triadic (3), or tetradic (4) (default = 2)
NB. Y - RGB - base color
NB.
NB. returns baseColor , other colors in group
NB.

2 genColorGroup y 

:

NB. make sure groupType = 2, 3, 4 

groupType =. 5 | <. x 

groupType =. (]) ` (2&[) @. (2&>) groupType

baseHSV =. rgb2HSV y

H =. {. baseHSV

Hg =. H + (2 * pi % groupType) * i. groupType

hsv2RGB"1 Hg ,"(0 2) }. baseHSV 
)

genColorSwatch =: 3 : 0

NB. take list of colors in RGB format and return string that generates bar w/ each color using escape codes 

; ( stbc each <"1 y ) ,"(0 _) < '  ',(stc 0)
)

colorTest =: 3 : 0

puts__mvt (10&{ a.) ,~ genColorSwatch hsv2RGB"1 (1 1)&(,~)"(_ 0) (2*pi)&* y&db i.y

''
)

simpleCommandLine =: 4 : 0

NB. simple command line prompt and entry
NB.
NB. X - command line location 
NB. y - command prompt
NB.

xx =. stdout (toXY x) , y , clearLine 0

(x + 0 , # y)  simpleLineEntry 30 13
)


buildDefCharTranslation =: 3 : 0

NB. return default character translation table
NB.
NB. table that tells us how to handle each character - ascii 0 - 255
NB.
NB. translation table specifies: pre-delta, post-delta, function (for deletions, insertions), display value
NB.

NB. default is to just display the character 

res =. a: ,. a: ,. a: ,. (32 # a:) , (<"0 a. {~ 32 + i.95) , 129 # a: 

NB. backspace - 

res =. ( (0 _1) ; (< 0 _1) , ('simpleEntryBackspace') ; '' )   (127) } res 

res
)

simpleEntryBackspace =: 3 : 0

NB. Backspace and erase character - just replace with space (don't do deletion yet)
NB.
NB. y - current position (position to erase) 
NB.
NB. return current position delta , count delta 
NB.

cp =. 2&{. y 

deltaCP =. ( ((0 _1)&[) ` ((0 0)&[) @. ([: 1&= {:) )   cp

cp =. cp + deltaCP 

xx =. stdout (toXY cp) , ' ' , (toXY cp)

deltaCP , _1 , {: y  
)

simpleEntryArrowKeys =: 4 : 0

NB. Handle alt-key and arrow keys 
NB.
NB. 27 - 91 - 65 , 66, 67, 68 - arrow keys
NB.
NB. 27 - ascii value - alt - char 
NB.
NB. x - arrow key code
NB. y - current position , attribs 
NB.
NB. reutrn current position delta, count delta 
NB.

cp =. 2 {. y 
attribs =. 2 { y
fk =. x

deltaCP =. 0 0 

if. (fk > 64) *. (fk < 69) do. deltaCP =. (fk - 65) { (_1 0) , (1 0) , (0 1) ,: (0 _1) end.

deltaCP , 1 , attribs 
)

simpleEntryHome =: 3 : 0

NB. go to first column of current line 

cp =. 2&{. y

0 , (1 - {: cp) , 0 , {: y 
)

simpleEntryEnd =: 3 : 0

NB. go to last column of current line - one column beyond where last character was entered

cp =. 2&{. y

'currLine currCol' =. cp 

0 , (1&+ currCol -~ currLine { buffLineEnd ) , 0 , {: y 
)

simpleEntryCommand =: 3 : 0

NB. Put up command prompt and run specified command

rawCommand =. (0 50) simpleCommandLine 'Command: ' 

procCommand =. < ;._1 ' ' , rawCommand

commandIndex =. (0&{"1 COMMAND_TRANS) i. {. procCommand

NB. run command - passing y as final boxed paremter - so functions can update position and attributes 

if. commandIndex < # COMMAND_TRANS do.
  res =. ". (> commandIndex { 1&{"1 COMMAND_TRANS) , ' procCommand , < y'  
else.
  NB. return - nothing happened  
  res =. 0 0 0 , {: y    
end.

res
)

simpleEntrySetInsert =: 3 : 0

NB. just set the mode to 1 - insert 

simpleEntryMode =: 1 

0 0 0 , {: > {: y
)

simpleEntrySetOver =: 3 : 0

NB. just set the mode to 0 - overwrite9

simpleEntryMode =: 0

0 0 0 , {: > {: y
)

simpleEntryReturn =: 3 : 0

NB. Handle char 11 - return
NB.
NB. y - current position
NB.

({: y) ,~ 1 ,~ (1 , 1&+@:(_1&*)@:{:) 2&{. y
)

simpleEntrySetColor =: 3 : 0

NB. Query user for color and set text color
NB.

col =. (0 50) simpleCommandLine 'Color (r g b): ' 
xx =. stdout (sttc ". col) 
xx =. stdout toXY y

(0 0 0) , {: y 
)

simpleEntryUnderline =: 3 : 0

NB. y - (cp_x, cp_y, currAttribs) 

attribList =. 2 2 2 2 2 #: {: y 
newUnd =. -. {. attribList 

if. newUnd do. xx =. stdout cUnd else. xx =. stdout cUndOff end.  

0 0 0 , #. newUnd 0 } attribList 
)

simpleEntryBold =: 3 : 0

NB. y - (cp_x, cp_y, currAttribs) 

attribList =. 2 2 2 2 2 #: {: y 
newBold =. -. 1&{ attribList 

if. newBold do. xx =. stdout cBold else. xx =. stdout cBoldOff end.  

0 0 0 , #. newBold 1 } attribList 
)

simpleEntryStrike =: 3 : 0

NB. y - (cp_x, cp_y, currAttribs) 

attribList =. 2 2 2 2 2 #: {: y 
newStrike =. -. 2&{ attribList 

if. newStrike do. xx =. stdout cStrike else. xx =. stdout cStrikeOff end.  

0 0 0 , #. newStrike 2 } attribList 
)

simpleEntryFaint =: 3 : 0

NB. y - (cp_x, cp_y, currAttribs) 

attribList =. 2 2 2 2 2 #: {: y 
newFaint =. -. 3&{ attribList 

if. newFaint do. xx =. stdout cFaint else. xx =. stdout cFaintOff end.  

0 0 0 , #. newFaint 3 } attribList 
)

simpleEntryInverse =: 3 : 0

NB. y - (cp_x, cp_y, currAttribs) 

attribList =. 2 2 2 2 2 #: {: y 
newInv =. -. 4&{ attribList 

if. newInv do. xx =. stdout cInv else. xx =. stdout cInvOff end.  

0 0 0 , #. newInv 4 } attribList 
)

simpleEntryGetChar =: 3 : 0

FULL_CHAR_TRANS simpleEntryGetChar y 

:

NB. get character from user and return line from character translation table
NB.
NB. y - ignored
NB.

currChar =: ,/ > rkey__mvt '' 

(<@:] ,~ x&[ {~ ]) currChar 
)

simpleLineEntry =: 4 : 0

NB. simple input
NB.
NB. x - starting insertion point 
NB. y - (max # characters) , ascii value of termination character
NB.
NB. return entered characters (not including termination character - if present) 
NB. 

cp =. x

maxChar =. {. y 
termChar =. {: y

numChar =. 0
rawChar =. _1

res =. 0 $ 0 

NB. Attributes - specified by bits: 0 - underline, 1 - bold, 2 - faint 

currAttribs =. 0 

NB. clear the rest of the line

xx =. stdout (toXY cp) , clearLine 0  

while. (numChar < maxChar) *. (-. rawChar -: termChar) do.

  NB. currChar = (pre-delta) ; post-delta ; process_function ; display_char 

  'preDelta postDelta procFun dispChar rawChar' =. SIMPLE_CHAR_TRANS simpleEntryGetChar ''

  DEBUG =: procFun ; rawChar 

  NB. if there is a character to display - handle it

  if. -. dispChar -: '' do.

    startCP =. cp + (] ` ((0 0)&[) @. (''&-:)) preDelta
    endCP =. cp + (] ` ((0 1)&[) @. (''&-:)) postDelta 
    numChar =. numChar + 1
    xx =. stdout (toXY startCP) , dispChar 

    res =. res , dispChar 

    cp =. endCP

  elseif. -. procFun -: '' do.

    funRes =. 3&{. ". procFun , ' cp'  
    cp =. cp + }: funRes
    numChar =. numChar + {: funRes 
    res =. numChar {. res
    xx =. stdout (toXY cp) 

  end.    

end. 

res   
)


simpleEntrySetChar =: 4 : 0

NB. set current location on screen to specified character,
NB. set current position in text buffer to specified character
NB. set current position in format buffer to current format code

NB. X - current position , current format code
NB. Y - current character

currPos =. 2&{. x

'currLine currCol' =. currPos 

currAttribs =. 2&{  x

xx =. stdout (toXY currPos) , y

NB. insert character into text buffer and current format into format buffer

tbuff =: y (< currPos + tbuffOff ) } tbuff
fbuff =: currAttribs (< currPos + fbuffOff ) } fbuff 

NB. update line and column limits

if. currLine > buffLastLine do.
  buffLastLine =: currLine
elseif. currLine < buffFirstLine do. buffFirstLine =. currLine end.

if. currCol > currLine { buffLineEnd do.
  buffLineEnd =: currCol currLine } buffLineEnd
elseif. currCol < currLine { buffLineBeg do.
  buffLineBeg =: currCol currLine } buffLineBeg
end. 
  
a: 
)

simpleEntryInsertChar =: 4 : 0

NB. insert character into current location on screen 
NB. insert character into current position in text buffer 
NB. insert format code into current position in format buffer

NB. X - current position , current format code
NB. Y - current character

currPos =. 2&{. x

currtbuffPos =. currPos + tbuffOff
currfbuffPos =. currPos + fbuffOff 

'currLinetbuff currColtbuff' =. currtbuffPos
'currLinefbuff currColfbuff' =. currfbuffPos 

'currLine currCol' =. currPos 

currAttribs =. 2&{ x 

NB. insert character into text buffer
NB. first need to figure out if inserting character will over-run end of line

if. (currCol > currLine { buffLineEnd) +. (currLine > buffLastLine)  do.

  NB. if insertion point is past buffLineEnd for current line
  NB. or insertion point is past buffLastLine 
  NB. then just set the data into the buffer and update limits 

  x simpleEntrySetChar y

else.

  NB. we will have to do an actual insert operation

  NB. insert character onto screen 

  xx =. stdout (toXY currPos) , (insNChar 1) , y  

  if. screenLineLen <. 1&+ currLine { buffLineEnd do.

    NB. text still fits on line after we insert character
    NB. just insert the character and shift other characters down

    rawLine =. currLinetbuff { tbuff 

    newLine =. ( currColtbuff&{. , y&[ , [: }: currColtbuff&}. ) rawLine 

    DEBUG =: newLine 

    rawFmtLine =. currLinefbuff { fbuff

    newFmt =. ( currColfbuff&{. , currAttribs&[ , [: }: currColfbuff&}. ) rawFmtLine

    tbuff =: newLine currLinetbuff } tbuff

    fbuff =: newFmt currLinefbuff } fbuff 

    NB. increment current end of line  

    rawLineEnd =. currLine { buffLineEnd 

    buffLineEnd =: (rawLineEnd + 1) currLine } buffLineEnd 

  end. 

end. 
  
a:
)

simpleEntryBackspace2 =: 4 : 0

NB. Backspace - delete character to the left of the current position 
NB. 

NB. X - current position , current format code
NB. Y - ignored 

currPos =. 2&{. x

currtbuffPos =. currPos + tbuffOff
currfbuffPos =. currPos + fbuffOff 

'currLinetbuff currColtbuff' =. currtbuffPos
'currLinefbuff currColfbuff' =. currfbuffPos 

'currLine currCol' =. currPos 

currAttribs =. 2&{ x 

NB. insert character into text buffer
NB. first need to figure out if inserting character will over-run end of line

if. (currCol > currLine { buffLineEnd) +. (currLine > buffLastLine)  do.

  NB. if insertion point is past buffLineEnd for current line
  NB. or insertion point is past buffLastLine 
  NB. then just set the data into the buffer and update limits 

  x simpleEntrySetChar y

else.

  NB. we will have to do an actual insert operation

  NB. insert character onto screen 

  xx =. stdout (toXY currPos) , (insNChar 1) , y  

  if. screenLineLen <. 1&+ currLine { buffLineEnd do.

    NB. text still fits on line after we insert character
    NB. just insert the character and shift other characters down

    rawLine =. currLinetbuff { tbuff 

    newLine =. ( currColtbuff&{. , y&[ , [: }: currColtbuff&}. ) rawLine 

    DEBUG =: newLine 

    rawFmtLine =. currLinefbuff { fbuff

    newFmt =. ( currColfbuff&{. , currAttribs&[ , [: }: currColfbuff&}. ) rawFmtLine

    tbuff =: newLine currLinetbuff } tbuff

    fbuff =: newFmt currLinefbuff } fbuff 

    NB. increment current end of line  

    rawLineEnd =. currLine { buffLineEnd 

    buffLineEnd =: (rawLineEnd + 1) currLine } buffLineEnd 

  end. 

end. 
  
a:
)

simpleEntry =: 3 : 0

NB. Test out some simple data entry stuff 
NB.
NB. X - maximum number of iterations to run (default 10) 
NB. Y - ascii value to terminate on 

10 simpleEntry y 

:

NB. make sure we have character translations set

SIMPLE_CHAR_TRANS =: buildDefCharTranslation ''
FULL_CHAR_TRANS =: SIMPLE_CHAR_TRANS

NB. add handlers for set color - 11, return - 13, arrow keys - 27

FULL_CHAR_TRANS =: ( '' ; '' ; ('simpleEntrySetColor') ; '' )   (11) } FULL_CHAR_TRANS
FULL_CHAR_TRANS =: ( '' ; '' ; ('simpleEntryReturn') ; '' )   (13) } FULL_CHAR_TRANS
FULL_CHAR_TRANS =: ( '' ; '' ; ('simpleEntryAlt') ; '' )   (27) } FULL_CHAR_TRANS
FULL_CHAR_TRANS =: ( '' ; '' ; ('simpleEntryUnderline') ; '' )   (21) } FULL_CHAR_TRANS
FULL_CHAR_TRANS =: ( '' ; '' ; ('simpleEntryBold') ; '' )   (22) } FULL_CHAR_TRANS
FULL_CHAR_TRANS =: ( '' ; '' ; ('simpleEntryFaint') ; '' )   (6) } FULL_CHAR_TRANS
FULL_CHAR_TRANS =: ( '' ; '' ; ('simpleEntryStrike') ; '' )   (19) } FULL_CHAR_TRANS
FULL_CHAR_TRANS =: ( '' ; '' ; ('simpleEntryInverse') ; '' )   (9) } FULL_CHAR_TRANS
ALT_CHAR_TRANS =: 256 4 $ a:
ALT_CHAR_TRANS =: ( '' ; '' ; ('simpleEntryCommand') ; '' ) (97) } ALT_CHAR_TRANS

COMMAND_TRANS =: ('insert' ; 'simpleEntrySetInsert' ) , ('over';'simpleEntrySetOverwrite') ,: ('date' ; 'simpleEntryInsertDate')  

r =. ''

xx =. 2!:0 'stty raw -echo'

maxIter =. x 

iterCount =. 0 

xx =. stdout clearScreen ''

xx =. stdout toXY 2 1
cp =. (2 1)

res =. ''

rawChar =. _1 

currAttribs =. 0 

NB. initialize textBuffer and formatBuffer

screenLineLen =: 180 
screenLineNum =: 1000

NB. text buffer and format buffer initialized to all 0's 

tbuff =: (screenLineNum , screenLineLen) $ 0 { a. 

tbuffOff =: (_1 _1)

fbuff =: (screenLineNum, screenLineLen) $ 0 

fbuffOff =: (_1 _1) 

NB. vectors holding beginning and ending character of each line - initialize them to all ones (e.g. each line starts and ends on first character of line) 

buffLineBeg =: screenLineNum # 1
buffLineEnd =: screenLineNum # 1 

buffFirstLine =: 1
buffLastLine =: 1 

NB. entry modes - 0 - overwrite , 1 - insert (this one will be fun) 

simpleEntryMode =: 0   

while. (iterCount < maxIter) *. (-. y -: rawChar) do.

       'preDelta postDelta procFun dispChar rawChar' =. FULL_CHAR_TRANS simpleEntryGetChar ''

       NB. if rawChar -: 27 - need to do a little more work

       NB. Alt-key - call appropriate function - if one is defined (should move this into main loop ????)

       if. rawChar -: 27 do.

       	   NB. Start of escape sequence - 
       	   NB. need to get multiple characters 
	   NB.

	   NB.  
	   NB. 27 - 48 ... 57  - alt - 0 .... alt - 9
	   NB. 
	   NB. 27 - 91 - 49 - 126 - home
	   NB. 27 - 91 - 50 - 126 - insert 
	   NB. 27 - 91 - 51 - 126 - delete
	   NB. 27 - 91 - 52 - 126 - end
	   NB. 27 - 91 - 53 - 126 - page up
	   NB. 27 - 91 - 54 - 126 - page down
	   NB.
	   NB. 27 - 91 - 65 ... 68 - arrow keys
	   NB.
	   NB. 27 - 97 ... 122  - alt - a .... alt - z
	   NB.

	   NB. 91 - means that we got an arrow key next - use arrow key functions 
	   NB. other values mean that we have just another key - where A is 97
	   NB. In this case, look up handler function in ALT_CHAR_TRANS table 

	   nextKey =. ,/ > rkey '' 

	   if. nextKey -: 91 do.

	       NB. need to get another key

	       nextKey2 =. ,/ > rkey '' 

	       if. (nextKey2 > 64) *. (nextKey2 < 69) do. 

	       	   NB. set processing function to simpleEntryArrowKeys

	       	   procFun =. 'rawChar&simpleEntryArrowKeys'

		   rawChar =. nextKey2

	       elseif. (nextKey2 > 48) *. (nextKey2 < 55) do.

	       	   NB. home, page up, page dn, end, delete 

		   rawChar =. nextKey2

		   procFun =. > (rawChar - 49) { 'simpleEntryHome';'simpleEntryInsert';'simpleEntryDelete';'simpleEntryEnd';'simpleEntryPageUp';'simpleEntryPageDown'

		   NB. eat next character

		   xx =. rkey '' 

	       end. 

	   else.

		NB. Look up handler function in ALT_CHAR_TRANS
		
		procFun =. > 2&{ nextKey { ALT_CHAR_TRANS

	   end. 

       end. 

       if. -. dispChar -: '' do.

       	   NB. insert:
	   NB.    dispChar into screen
	   NB.    dispChar into text buffer
	   NB.    format code into format buffer
	   NB.
	   
    	   startCP =. cp + (] ` ((0 0)&[) @. (''&-:)) preDelta
    	   endCP =. cp + (] ` ((0 1)&[) @. (''&-:)) postDelta 

	   if. simpleEntryMode -: 0 do.

	       xx =. (cp , currAttribs) simpleEntrySetChar dispChar

	   else.

	       xx =. (cp, currAttribs) simpleEntryInsertChar dispChar

	   end. 

    	   res =. res , dispChar 

    	   cp =. endCP

       elseif. -. procFun -: '' do.

       	       funRes =. ". procFun , ' cp , currAttribs'  
	       DEBUG =: funRes 
	       cp =. cp + 2&{. funRes
	       currAttribs =. 3&{ funRes 
	       NB. numChar =. numChar + 2&{ funRes 
	       NB. res =. numChar {. res
	       
       end. 

       iterCount =. >: iterCount 

       xx =. stdout (toXY 1 10) , (4 ": cp ) , ' ' , (8 ": iterCount) , ' ' , (4 ": rawChar) , ' ' , ({. dispChar , ' ') , ' ' , (4 ": currAttribs) , ' ' , (4 ": simpleEntryMode) , toXY cp 

end.

xx =. (2!:0) 'reset'

res
)  

boxAtXY =: 3 : 0

1 1 1 1 boxAtXY y

:

NB. expect y to by NxM character array - put on screen with upper left corner at (2 {. x) and then return to (_2 {. x) when done

NB. Some ideas for next steps:
NB. - clip bits that don't fit on screen 

nline =. # y

xp =. (i. nline) + {. x

puts_vt_ utf8 (toXY 2&}. x) ,~ ; (_2 <@:toXY\ , xp ,. 1&{ x) ,. <"_1 y 

NB. $ y
)

randBoxes =: 3 : 0

NB. just put set of random "boxes" on screen
NB.
NB. x - number to display (def = 10) 
NB. y - box contents
NB.

10 randBoxes y

: 

NB. screenSize =. getScreenSize ''
screenSize =. gethw_vt_ '' 

stdout saveLoc  

for_ii. i. x do.

  (1 1 ,~ ? screenSize) boxAtXY y 

end.

NB. stdout restLoc
puts_vt_ stdout restLoc 
)

boxAL =: 3 : 0

NB. given one or two dimensional object,return the object in a box
NB.
NB. Draw box using Ascii or DEC line drawing graphics - may not be supported on all terminals 
NB.
NB. X - 0 - use ascii (default) , 1 - use DEC line drawing
NB.

0 boxAL y

:

boxType =. > 0&{ :: 0: x

borderFormat =. > 1&{ :: 0: x

borderColor =. > 2&{ :: (255 255 255)&[ x

borderBack =. > 3&{ :: (0 0 0)&[ x 

setFormat =. (decodeFormat borderFormat) , (sttc borderColor) , stbc borderBack
clrFormat =. (decodeFormat 16) , (sttc 255 255 255) , stbc 0 0 0 

NB. make sure that data to be printed is a string 

data =. ": y 

if. 1 = # $ data do.

  data =. ,: data

end. 

NB. two dimensional data

'nrow ncol' =. $ data

if. boxType -: 1 do. 

  topLine =. decLineOn , dlUL , (ncol # dlHL) , dlUR , decLineOf , decLineOn , decLineOf 

  botLine =. decLineOn , dlLL , (ncol # dlHL) , dlLR , decLineOf , decLineOn , decLineOf 
  	  
  sideLine =: (] $~ [: nrow&, #) decLineOn , dlVL ,  decLineOf

elseif. boxType -: 2 do. 

  topLine =. alUL , (ncol # alHL) , alUR 

  botLine =. alLL , (ncol # alHL) , alLR 

  sideLine =: (] $~ [: nrow&, #) , alVL 

else.

  topLine =. dalUL , (ncol # dalHL) , dalUR 

  botLine =. dalLL , (ncol # dalHL) , dalLR 

  sideLine =: (] $~ [: nrow&, #) , dalVL

end. 

sideLineFormatted =. (setFormat ,"(_ 1) sideLine ,"(1 _) clrFormat)

(setFormat , topLine , clrFormat) , ( sideLineFormatted  ,. data ,. sideLineFormatted ) , setFormat , botLine , clrFormat 
)

decodeFormat =: {{)v

  NB. given a format character - return string that sets the format
  NB.
  NB. Y - format code
  NB.   - bit 0 - bold
  NB.   - bit 1 - underlined
  NB.   - bit 2 - strikeout
  NB.   - bit 3 - faint
  NB.   - bit 4 - normal 

  dec =. _5&{. (0 0 0 0 0 0 0) , #: y 

  
  ; dec # (cNorm;cFaint;cStrike;cUnd;cBold) 
}}


boxALXY =: 3 : 0

NB. put a box of stuff at specified position and then go to specified ending position
NB.
NB. X - (xp , yp - upper left of box) , (xtp , ytp - terminal position) ; (boxType ; border format code; border color ; border background color -  see boxAL)- 
NB. Y - text to place at (xp, yp) 
NB.
NB. box up stuff using call to boxAL - currently use lowest common denominator ascii box drawing characters
NB.

(< 20 40 0 0) boxALXY y

:

boxLocation =. > 0&{ x 

boxFormat =. }. x 

boxLocation boxAtXY boxFormat&boxAL y

)

boxTxt2 =: 3 : 0 

NB. try to create a box function that corrects for invisible / non-printing / formatting characters
NB.
NB. X - (nrows - default=0 , ncols - default 20) - size of box to put text into.  If nrows=0, compute nrows based on ncols 
NB. Y - raw text - potentially with formatting characters
NB.
NB. Want to format into (nrows x ncols) blob of text - as if non-printing characters aren't present
NB.
NB. Sequences that we want to ignore - for purposes of folding text - start with 1B and end w/ 44, 48, 6D
NB. 
NB. strategy - locate each set of non-printing characters, pull them out of text, fold text so that it fits into (nrows x ncols) box, re-insert formatting charactes
NB. 
NB. Cases that we likely won't handle well - formatting that starts on one line and ends on another line - likely will cause problems displaying text
NB. - possible solution is to reset text to normal at end of line and then reset formating at beginning of next line 
NB.

(0 20) boxTxt2 y

:

nrows =. 0&{ :: 0: x
ncols =. 1&{ :: 20&[ x

NB. identify all instances of the starting format character - 1B and ending format characters 44, 48, 6D 

strtFmt =. 16b1b { a.
endFmt =. (16b44 16b48 16bd) { a. 



1
)

testEnt =: 3 : 0

NB. mess around with a trivially stupid user interface 

xx =. stdout clearScreen ''

xx =. stdout toXY 0 0

inLine =. ''

currLine =. 10 

while. -. inLine -: 'q' do.

  inLine =. ,/ ,/ > fr_base_ '' 

  if. -. inLine -: 'q' do.

    xx =. stdout (toXY currLine, 10), cBold , inLine , cBoldOff , (toXY 0 0) , (clearLine 0) , (toXY 0 0) 

    currLine =. 10 + 10 | currLine + 1 

  end. 

end. 

1
)


simpleEntry2_initDefCharTable =: {{)v

def =. (< '') ,.~ ((0 0) ; (0 0)) ,"(_ 0) 32 # <'' 

def =. def , (<'') ,.~ ((0 0) ; (0 1)) ,"(_ 0) <"0 (32 }. i.128) { a.

def =. def , (<'') ,.~ ((0 0) ; (0 0)) ,"(_ 0) 128 # <'' 

def
}}


simpleEntry2_initAltCharTable =: {{)v

altCharTable =. a: ,.~ ((0 0) ; (0 0)) ,"(_ 0) <"0 (i.256) { a. 

altCharTable 
}}

simpleEntry2_initArrCharTable =: {{)v

arrCharTable =. a: ,.~ ((0 0) ; (0 0)) ,"(_ 0) 256 # < ''  

arrCharTable =. ((0 0) ; (0 _1) ; '' ; '' ) 37 } arrCharTable 
arrCharTable =. ((0 0) ; (_1 0) ; '' ; '' ) 38 } arrCharTable
arrCharTable =. ((0 0) ; (0 1) ; '' ; '' ) 39 } arrCharTable 
arrCharTable =. ((0 0) ; (1 0) ; '' ; '' ) 40 } arrCharTable

arrCharTable 
}}


simpleEntry2 =: {{)v

NB. Simple text area - take 2 (or maybe 3 or 4)
NB.
NB. Y - maximum number of characters 

maxChar =. y

term =. 0

currPos =. 2 1 

numChar =. 0 

NB. initialize character translation tables
NB. Define how to handle various ascii values when no modifier key pressed
NB.
NB. Each table has 256 rows and columns:
NB. - preDelta - number of spaces to advance prior to displaying character - (dx, dy) 
NB. - postDelta - number of spaces to advance post displaying character (dx, dy) 
NB. - dispChar character to display
NB. - procFun - function to call

NB. 'preDelta postDelta dispChar procFun' =. SIMPLE_CHAR_TRANS simpleEntryGetChar ''

DEF_CHAR_TRANS =. simpleEntry2_initDefCharTable ''
ALT_CHAR_TRANS =. simpleEntry2_initAltCharTable '' 
ARR_CHAR_TRANS =. simpleEntry2_initArrCharTable ''

NB. initialization code

puts_vt_ clearScreen  

toXY currPos 

NB. main iteration loop 

while. (term = 0) *. (numChar < maxChar)  do.

  'currAscii keyDetail' =. rkey_vt_ ''

  'd0 charBase d1 charAscii charMod d2' =. keyDetail 

  puts_vt_ (toXY 0 5), ('%3d %3d %3d %3d %3d %3d'&sprintf keyDetail) , (toXY currPos) 

  if. ( (charMod = 0) +. (charMod = 16) ) *. (charAscii > 0)  do.

    NB. need to convert character - handle obnoxious characters that don't really print anything (e.g ESC) and Enter

    'preDelta postDelta dispChar procFun' =.charAscii { DEF_CHAR_TRANS 

  elseif. charMod = 8 do.

    NB. control character 

    

  elseif. charMod = 2 do.

    NB. alt character

    'preDelta postDelta procFun dispChar rawChar' =. charAscii { ALT_CHAR_TRANS 

  elseif. charMod = 10 do.

    NB. control - alt


  elseif. charMod = 24 do.

    NB. control - shift

  elseif. charMod = 256 do.

    NB. arrow keys, home, end, etc

    'preDelta postDelta dispChar procFun' =. charBase { ARR_CHAR_TRANS 

  end.

  NB. take action(s) returned by key entry 

  currPos =. currPos + preDelta

  if. 0 < # dispChar  do.
      puts_vt_ (toXY currPos) , dispChar
  end. 

  if. postDelta -.@:-: (0 0) do. 
      currPos =. currPos + postDelta
      puts_vt_ (toXY currPos)
  end. 

  numChar =. numChar + 1

end. 

puts_vt_ toXY 0 0 
}}

simpleEntry2_win2scr =: {{)v



}}


simpleWindow =: {{)v

(,: a: , a:) simpleWindow y 

:

NB. simple window display
NB.
NB. X - Window Options - as an Nx2 set of name value pairs 
NB. Y - one D boxed list - each box contains one line of content 
NB.
NB. window size will be (N+2)x(M+2) - due to border
NB.

NB. default options

wp =. 10 10 

ws =. 20 20 

bc =. 255 255 255
bb =. 0 0 0
wc =. 255 255 255
wb =. 0 0 0

wtitle =. 'mr window' 

NB. parse the x-options
NB.
NB. default values for all allowed parameters

defParams =.(('wp';10 10) , ('ws';10 20) , ('wc'; 255 255 255) , ('wb'; 0 0 0) , ('wtitle';'') , ('bc';255 255 255) , ('bb';0 0 0) ,: ('bt' ; 1))

'wp ws wc wb wtitle bc bb bt' =. defParams simpleWindowParams x 

'xp yp' =. wp
'xs ys' =. ws 

NB. first cut - don't bother trying very hard

NB. step one - construct the pieces for our empty window - top line, "body" lines, bottom line

NB.  topLine =.  dalUL , (xs # dalHL) , dalUR
NB.  sideLine =. dalVL 
NB.  botLine =. dalLL , (xs # dalHL) , dalLR 

topLine =.  dlUL , (ys # dlHL) , dlUR
sideLine =. dlVL 
botLine =. dlLL , (ys # dlHL) , dlLR 


NB. put the basic window border 

xx =. puts__mvt decLineOn 
xx =. (puts__mvt (toXY (xp + xs + 1) , yp) , botLine) , ( ([: puts__mvt sideLine&[ ,~ [: toXY (yp+ys+1)&[ ,~ xp&+)"0 (1&+ i.xs) ) , ( ([: puts__mvt sideLine&[ ,~ [: toXY yp&[ ,~ xp&+)"0 (1&+ i.xs) ) , (puts__mvt (toXY xp, yp) , (sttc bc) , (stbc bb) , topLine)
xx =. puts__mvt decLineOf 

NB. put in the background - sort of wasteful - it is all going to get overwritten :( 

xx =. puts__mvt (toXY 1 + yp, xp) , (sttc wc) , (stbc wb) 	 

for_iline. 1&+ i.xs do.

  xx =. puts__mvt  (sttc wc) , (stbc wb)  , (toXY (xp+iline) , yp + 1) , ys # ' '  

end. 

NB. now put in the content

xx =. puts__mvt (toXY 1 + xp , yp) , (sttc wc) , (stbc wb)	

for_iline. i. # y do.

  xx =. puts__mvt (toXY 1&+ yp ,~ xp + iline) , > iline&{ y 

end. 

xx =. puts__mvt (toXY 0 0) , (sttc 255 255 255) , (stbc 0 0 0) 

0 $ 0 
}}

simpleWindowParams =: {{)d

NB. given Nx2 boxed list of allowed parameters w/ default values
NB. and Nx2 boxed list of passed parameters - return list of actual values for specific case
NB.
NB. x - Nx2 - list of allowed parameters w/ default values
NB. y - Mx2 - boxed list - parameters to parse
NB.
NB. return boxed list of length N with parameter values 

defParams =. x
parseParams =. y 

NB. set defaults 

for_currParam. defParams do.

  (": > {. currParam) =. > {: currParam

end.

NB. filter parameters to parse

numAllowedParams =. # defParams
allowedParams =. {."1 defParams 

parseParams =. (] #~ [: numAllowedParams&> [: allowedParams&i. 0&{"1) parseParams 

NB. set overrides

for_currParam. parseParams do.

  (": > {. currParam) =. > {: currParam

end.


". ' ' -.~ }: ,/ ';' ,.~ > allowedParams 
}}

NB. parsing parameters - have allowed list with default values 


simpleMarkdownToConsole =: {{)v

  NB. given a blob of text "formatted" some set of markup tags -
  NB.
  NB. Initially look to support formatting that works in the console
  NB.
  NB.	Underline
  NB.	Faint
  NB. 	Strikethrough
  NB.
  NB.   Foreground color
  NB.
  NB.   Background color
  NB.
  NB.   Center - only makes sense when we have a line length defined
  NB.
  NB.   Left justify
  NB.
  NB.	Right justify 
  NB.
  NB. Let's try my own stupid markup language:
  NB.   [] - set formatting:
  NB. 	[B] bold on (doesn't work in Windows console :(
  NB.   [U] underline on
  NB. 	[F] faint on
  NB.	[S] strikeout on
  NB.   [b] disable bold
  NB.	[u] underline off 
  NB.   [f] faint off
  NB. 	[s] strikeout off
  NB. 	[n] - normal - also sets the color
  NB. 	[C] - center applies to rest of line (??? - probably not the best way to handle
  NB.   <> - set colors
  NB.   <c: xx xx xx> - set foreground color (more compact to do as 6 digit hex ?????) 
  NB.   <b: xx xx xx> - set background color
  NB.
  NB. Given text with these tags and a line length - generate set of lines with inserted formatting strings where max line length of visible characters == specified line length
  NB.
  NB. can do this with a fold.  for now use a simple loop - see about converting to fold in future
  NB.

  cp =. 0		NB. current character position in line
  lc =. 0	    	NB. line count
  cformat =. ''		NB. current formatting - e.g. 'UF' would be underline and faint
  fcolor =. 255 255 255	NB. current foreground color 
  bcolor =. 0 0 0   	NB. current background color

  textBuff =. '' 	NB. output text buffer 

  

}}

simpleLine =: {{)d

NB. draw a simple line with characaters (111 112 114 115) from DEC line drawing characters
NB.
NB. x - Nx2 boxed list with window definitions - see simpleWindow 
NB. y - set of points to plot - assume evenly spaced for this simple first cut
NB.
NB. return array of characters 

NB. filter params array to only allowed options - these needs to be put into a function !!!!!!

params =. (] #~ [: 8&> [: ('bc';'bb';'bt';'wc';'wb';'wtitle';'wp';'ws')&i. 0&{"1) x  

NB. set overrides

for_currParam. params do.

  (": > {. currParam) =. > {: currParam

end. 

'xp yp' =. wp
'xs ys' =. ws

NB. figure out some scaling

ymin =. min y
ymax =. max y 
yrange =. ymax - ymin

yscale =. 0.8 * ys % yrange 

scaledPointsY =. <. yp + (0.92&* ys) -  yscale * y - ymin 

for_ipoint. i. # scaledPointsY do.

  puts__mvt (toXY (yp+1) , (xp+1)) , sttc wb
  
  puts__mvt (toXY (ipoint { scaledPointsY) , xp + 1 + ipoint),' '

end. 

puts__mvt (toXY 1 1) , stbc 0 0 0

''
}}

NB. weztern specific functions
NB.

wrapImage =: {{)v

NB. given supported image type - display, putting upper left corner of image at current screen position
NB.
NB. does this using iterm2 protocol that takes a base64 encoded image and displayes it 
NB.

'height width' =. 2&{. $ y 

height =. ": height
width =. ": width

((27 93)&{ a.)  , '1337;File=size=;height=auto;width=auto;inline=1:' , ( (27 92)&{"1 a. )  ,~ (3!:10) y 
}}

putImageXY =: {{)v

NB. put image y on screen at position x
NB.
NB. x - position to place image (default 1 1), position to go to after placing image (default 1 1) 
NB. y - image 
NB.

1 1 1 1 putImageXY y 

:

puts__mvt (toXY 2&{. x) , wrapImage y
puts__mvt (toXY 1 + 2&{. x)
puts__mvt (toXY 2&}. x) 

''
}}


getBMPSize =: {{)v

NB. Given BMP image content return the size - (X x Y)
NB.
NB. y - BMP file as a single array of bytes
NB.

_2&(3!:4) (18 + i.8)&{ y 
}}

dispImageWindow =: {{)d

NB. given image as a string and (Nx2) boxed array describing a window, display the image in the window
NB.
NB. x - window definition - window size adjusted to hold image
NB. y - image as a string - currently only supports BMP (will add PNG in the future) 
NB.

defParams =.(('wp';10 10) , ('ws';10 20) , ('wc'; 255 255 255) , ('wb'; 0 0 0) , ('wtitle';'') , ('bc';255 255 255) , ('bb';0 0 0) ,: ('bt' ; 1))

'wp ws wc wb wtitle bc bb bt' =. defParams simpleWindowParams x 

imageSize =. getBMPSize y

'wsx wsy' =. ws

'imgy imgx' =. imageSize 

minImgX =. >. 0.5&+ imgx % 23 
minImgY =. >. 0.5&+ imgy % 10

wsx =. minImgX >. wsx
wsy =. minImgY >. wsy

xx =. puts__mvt ( ({. , ('ws'; wsx , wsy)&[ , 2&}.) x ) simpleWindow ''

xx =. (1 1 ,~ 1 + wp) putImageXY y 

}}


arrayToBMP =: {{)v

NB. convert array - assumed to be N x M x 3 matrix to a BMP - suitable for display with wrapImage, etc.
NB.
NB. y - array to convert to BMP
NB.
NB. use streamBMP function added to BMP package 
NB.

NB. y writebmp jpath '~temp/convert_bmp.bmp'

NB. fread jpath '~temp/convert_bmp.bmp'

y streambmp_jbmp_ '' 
}}

linePoints =: {{)v

NB. given start point, end point, and total number of points - return set of points
NB.
NB. y - (xs, ys) , (xe, ye) , npoints
NB.

'xs ys xe ye npoints' =. y

delta =. npoints %~ (xe , ye) - (xs , ys)

(xs, ys) +"(_ 1) (delta) *"(_ 0) i. npoints 
}}

insLineArr =: {{)d

NB. insert line - specified by x - into array y
NB.
NB. x - define line - (xs, ys) , (xe, ye)
NB. y - N x M array -
NB.
NB. Line is clipped to display - (xs,ys) and (xe,ye) less than zero ==> set to 0 , etc.
NB.

insertValue =. {: x 

points =. }: x 

NB. clip to array size

'arrXs arrYs' =. $ y 

'xs ys xe ye' =. (0: ` ] @. (0&<)) points

'xs xe' =. ( (<: arrXs)&[ ` ] @. (arrXs&>)) xs , xe 
'ys ye' =. ( (<: arrYs)&[ ` ] @. (arrYs&>)) ys, ye 

NB. figure out number of points we'll need

npoints =. >. %: +/ *: (xe - xs) , (ye - ys) 

insertValue ( ~. ([: <. 0.5&+) linePoints xs,ys,xe,ye,npoints ) } y
}}

insMultLineArr =: {{)d

NB. insert multiple lines into an area
NB. 
NB. x - N x 4 array - each line of x specifies line and insert value for a line
NB. y - array

res =. y 

for_currLine. x do.

  res =. currLine insLineArr res

end.

res
}}	

insPathArr =: {{)d

NB. insert a path into an array
NB.
NB. x - (x0, y0 , x1, y1, .....xn , yn) ; insertValue (default == 1) ; closePath (def = 0) ; fillShape 
NB. y - target array for insert
NB.

insertValue =. > 1&{ :: 1: x 

closePath =. > 2&{ :: 0: x

fillShape =. > 3&{ :: 0: x 

rawPath =. > 0&{ x

if. closePath do.

  if. (_2&{. rawPath) -.@-: (2&{. rawPath) do.

    rawPath =. (] , 2&{.) rawPath

  end.

end. 

pathSegs =. (] $~ 4: ,~ [: 4&(%~) #) , }: }. 2&# (] $~ 2: ,~ [: <. [: 2&(%~) #) rawPath 

(pathSegs ,. insertValue) insMultLineArr y 
}}

genPathPoints =: {{)v

NB. given set of points that define a path - return "complete" set of points that will allow us to "draw" path
NB.
NB. y - N point path - specified by 2*N total integers - (x1, y1, ... xN, yN)
NB. 

pathSegs =. (] $~ 4: ,~ [: 4&(%~) #) , }: }. 2&# (] $~ 2: ,~ [: <. [: 2&(%~) #) y

 ~.@:<.@:(0.5&+) ; <@:linePoints"_1 (] ,. [: >.@:(1.3&*)@:(>./"1)  _2&{."1 |@- 2&{."1) pathSegs 
}}

fillPathSim =: {{)v

NB. given set of vertex points defining path, compute set of points needed to generate filled shape
NB.
NB. y - vertex points 

bp =. /:~ genPathPoints y 

fp =. ; (,/@:>@:{. (,. :: (0$0)&[) >@:{:) each (0&{"1 <@:( ~.@:(0&{"1) ; 1&{"1 -.~ ({. + [: i. {: - {.)@:(min,max)@:(1&{"1) ) /. ]) bp

bp ; fp 
}}

insTriangleArr =: {{)d

NB. x - three points , value to insert - (x0, y0, x1, y1, x2, y2) , insertColor 
NB. y - target array 

(< x) insPathArr y 
}}


viewMatSim =: {{)v

ct_grey viewMatSim y

:

NB. display matrix in a simplified viewmat type at current cursor position 
NB.
NB. x - color map - maps matrix entries to colors, defaults to greyscale 
NB. y - array to display
NB.

xx =. puts__mvt wrapImage arrayToBMP y {"(0 _) x

smoutput ' '
smoutput ' ' 
}}

viewMatSimG =: {{)v

ct_grey viewMatSimG y 

:

NB. view a matrix using a grey scale
NB.
NB. x - color scheme to use - defaults to ct_grey 
NB. y - matrix to view

minData =. min , y
maxData =. max , y 


ct_grey viewMatSim <. 0.5&+ (255 % (maxData - minData)) * minData -~ y 
}}

genLinePlotPoints =: {{)d

NB. generate path points for a simple line plot
NB.
NB. x - (imgX, imgY) - size of image
NB. y - Nx2 - unscaled points to plot - will be scaled to 70% of plot window with origin 15% from x+y edges
NB.

rawPoints =. |."1 y 

'imgX imgY' =. x

pwx =. imgX - >. 0.15 * imgX
pwy =. >. 0.15 * imgY

pwRangeX =. >. 0.7 * imgX
pwRangeY =. >. 0.7 * imgY 

minX =. min 0&{"1 rawPoints
maxX =. max 0&{"1 rawPoints

minY =. min 1&{"1 rawPoints 
maxY =. max 1&{"1 rawPoints

rangeX =. maxX - minX
rangeY =. maxY - minY

smoutput imgX, imgY, pwx, pwy, pwRangeX, pwRangeY, minX, maxX, minY, maxY, rangeX, rangeY 

scaledPointsX =. <. pwx - (pwRangeX % rangeX) * (0&{"1 rawPoints) - minX 
scaledPointsY =. >. pwy + (pwRangeY % rangeY) * (1&{"1 rawPoints) - minY 

genPathPoints ,/ scaledPointsX ,. scaledPointsY 
}}

insShapeArray =: {{d

NB. insert small array (e.g. shape) > {. x into target array y with scenter of shape at > {: x 
NB.

insShape =. > {. x
insPoints =. > {: x

'shapeSizeX shapeSizeY' =. $ insShape

'deltaX deltaY' =. - <. 2 %~ shapeSizeX , shapeSizeY

NB. is this really needed ???? Inserting into target array in this function would duplicate target array unnecessarily ????

0 0 $ 0 
}}

addSimplePlot =: {{)v

NB. "add" a set of plot data to our plot
NB.
NB. y - (plotType , markerType , colorNum) ; raw plot data

NB. compute min and max for all data - this will make it more efficient to do multiple plots later on 

PLOTRAWDATA =: PLOTRAWDATA , (] , [: ((min; max)@:(|."1)@:(2&{."1) each) {:) y

$ PLOTRAWDATA 
}}

setSimplePlotTitle =: {{)v

NB. set plot title, x axis title, and y axis title
NB.
NB. y - title ; x axis title ; y axis title
NB.

PLOTTITLE =: y getArg 0 ; ''
PLOTXTITLE =: y getArg 1 ; ''
PLOTYTITLE =: y getArg 2 ; '' 

''
}}

genSimplePlot =: {{)v

'' genSimplePlot y 

:

NB. Display current plot defined by PLOTRAWDATA 
NB.
NB. x - colortable 
NB. y - minX, maxX, minY, maxY 
NB.

NB. figure out min, max for entire set of data 

mins =. > {."1 > 2&{"1 PLOTRAWDATA
maxs =. > {:"1 > 2&{"1 PLOTRAWDATA

NB. use min, max of data unless override specified

minX =. y getArg 0 ; (min 0&{"1 mins)
maxX =. y getArg 1 ; (max 0&{"1 maxs)

minY =. y getArg 2 ; (min 1&{"1 mins)
maxY =. y getArg 3 ; (max 1&{"1 maxs) 

NB. 'PLOTMINX PLOTMAXX PLOTTICX' =: computePlotRange (min 0&{"1 mins) , max 0&{"1 maxs 
NB. 'PLOTMINY PLOTMAXY PLOTTICY' =: computePlotRange (min , }."1 mins) , max }."1 maxs 

NB. plotMin ; plotMax ; numTics ; ticSize ; ticPos

'PLOTMINX PLOTMAXX PLOTTICNUMX PLOTTICX PLOTXTICPOINTSRAW PLOTXTICLABELINT xlabels' =. computePlotRange minX, maxX 

'PLOTMINY PLOTMAXY PLOTTICNUMY PLOTTICY PLOTYTICPOINTSRAW PLOTYTICLABELINT ylabels' =. (computePlotRange`computePlotRangeTime`computePlotRangeDate @. (PLOTTYPE&[)) minY, maxY 

PLOTRANGEX =: PLOTMAXX - PLOTMINX
PLOTRANGEY =: PLOTMAXY - PLOTMINY

PLOTIMGX =: PLOTIMGSX - 2&* PLOTBX	

PLOTSCALEX =: PLOTIMGX % PLOTRANGEX

NB. fun with axes - can we draw them sensibly ????
NB.
NB. Start w/ x-axis at y min and y-axis at x min
NB. axes should span the full plot window range 

PLOTXTICPOINTSSCALED =: (PLOTIMGSX - PLOTBX + <. 0.5&+ PLOTSCALEX * PLOTMINX -~ PLOTXTICPOINTSRAW) 

NB. xlabels =. genAxisLabel each <"0 PLOTXTICPOINTSRAW

labelMaxLen =. 10&* >./ > # each xlabels 

PLOTBYLEFT =: labelMaxLen + 100

xlabelYpos =. <. PLOTBYLEFT - 20 +  0.5 * labelMaxLen 

PLOTIMGY =: PLOTIMGSY - PLOTBYLEFT + PLOTBYRIGHT 
PLOTSCALEY =: PLOTIMGY % PLOTRANGEY

PLOTYTICPOINTSSCALED =: (PLOTBYLEFT + <. 0.5&+ PLOTSCALEY * PLOTMINY -~ PLOTYTICPOINTSRAW) 

PLOTARR =: PLOTAXISCOLOR (PLOTBYLEFT ,.~ PLOTBX + i. PLOTIMGX ) } PLOTARR
PLOTARR =: PLOTAXISCOLOR ( (PLOTIMGSX - PLOTBX) ,. PLOTBYLEFT + i. PLOTIMGY ) } PLOTARR 
PLOTARR =: PLOTAXISCOLOR ( PLOTXTICPOINTSSCALED ,."(0 _) PLOTBYLEFT + _5&+ i.11 ) } PLOTARR
PLOTARR =: PLOTAXISCOLOR ( PLOTYTICPOINTSSCALED ,.~"(0 _) PLOTIMGSX - PLOTBX + _5&+ i.11 ) } PLOTARR 

NB. gridlines

gridLinesHPos =. (PLOTXTICPOINTSSCALED -. (PLOTIMGSX - PLOTBX))
numGridLinesH =. $ gridLinesHPos 

gridLinesHorizontal =. ,/ (5 208) insHorizontalLine"(_ 1) (gridLinesHPos  ,. (numGridLinesH # PLOTBYLEFT ) ,. (numGridLinesH # PLOTBYLEFT + PLOTIMGY) )

PLOTARR =: ({:"1 gridLinesHorizontal) (}:"1 gridLinesHorizontal) } PLOTARR 

gridLinesVPos =. (PLOTYTICPOINTSSCALED -. PLOTBYLEFT)
numGridLinesV =. # gridLinesVPos 

gridLinesVertical =: (1&{"1 ,. 0&{"1 ,. 2&{"1) ,/ (5 208) insHorizontalLine"(_ 1) (gridLinesVPos ,. (numGridLinesV # PLOTBX) ,. (numGridLinesV # PLOTBX + PLOTIMGX))

PLOTARR =: ({:"1 gridLinesVertical) (}:"1 gridLinesVertical) } PLOTARR 

ylabelXpos =. PLOTIMGSX - PLOTBX - 30

(xlabelYpos ,.~ PLOTXTICPOINTSSCALED ) insertTextIntoPlot"1 ,. xlabels 

NB. (genAxisLabel@:{: insertTextIntoPlot~ ylabelXpos&[ , {.)"1 PLOTYTICPOINTSSCALED ,. PLOTYTICPOINTSRAW 

(ylabelXpos ,. PLOTYTICPOINTSSCALED) insertTextIntoPlot"1 ,. ylabels 

NB. put in titles

if. PLOTTITLE -.@:-: '' do.

  (<. 0.&+ (PLOTBX % 2) , PLOTIMGSY % 2) insertTextIntoPlot PLOTTITLE 

end.

if. PLOTYTITLE -.@:-: '' do.

  (<. 0.5&+ (PLOTIMGSX - 25) , PLOTIMGSY % 2) insertTextIntoPlot PLOTYTITLE

end. 

if. PLOTXTITLE -.@:-: '' do.

  (<. 0.5&+ (PLOTBX + PLOTIMGX % 2) , 25 , 1) insertTextIntoPlot PLOTXTITLE

end. 


for_currPlotData. PLOTRAWDATA do. 

  'plotType markerType colorNum' =. > {. currPlotData  

  rawPoints =. > 1&{ currPlotData 
  rawPointsX =. 1&{"1 rawPoints
  rawPointsY =. 0&{"1 rawPoints

  if. 2&< {: $ rawPoints do. 

    groupPoints =. 2&{"1 rawPoints

    groupCat =. ~. groupPoints

    groupPointsCat =. groupCat i. groupPoints 

    groupCatNum =. # groupCat 

  else.

    groupCatNum =. 1 

  end. 

  if. 3&< {: $ rawPoints do. 

    colorPoints =. 3&{"1 rawPoints

    colorCat =. ~. colorPoints

    colorPointsCat =. colorCat i. colorPoints 

    colorCatNum =. # colorCat 

  else.

    colorCatNum =. groupCatNum
    colorPointsCat =. groupPointsCat 

  end. 

  NB. clip to plotting region and scale points
  NB.
  NB. remember that we need to take X position from "bottom" of image 

  scaledPointsX =. PLOTIMGSX - <. 0.5&+ PLOTBX + PLOTSCALEX * PLOTMINX -~ PLOTMAXX <. PLOTMINX >. rawPointsX
  scaledPointsY =. <. 0.5&+ PLOTBYLEFT + PLOTSCALEY * PLOTMINY -~ PLOTMAXY <. PLOTMINY >. rawPointsY 

  scaledPoints =. scaledPointsX ,. scaledPointsY

  NB. see if we have grouped data

  if. plotType = 1 do. 

    NB. for_currPoint. scaledPoints do.

    NB.   PLOTARR =: (colorNum&* PLOT_SYM_1) ( < ( (deltaX + {. currPoint) + i. msX ) ; ( (deltaY + {: currPoint) + i. msY ) ) } PLOTARR 

    NB. end.

    if. groupCatNum = 1 do. 

      PLOTARR =: colorNum (|:"2 scaledPoints +"(1 2) PLOT_SYM_2) } PLOTARR

    else.

      for_iCurrLine. i. groupCatNum do.

        currLineSelector =. iCurrLine = groupPointsCat 

	symPoints =. {: $ PLOT_SYM_2   NB. PLOT_SYM_* - 2 x Num Points in symbol 

        PLOTARR =: (colorNum + symPoints # currLineSelector # colorPointsCat ) (,/ |:"2 ( currLineSelector # scaledPoints)  +"(1 2) PLOT_SYM_2) } PLOTARR 

      end.

    end. 

  elseif. plotType = 0 do.


    if. groupCatNum = 1 do. 

      PLOTARR =: colorNum (genPathPoints ,/ scaledPoints) } PLOTARR

    else. 

      for_iCurrLine. i. groupCatNum do.

        currLineSelector =. iCurrLine = groupPointsCat

        PLOTARR =: (colorNum + {. currLineSelector # colorPointsCat) (genPathPoints ,/ ( currLineSelector # scaledPoints) ) } PLOTARR 

      end. 

    end.     

  elseif. plotType = 2 do.

    barBottom =. PLOTIMGSX - PLOTBX 

    for_ibar. scaledPoints do.

      barLeft =. _2 + {: ibar 
      barTop =: {. ibar

      currBarPoints =. genPathPoints (barBottom , barLeft) , (barBottom, barLeft + 4) , (barTop , barLeft + 4) , (barTop , barLeft) , (barBottom, barLeft)

      PLOTARR =: colorNum currBarPoints } PLOTARR 

    end. 

  end.

end. 

dispSimplePlot x

''
}}

genAxisLabel =: {{)v

0 genAxisLabel y

: 

NB. given raw tic position - generate a suitable label for the tic 

currLabel =. ": y

if. 11&> # currLabel do.

  currLabel

else.

  currLabel =. '%10.1e' sprintf y

end.

}}

dispSimplePlot =: {{)v

NB. display the plot using color table 1 
NB.
NB. y - color scheme - defaults to ct_1

colorScheme =. y 

if. colorScheme -: '' do.
  colorScheme =. ct_3
end. 

colorScheme viewMatSim PLOTARR 
}}

clearPlotArr =: {{)v

NB. clear plot array - but leave the plot information and data

PLOTARR =: PLOTSZ $ 0

$ PLOTARR
}}

resetPlot =: {{)v

NB. reset the plot image
NB.
NB. y - size for new plot image
NB.

PLOTSZ =: 2&{. y

PLOTTYPE =: 0    NB. 0 - default, 1 - time of day, 2 - day, 3 - day of week 

PLOTMINX =: _
PLOTMINY =: _

PLOTMAXX =: _
PLOTMAXY =: _

PLOTRX =: _
PLOTRY =: _

PLOTTICX =: _
PLOTTICY =: _ 

PLOTBX =: 100 
PLOTBYLEFT =: 100
PLOTBYRIGHT =: 50 

PLOTIMGSX =: _
PLOTIMGSY =: _

PLOTSCALEX =: _
PLOTSCALEY =: _ 

PLOTARR =: PLOTSZ $ 0

PLOTGRIDCOLOR =: 208 

'PLOTIMGSX PLOTIMGSY' =: PLOTSZ 

PLOTRAWDATA =: (0 3) $ a: 

PLOTAXISCOLOR =: 255

PLOTTITLE =: ''
PLOTYTITLE =: ''
PLOTXTITLE =: ''

$ PLOTARR 
}}

computePlotRange =: {{)v

NB. given a data range - compute sensible plot range and axis tic positions
NB.
NB. y - min, max of data
NB.

'min max' =. y 

dataRange =. max - min

dataRangeLog =. <. 10 ^. dataRange

roundLevel =. 10 ^ (dataRangeLog - 1)

initialPlotRange =. max - min 

ticSize =. roundLevel * (1 2 5 10) {~  (10 20 50) I. initialPlotRange % roundLevel 

plotMin =. ticSize * <. min % ticSize
plotMax =. ticSize * >. max % ticSize 

numTics =. <. 0.5&+ (plotMax - plotMin) % ticSize 

ticPos =. (ticSize * >. min % ticSize) + ticSize * i. numTics

labelInt =. 1

labels =. genAxisLabel each <"0 ticPos

plotMin ; plotMax ; numTics ; ticSize ; ticPos ; labelInt ; < labels
}}

computePlotRangeTime =: {{)v

NB. compute sensible plot range, assuming that data is time in seconds

'min max' =. y 

timeRange =. max - min

ticSize =. ((0 4 6 10 14)&I. { (900 1200 1800 3600 7200 14400)&[) 3600&(%~) timeRange 

plotMin =. ticSize * <. min % ticSize
plotMax =. ticSize * >. max % ticSize

numTics =. <. 0.5&+ (plotMax - plotMin) % ticSize 

ticPos =. (ticSize * >. min % ticSize) + ticSize * i. numTics

labelInt =. 1 

labels =. ([: < [: '%02d:%02d'&sprintf (<.@:(3600&(%~)) , <.@:(60&(%~))@:(3600&|)))"0 ticPos 

plotMin ; plotMax ; numTics ; ticSize ; ticPos ; labelInt ; < labels 
}}

computePlotRangeDate =: {{)v

NB. compute sensible plot range assuming that data is date or date + time in date numbers (number days since 1/1/1800) - either integral or fractions 
NB.
NB. Generally want to try to start plot on Sundays or Mondays
NB.
NB. If range is more than 2 weeks - want to only label Sunday / Monday  of each week

'min max' =. y 

dateRange =. max - min

ticSize =. ( (0 7 14 28 56 100 200 500 800 1000 1800 2600 3400 4200)&I. { (1 2 3 4 7 14 28 56 112 168 224 280 336 392 448)&[ ) dateRange  

plotMin =. ticSize * <. min % ticSize
plotMax =. ticSize * >. max % ticSize

numTics =. >. 0.5&+ (plotMax - plotMin) % ticSize

debugme =: min; max; dateRange; ticSize ; plotMin; plotMax; numTics 

ticPos =. (ticSize * <. min % ticSize) + ticSize * i. numTics 

labelInt =. 1 

labels =: ( [: < [: '%d-%d-%2d'&sprintf  (}. , 100&|@:{.)@:n2d_base_ )"0 ticPos 

plotMin ; plotMax ; numTics ; ticSize ; ticPos ; labelInt ; < labels 
}}


insHorizontalLine =: {{)v

(0 208) insHorizontalLine y 

:

NB. Return points needed to insert a horizontal line into an array 
NB.
NB. x - line type (0 - solid line , n - length of each dash, default =0) color (default = 208)
NB. y - line number for line, start column, end column 

lineType =. x getArg 0 ; 0 
lineColor =. x getArg 1 ; 208  

lineRow =. y getArg 0 ; 0
lineColBeg =. y getArg 1 ; 0
lineColEnd =. y getArg 2 ; 0 

lenSegment =.  1&+ lineColEnd - lineColBeg

if. lineType = 0 do.

  lineContents =. lenSegment # lineColor

else. 

  lineContents =. lenSegment $ lineType # lineColor , 0 

end. 

lineRow ,. (lineColBeg + i. lenSegment) ,. lineContents 
}}

readFontCharFile =: {{)v

NB. read in bitmap file of character exported from font file using fontforge
NB.

rawChar =. 255&- #.@(16&}.)@#:"0 readbmp y
}}

loadCharSet =: {{)v

NB. read set of characters from directory specified by y
NB.

currDir =. 1!:43 ''

1!:44 y 

charSet =. <"2 ([: 192&+ [: <. 4&(%~))"0 ([: readFontCharFile '.bmp'&(,~)@:>)"0 ('slash';'backslash';'ampersand';'quotesingle';'colon';'tilde';'space';'underscore';'plus';'minus';'period';'parenleft';'parenright';'zero';'one';'two';'three';'four';'five';'six';'seven';'eight';'nine') , <"0 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

1!:44 currDir 

charSetIndex =. '/\&'':~ _+-.()0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

charSet ; charSetIndex 
}}
	
setStringToBMP =: {{)d

NB. given a string - with characters in our character index - return bitmap of string using specified character set
NB.
NB. x - character set - character bitmaps ; character set index
NB. y - string to turn into a bitmap 

charSetIndex =. > {: x 
charSet =. > {. x

|: ; |: each (charSetIndex&i. { charSet&[)"0 y 
}}

setPlotCharSet =: {{)v

NB. set character set for plot - needs to be in form created by loadCharSet 

PLOTCHARSET =: y

$ PLOTCHARSET 
}}

insertTextIntoPlot =: {{)d

NB. insert text y into PLOTARR - centered on position x
NB.
NB. x - center point for inserted text , rotate ? (def = 0) 
NB. y - text to insert (may be boxed) 
NB.

insertPoint =. 2&{. x

rotate =. x getArg 2 ; 0 

labelBMP =. (|.@:|:)^:rotate PLOTCHARSET setStringToBMP > y 

labelIndices =. ; (>@:{. <@:(,. :: ((0 2)$0)&[) >@:{:)"1 ( (<"0)@:i.@:# ,. ] ) I. each  (<"1) 0&< labelBMP

delta =. insertPoint (-`-@.(rotate&[)) <. 0.5 * $ labelBMP 

PLOTARR =: ((<"1 labelIndices) { labelBMP) (delta +"(_ 1) labelIndices) } PLOTARR

$ labelBMP 
}}




ct_grey =: (] ,. ] ,. ]) i.256
ct_1 =: ( (0 0 0) , (250 0 190) , (190 100 30) , (255 0 0) , (0 255 0) ,: (0 0 255) ) 
ct_2 =: ct_1 , (186 # (,: 0 0 0)) , (] ,. ] ,. ]) 4&* i.64 

ct_3 =: (0 0 0) , (128 0 0) , (0 128 0) , (0 135 215) , (95 0 135) , (0 95 95) , (175 95 0) , (175 0 95) , (255 135 0) , (255 255 0) , (222 184 135) , (240 128 128) , (255 250 205) , (119 136 153) , (178 # (,: 0 0 0)) , (] ,. ] ,. ]) 2&* i.64 

ct_4 =: (0 0 0) , (191 $ Peru,Aquamarine,Fuchsia,HotPink,GreenYellow,OrangeRed,Orange,Teal,Violet,LimeGreen,Olive,Magenta,LightSteelBlue,Firebrick,ArmyOlive,SteelBlue,Purple,:Crimson) , (] ,. ] ,. ]) 2&* i.64 


NB. PLOT_SYM_1 =: (0 0 0 1 0 0 0) , (0 0 1 1 1 0 0) , (0 1 1 1 1 1 0) , (1 1 1 1 1 1 1) , (0 1 1 1 1 1 0) , (0 0 1 1 1 0 0) ,: (0 0 0 1 0 0 0)

PLOT_SYM_1 =: |: (_3 0) , (_2 _1) , (_2 0) , (_2 1) , (_1 _2) , (_1 _1) , (_1 0) , (_1 1) , (_1 2) , (0 ,"0 (_3 + i.7)) , (1 ,"0 (_2 + i.5)) , (2 ,"0 (_1 + i.3)) , (3 0)  
PLOT_SYM_2 =: |: (1 0) , (1 0) , (0 0) , (0 1) ,: (_1 0)
PLOT_SYM_3 =: |: (1 1) , (1 0) , (1 _1) , (0 1) , (0 0) , (0 _1) , (_1 1) , (_1 0) ,: (_1 _1) 

NB. helper functions - should move to using more standard function

getArg =: 4 : 0

'argNum def' =: y

> (]`(def&[) @. (a:&=)) argNum&{ :: a:&[ ( ]`<@. ([: 2&= (3!:0)) ) x
)


MSP =: {{)v

'' MSP y 

:

NB. do a plot - all in one

resetPlot PLOTSZ

PLOTTYPE =: x getArg 0 ; 0 

colorTable =. x getArg 1 ; ct_4

plotType =. > x getArg 2 ; 0
markerType =. > x getArg 3 ; 1
colorNum =. > x getArg 4 ; 1 

addSimplePlot (plotType , markerType , colorNum) ;  y

colorTable genSimplePlot > 5&}. x
}}

MSIP =: {{)v

NB. initialize the plot - don't do anything else
NB.
NB. y - size of plot - default to current PLOTSZ 

PLOTSZ =: y getArg 0 ; PLOTSZ 

resetPlot PLOTSZ 

PLOTSZ
}}

MSCP =: {{)v

NB. clear plot array - makes it easy to regenerate an existing plot with different minx, miny, maxx, maxy
NB.
NB. y - ignored

PLOTARR =: PLOTSZ $ 0

PLOTSZ 
}}

MSAP =: {{)v

'' MSAP y 

:

NB. just add plot(s) - don't re-init or generate the plot
NB.
NB. 

plotType =. > x getArg 0 ; 0
markerType =. > x getArg 1 ; 1
colorNum =. > x getArg 2 ; 1 

addSimplePlot (plotType , markerType , colorNum) ;  y
}}

MSDP =: {{)v

'' MSDP y 

:

NB. wrapper to generate / display a plot 
NB.
NB. x - axis label type (0 for normal, 1 - .... , 2 - date - default 0 ) ; color table - default to ct_4 
NB. y - minx, miny, maxx, maxy 

PLOTTYPE =: x getArg 0 ; 0 

colorTable =. x getArg 1 ; ct_4

colorTable genSimplePlot y 
}}


MSST =: {{)v

NB. set plot title and redisplay the plot - assume it is a MSP-type plot
NB.
NB. y - 'Plot Title' ; 'X Axis Label' ; 'Y Axis Label'   -  see setSimplePlotTitle for details

setSimplePlotTitle y 

NB. ct_4 genSimplePlot ''

}}

MSSAVE =: {{)v

NB. save the current plot to the specified filename (must end in BMP, otherwise the bunnies will cry)
NB.
NB. y - full path to filename
NB.

y fwrite~ arrayToBMP PLOTARR {"(0 _) ct_4

}}

MSWPNG =: {{)v

NB. save the current plot as a png file (filename must end in PNG, otherwise bunnies will run away)
NB.
NB. y - filename - full path
NB.

(PLOTARR {"(0 _) ct_4) writepng y 
}}

MSPW =: {{)v

'' MSPW y 

:

NB. do a "weekday" plot
NB.
NB. x - PLOTTYPE (default 0, really y-axis type - 0 raw, 1 Time, 2 - date) ; colortable (default '' - which goes to ct_3 ??) ; min x ; max x ; min y ; max y  (remember that X and y are reversed !!)
NB. y - (plot type for data - 0 - line, 1 - symbol, 2 - bar) ; (date ,. time,. data to plot)

NB. resetPlot 400 1200

resetPlot PLOTSZ 

PLOTTYPE =: x getArg 0 ; 0

colorTable =. x getArg 1 ; ct_4 

plotType =. > x getArg 2 ; 0
markerType =. > x getArg 3 ; 1
colorNum =. > x getArg 4 ; 1 

addSimplePlot (plotType , markerType , colorNum) ; (wn_base_@:(0&{"1) ,.~ 2&{"1 ,.~ gwd_base_@:(0&{"1) + 1&{"1 % 86500&[)  y 

colorTable genSimplePlot > 5&}. x
}}


NB. some line and circle drawing functions - should be better than my home grown line drawing algorithm

bresLine =: {{)v

NB. generate points for line segment between two specified points
NB.
NB. y - (x0, y0, x1, y1)
NB.
NB. Return set of points for line between (x0,y0) to (x1,y1)
NB.

}}

st =: {{)v

'' st y

:

NB. given a boxed table - display it with some pretty (or not so pretty) colors
NB.
NB. x - Default colors - (header ; body1 ; body2)
NB. y - boxed table

NB. difficult part is that formatting characters take up space in string and can distort stuff
NB. Ideally want to set all formatting with minimum of distortion - need to be careful about putting formatting characters into string arrays

NB. figure out max column width for each column

colWidths =. 2&+ max > # each y

smoutput $ colWidths 

hbc =. x getArg 0 ; Black
htc =. x getArg 1 ; Yellow
t1bc =. x getArg 2 ; DarkBlue 
t1tc =. x getArg 3 ; White
t2bc =. x getArg 4 ; DarkViolet
t2tc =. x getArg 5 ; White

setStandardColors =. (stbc > {. DEFAULT_COLORS) , (sttc > {: DEFAULT_COLORS) 

NB. build header

smoutput rawHeaderLine =. {. y 

fmtHeaderLine =. (stbc hbc) , (sttc htc)

for_i. i. # colWidths do.

  smoutput i { colWidths 

  fmtHeaderLine =. fmtHeaderLine , (i { colWidths) {. '        ' ,~ ' '&, > i { rawHeaderLine 

end. 

fmtHeaderLine =. fmtHeaderLine , setStandardColors

fmtBodyLine =. (stbc t1bc) , (sttc t1tc) 


}}

applyColorFormat =: {{)v

DEFAULT_COLORS applyColorFormat y 

:

NB. Apply color to a string and then revert to default color 
NB. x - background_color ; text_color - defaults to Black + White 
NB. y - string to color
NB.
NB. Only really works when there is a single line in the string 

bc =. > x getArg 0 ; Black
fc =. > x getArg 1 ; White

(stbc bc) , (sttc fc) , y , (stbc > {. DEFAULT_COLORS) , (sttc > {: DEFAULT_COLORS) 
}}

init_text_colors =: {{)v


1
}}

DEFAULT_COLORS =: Black ; White 

insSymInArr =: {{)d

NB. insert specified symbol into image - centered at specified set of points - kind of like some kind of graph
NB.
NB. cutoff any part of a symbol that would go outside of array
NB.
NB. x - value to insert into array ; symbol as an nxm array ; set of points Npx2 array
NB. y - target array
NB.

insVal =. > x getArg 0 ; 1
insSym =. > x getArg 1 ; (0 1 0) , (1 1 1) ,: (0 1 0)
insPoints =. > x getArg 2 ; ,: 10 10  

imgSize =. $ y 

insSymOff =. - -: _1&+ $ insSym

insVal (,/ |:"2 (insPoints +"(1 _) insSymOff) +"(1 2) |: flattenSymbolArr insSym ) } y
}}

flattenSymbolArr =: {{ ; (>@:[ <@,. >@:])/"1  ( (<"0)@:i.@:# ,. ] ) <@I."1 y }} 

insNSymArr =: {{)v

( (1 1 1 1 1) , (1 0 0 0 1) , (1 0 0 0 1) , (1 0 0 0 1) ,: (1 1 1 1 1) ) insNSymArr y

:

NB. generate an image with specified number of symbols inserted at random points
NB.
NB. x - symbol (def 5x5 square)
NB. y - image size (default 400 x 1200) ; number of points (default 10)
NB.
NB. returns list of random points ; image with inserted symbols 
NB.

sym =. x 

symSize =. $ sym 

imgSize =. > y getArg 0 ; 400 1200
numPoints =. > y getArg 1 ; 10

smoutput sym 
smoutput symSize
smoutput imgSize 

ranPoints =. symSize +"(_ 1) ? (numPoints , 2) $ (imgSize - symSize)

ranPoints ; (1 ; sym ; ranPoints) insSymInArr imgSize $ 0 
}}


addEdgesToPoints =: {{)d

NB. add some randomly chosen edges to a set of points
NB.
NB. x - number of edges to add
NB. y - list of points
NB.
NB. return set of generated edges - (xi0, yi0, xi1, yi1) - in other words (start point , end point)
NB.

numEdges =. x
pointList =. y

edgeList =. 0 4 $ 0
edgePointers =. 0 2 $ 0 

numPoints =. # pointList 

currNumEdges =. 0 

for_iEdge. i.numEdges do.

  newEdgePointer =. /:~ ? 2 # numPoints 

  if. currNumEdges = edgePointers i. newEdgePointer do.

    edgePointers =. edgePointers , newEdgePointer   

    newEdge =. , newEdgePointer { pointList 

    edgeList =. edgeList , newEdge 

    currNumEdges =. currNumEdges + 1 

  end. 

end. 

edgeList 
}}


coclass 'base'

