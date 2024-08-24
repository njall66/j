
NB. need to have trig loaded so that we can set tpi = 2 * pi 

load 'trig' 

soctok =: 'ePhJTyZCrJIn4to52TVZSH0LO'

alphaTok =: '131HR5B76P4HEGAW'

NB. AlphaVantage Stock Time Series

alphaTS =: 3 : 0

1 alphaTS y

:

NB. x - interval (1, 5, 15, 30) 
NB. y - Symbol 

gethttp dquote 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=',y,'&interval=',(": x),'min&outputsize=full&apikey=',alphaTok,'&datatype=csv&adjusted=false'
)

alphaWK =: 3 : 0

NB. Y - symbol 

gethttp dquote 'https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=',y,'&apikey=',alphaTok,'&datatype=csv'
)

alphaDLY =: 3 : 0

NB. X - output size - 'compact' (default) or 'full' 
NB. Y - symbol

'compact' alphaDLY y

: 

output_size =. x 

gethttp dquote 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=',y,'&apikey=',alphaTok,'&datatype=csv&outputsize=',output_size
)

alphaGetCI =: 3 : 0

NB. get company information for specified stock symbol 
NB.
NB. X - type of information - 'o' - overview (def) , 'i' - income statement
NB. Y - stock symbol

'o' alphaGetCI y

:

funct =. ('OVERVIEW';'INCOME_STATEMENT';'BALANCE_SHEET';'CASH_FLOW';'EARNINGS';'EARNINGS_CALENDAR';'OVERVIEW') {~ ('o';'i';'b';'c';'e';'ec')&i. < x 

gethttp dquote 'https://www.alphavantage.co/query?function=',(> funct),'&symbol=',y,'&apikey=',alphaTok 
)

alphaGetStock =: 3 : 0

NB. get stock data from AlphaVantage for specified stock symbol
NB. X - frequency - ('d' - daily, 'w' - weekly, 'i' - intraday) - default - 'w' ; freq (for intraday) - (1, 5, 30, 60)
NB. Y - stock symbol
NB.
NB. return - array of stock prices queried from AlhpaVantage
NB.

'w' alphaGetStock y

:

NB. should add check on stock symbol 

freq =.  ('d';'w';'i')&i. ( < ` {. @.  L.) x

int =. > 1&{ :: 60&[ x 

csvData =. ( ('full'&alphaDLY)`alphaWK`(int&alphaTS)`alphaWK  @. freq) y
)

alphaCSV2arr =: 3 : 0

NB. convert csv from Alpha Vantage to array 
NB.
NB. Y - CSV from Alpha Vantage
NB.
NB. returns - convert CSV to array - drops title columns, converts date to internal and time to seconds

NB. split on (10 { a.), then convert to array 

}: }.  ( [: 0&". (' ' ;~ ',|-|:|',13&{a.)&rxrplc)  ;._1 (10 { a.) , y 
)

gs =: [: ^ -@[ * *:@]



simpleGauss =: 3 : 0

NB. gaussian curve A * exp( - alpha * (x - xc)^2)
NB.  
NB. x - A ,  alpha , xc 
NB. y - x values 

(1 , 0.01 , 0) simpleGauss y 

:

'A alpha xc' =: x 

alpha =: - | alpha 

A&* ^ alpha&* *: xc&- y 
)


distToGen =: 4 : 0 

NB. take distribution and convert to simple generating / mapping function to help with generating random numbers in the specified distribution 
NB. x - scaling factor N 
NB. y - distribution - array with two columns
NB.
NB. Returns mapping table from a uniform distribtion ==> specified distribution 


x (0&{"1@:]  #~ [: 1&round  [ * 1&{"1@:]) y 
) 


distToGen2 =: 4 : 0 

NB. take a distribution and create a simple generating function - consist of breakpoints + values (intended to be used by genToRanDist2 
NB.
NB. x - scaling factor 
NB. y - distribution - array with two columns 

(] #~ [: 1&, [: 2&(~:/\) 1&{"1) x (0&{"1@:] ,. [: round [ * (1&{"1)@:]) y
)

genToRanDist =: 4 : 0 

NB. Given generator built with distToGen - return N random numbers 
NB.
NB. x - # of random integers to return 
NB. y - generator function created with distToGen 
NB. 
NB. returns list of random numbers 


x (] {~ [: ? [: (#~)@:  #@:]) y  
)

genToRanDist2 =: 4 : 0

NB.
NB. x - # of random integers to return
NB. y - generator created with genToRanDist2



)

sfit =: 4 : 0

NB. simple linear interpolation
NB. x - xp values at which to compute interpolated values
NB. y - two column array - Fx ,. Fy - x+y values to interpolate
NB.
NB. Returns linear interpolated yp values for xp 

FX =. ({. , ]) 0&{"1 y
FY =. ({. , ]) 1&{"1 y 

NB. get nearest neighbor points (note that x values outside of range of Fx will not work well)

fxb =: x I.~ 0&{"1 y 
fxe =: fxb + 1 

FXE =. fxe { FX 
FXB =. fxb { FX 
FYE =. fxe { FY 
FYB =. fxb { FY

NB. 

FYB + (x - FXB) * (FYE - FYB) % (FXE - FXB) 
)


barnsley =: ( (0 0) ,: (0 0.16) ) , ( (0.85 0.04) ,: (_0.04 0.85) ) , ( (0.2 _0.26) ,: (0.23 0.22) ) ,: ( (_0.15 0.28) ,: (0.26 0.24) ) 

barnsley_prob =: ( 0.01 0.85 0.07 0.07 )

barnsley_add =: (0 0) , (0 1.6) , (0 1.6) ,: (0 0.44)
;
hough =: 4 : 0 

NB. simple Hough transform 
NB.
NB. x - (Nt - num of theta intervals) , (Nr - num of r intervals)
NB. y - list of points Npoints x 2 array 
NB.
NB. returns - Nt x Nr array with transform 

'Nt Nr' =. x 

NB. get set angular points 

theta =. steps 0, (2*pi), Nt 

ap =. (cos ,. sin) theta 



NB. build results array 

acc =. (Nr , Nt) $ 0 

)


NB. hilbert - takes a starting / initial value of (0j0) 

hilbert =: 0.5&*@( (_1j_1&+)@:(0j1&*)@:+ , _1j1&+ , 1j1&+ , [: 1j_1&- 0j1&*@:+ ) 

hilbertNC =: ( (_1j_1&+)@:(0j1&*)@:+ , _1j1&+ , 1j1&+ , [: 1j_1&- 0j1&*@:+ ) 

hilbertI =: 3 : 0

NB. Iterator for Hilbert Curve
NB.
NB. y - current curve as set of complex numbers
NB.
NB. initialize using starting value of (0j0) or just 0 

inArr =. ( (,:)`(]) @. (2&[ = #@:$) ) +. y

'xmin ymin xmax ymax' =. (min , max) inArr

dx =. xmax - xmin
dy =. ymax - ymin

debugme =: ( ( (0j_1)&* - (ymin j. - xmax)&[ ) ) y 

( ( [: + (0j_1)&* - (ymin j. xmin)&[ ) , ( (-xmin) j. dy + 1 - ymin )&+ , ( (dx + 1 - xmin) j. dy + 1 - ymin )&+ , ( [: |. (0j1)&* + ( (1 + 2 * dy) j. 0 )&[ ) ) y 
)

NB. simple hexdump pieces 

nhex =: 3 : 0  NB. res;val
	' ',~"1(((>0{y)$16) #: >1{y){ '0123456789ABCDEF'
 )

 hex =: 3 : ',.nhex 2;a.i.y'


 prt =: 3 : 0
	pa =. (32+i.96){a.
	mk =. '.'
	(pa i.y){pa,mk
 )

hexdump =: 3 : 0	NB. 'file';start;end;width
	fn =. >0{y
	st=. >1{y
	sz=. >:((1!:4 <fn)<.>2{y)-st
	w=. >3{y
	r=. >.sz%w
	adrs=. nhex 4;st+w*i.r
	text=. (r,w)$(1!:11 fn;st,sz),(-sz-r*w)${.a.
	adrs,. (hex text),. ':',.' ',. prt text
 )


hxx =:  ,/ '0123456789abcdef' ,."(0 1)  '0123456789abcdef'
fl =: (16 # ,: ' 00') 
mrh =: [: ,/"2 ([: 16&(,~) >.@(16&(%~))@#) $ [: fl&(,~) [: ' '&,. [: hxx&({~) a.&i.

NB. simple Box-Mueller transform to convert uniform random numbers into normally distributed random numbers

bm =: 3 : 0

NB. simple Box-Muller transform
NB.
NB. Return set of normally distributed random numbers
NB.
NB. x - granularity - default 1000 
NB. y - N/2 - number of numbers to generate
NB.

1000 bm y

:

N =. y

g =. x

pr =. 2 * pi % g 

NB. (%:@:^.@:(2*)@:(g&(%~))@:(0&{"1) *"1 [: (cos , sin) [: pr&* (1&{"1))  ? (N, 2) $ g  

NB. ( %:@:^.@:(2&*)@:(g&(%~))@:(0&{"1) *"(1 1) [: (cos , sin) [: pr&* (1&{"1))  ? (N, 2) $ g  

NB. ( %:@:(2&*)@:^.@:(g&%)@:(0&{"1) *"(0 1) [: (cos , sin) [: pr&* (1&{"1) )  ? (N, 2) $ g  

( %:@:(2&*)@:^.@:(g&%)@:(0&{"1) *"(0 1) [: (cos ,. sin) [: pr&* (1&{"1) )  1&+ ? (N, 2) $ g  

)

NB. evenly spaced points around circle 

initCirPts =: [: (] ,. cos ,. sin)@:steps 0: , tpi&[ , ]

NB. points around circle - N points in M revolutions of circle

initMultRev =: 3 : 0

NB. y - (N , M) - N points evenly spaced in M revolutions around circle

( [: (] ,. cos ,. sin)@:steps [: 0&, (tpi)&*@:(1&{ :: 1:) ,  {.) y  
)

conway =: ((] +.&(3&=) +) +/@((8 2$_1 _1 _1 0 _1 1 0 _1 0 1 1 _1 1 0 1 1)&|.))~


NB. pull out squares of side x from array y

pullSq =: [: (|:"2) [: ,/  [ ((]\)"2)  [ |:@]\ ]

NB. simple sequential machine to break text into words - for no good reason

ws_state_tran =: 2 2 2 $ 0 0 1 1 0 2 1 0
ws_input_map =: -. (+/ (' .,!:;"-_?()[]{}' , (9 10 13)&{a. ) ="(0 _) a.)
ws_sq =: (0 ; ws_state_tran ; ws_input_map ) & ;:

NB. filter out characters 

NB. (/:@:(2&{"1) { ])@:(~. ([ ,. (<"0)@:sh@:i.) ])    - simple code to get histogram of boxed data

NB. removing control characters from text data:   raw_text -. (128 + i.128){a.

NB. code to 

  
NB. simple (or stupid????) cellular automata

mapv =: (0 1 1 0 0 0 0 0 0)&[

mrstep =: 3 : 0 

NB. iterate a cellular automata
NB.
NB. X - (number of iterations) , ( for window of size nxn -  (n * n) + 1 mappings for sums from 0..n ) 
NB. Y - starting state
NB.
NB. applies rules specified by X (num of iterations) times 

(0 0 0 0 1 1 1 0 0 0) mrstep y

:


num_iter =. {. x 
mv =: }. x 
ls =: %: _1&+ # }. x 
md =: $ y 

NB. create boundary - assumes that side of "square" is odd

stripWidth =. 2 %~ ls - 1
vsLen =. 0 { md
hsLen =. 1 { md
vsStrip =: (vsLen, stripWidth) $ 0
hsStrip =: (stripWidth , (hsLen + 2&* stripWidth)) $ 0 

([: md&$  [: mv&({~)"(_ 0) [: (+/)@:,"2 [: ls&pullSq [: hsStrip&(,~) [: hsStrip&, [: vsStrip&,. vsStrip&(,.~) )^:num_iter y
)


NB. try to do efficient file processor - just as an exercise

procfile =: 3 : 0

NB. simple file processor
NB.
NB. y - filename to process

lb =. (10 13) { a.

fn =. (1!:21) y

cp =. 0
cs =. 1024*1024

fileSi
ze =. (1!:4) y

priorPiece =. ''

numChunks =. >. fileSize % cs 

for_cn. (1 + i. (numChunks-1)) do.

rawChunk =. priorPiece , (1!:11) fn; (cn * cs) , cs



end. 

(1!:22) fn 

)

NB. wrap stdout read and write functions - doesn't work well in jhs :)

stdinR =: [: (1!:1) 3&[

stdinW =: 3 : 0

xx =. y (1!:2) 4 

''
)


NB. test out simple UI function

sui =: 3 : 0

display_jprintf_ y

(1!:1) 1 
)

NB. Try to read in input 

fr =: 3 : 0 

(y&[) ` ((y&,)@:<) @. ((0&<)@:#) (1!:1) 1 
)

frall =: fr^:_ 

NB. simple cosine of angle between two vectors 

hdcos =: 4 : 0 

x ( ([: +/ *) % ([: %: +/@:[ * +/@:]) ) y
)

simpleRepl =: 3 : 0

NB. simple repl - enter lines till we get a ".go", then run lines and return results in array lineRes

arrLines =. 0 $ a: 

whilst. ({: arrLines) ~: ,: < '.go' do.

  arrLines =. arrLines , fr '' 

end. 

arrRes =. 0 $ a: 

for_currLine. }: arrLines do.

  arrRes =. arrRes , < ". > currLine 

end.

(}: arrLines) ,. arrRes 
)

simpleCircle =: 3 : 0

NB. return set of points on circle centered at xc,rc with radius r 

NB. y = num_points (def 1000), xc (def 0) , yc (def 0), r (def 10)

xc =. 1&{ :: 0: y
yc =. 2&{ :: 0: y
r =. 3&{ :: 10&[ y
np =. 0&{ :: 1000&[ y

(xc, yc)&+"1 r&* (cos ,. sin) steps 0 , (2*pi) , np
)


ps01 =: (0&{"1 ; 1&{"1)

psnm =: 3 : 0
  (0 1) psnm y 
:
sel =. 2&{. x 

if. (# x) > 2 do. 

mul =. 2&}. x 

else. 

mul =. 1 1 

end. 

<"1@:|: mul&*"(_ 1) (sel&{"(_ 1)) y	
)

sc =: 3 : 0

NB. simple Appollonius Gasket builder - or at least my attempt at doing so

NB. radius of outer circle (def = 10) , number of points in each circle (def = 1000)

r =. 0&{ :: 10&[ y
np =. 1&{ :: 1000&[ y

NB. generate points for the outside circle

pd =. simpleCircle np, 0, 0, r

NB. generate second circle with inside the first and tangent - radius r1 < r, centered at (r-r1,0)

r1 =. r&* 0.01&* 11&+ ? 80

pd =. pd ,. simpleCircle np, (r - r1), 0 , r1

NB. try to construct third circle tangent to circles so far

NB. first choose a radius for the third circle -  max r2 = r0 - r1

r2 =. (r - r1) * 0.01&* 11&+ ? 80 

cosphi =. (((r - r2)^2) + ((r - r1)^2) - (r1 + r2)^2) % 2&* (r - r1) * (r-r2) 

sinphi =. %: 1 - *: cosphi

NB. now compute center of third circle - distance from center of initial circle

x2 =. (r - r2) * cosphi
y2 =. (r - r2) * sinphi

pd =. pd ,. simpleCircle np, x2, y2, r2

(r1 , r2, cosphi , sinphi, x2, y2) ; pd
)


crazyCircle =: 3 : 0

NB. play around with simple ray tracing

cx0 =. 0
cy0 =. 50

ac =. 10
ac_half =. ac % 2 

rc =. 2

nc_row =. 5
nrow =. 4

NB. Y - ignored for now 



NB. generate row of circle centers

circle_row =. cy0 ,.~ cx0 + ac&* steps (-nc_row) , nc_row , 2*nc_row

circle_array =. (] , (0 , 2&* ac)&+"(_ _1))@:(] , (0 , ac)&+"(_ _1))@:(] , (ac_half , ac_half)&+"(_ _1)) circle_row

circle_array =. circle_array ,. rc

circle_array 
)

intersectCircles =: 4 : 0

NB. take a set of circles and a line
NB.
NB. X - (x1 y1 x2 y2) - points defining the line
NB. Y - array - centers of of circles - (xc yc rc) 

'x1 y1 x2 y2' =. x

NB. calculate some quantities that will make it easier to identify circles that will intersect the line defined by (x1 y1 x2 y2) 

dx =: (x2 - x1)
dy =: (y2 - y1)
d =: %: (dx^2) + (dy^2)
D0 =: (x1 * y2) - (x2 * y1)
rc =: ,/ ~. 2&{"1 y 

NB. identify set of circles that the line intersects

ci =. (] #~ |@:(_2&{"1) < _1&{"1) ((d * rc) ,.~ ] ,. ( [: D0&+ [: (-~)/"1 [: (dy , dx)&*"(_ _1) 2&{."1) ) y

NB. circles_intersect =. ((d * rc) ,.~ ] ,. ([: | [: D0&+ [: -/"1 [: (dy , dx)&*"(_ _1) 2&{."1) ) y

NB. calculate the distance from the first line point to the center of each circle

NB. ci =. (] ,. ([: *: [: x1&- 0&{"1) + ([: *: [: y1&- 1&{"1)) ci   - don't bother - we will calculate distance from point to intersection points instead 

rd2 =: *: rc * d 
dys =: (_1: ` 1: @. (0&<:)) dy 
d2 =: *: d 

xint1 =. d2 %~ ( ([: dy&* 3&{"1) ,. [: dys&* [: dx&* [: %: [: rd2&- [: *: 3&{"1) ci
yint1 =. d2 %~ (([: - [: dx&* 3&{"1) ,. [: | [: dy&* [: %: [: rd2&- [: *: 3&{"1) ci

NB. returns (xi, yi, ri, D , r*d , xi_0 , xi_+- , yi_0 , yi_+-  - where the xi* and yi* are pieces of intersection points:
NB.
NB. intersection points = (xi_0 +/- xi_+- , yi_0 +/i yi_+-) 

ci ,. xint1 ,. yint1 
)


simpleReflect =: 4 : 0

NB. take set of circles and points that define a line
NB. find intersection points
NB. choose first intersection point and compute points on reflected ray
NB.
NB. X - (x1 y1 x2 y2) two points defining incoming ray
NB. Y - array - centers of circles

'x1 y1 x2 y2' =. x 

interPointsBase =. x intersectCircles y

NB. calculate actual set of points, calculate distance from (x1, y1) to each point, and sort points by distance from (x1,y1) 

interPoints =. (] {~ [: /: 0&{"1) (] ,.~ [: (x1 , y1)&(+/@:*:@:-)"(_ 1) 2&{."1 ) ( (] , ]) ,.~ (] , ])@:(2&{."1) + (_2&(-/\)"1 , _2&(+/\)"1)@:(5&}."1) ) interPointsBase


'xint yint cx cy r' =. (1 2 3 4 5)&{ 0&{ interPoints 

ox2 =. xint + (r * r) %~ ( ( (x1 - xint) * (xint - cx)^2 ) + ( 2&* (xint - cx) * (yint-cy) * (y1-yint) ) - ( (x1 - xint) * (yint - cy)^2 ) )

oy2 =. yint + (r * r) %~ ( ( (y1 - yint) * (yint - cy)^2 ) + ( 2&* (xint - cx) * (yint-cy) * (x1-xint) ) - ( (y1 - yint) * (xint - cx)^2 ) )

interPoints ; ox2 , oy2
)


genRanPoly =: 3 : 0

NB. generate random polygon
NB.
NB. Y - number of edges (def 4) , max x/y (def 100) 

numEdges =. 0&{ :: 4: y
maxXY =. 1&{ :: 100&[ y 

(] , {.) (] {~ [: /: _1&{"1)  (] ,. ([: pi&* [: 0&> 2&{"1) + [: _3&o. [: %/"1 (3 2)&{"1) (] ,. 2&{."1 -"(1 _) [: mean 2&{."1) ? (numEdges , 2)  $ maxXY
)


NB.  play around with l-systems

NB. define the substituion
NB.
NB. ci ==> si
NB.
NB. c1 ; s1
NB. c2 ; s2
NB. ...
NB. cN l SN
NB.

defLSub =: 4 : 0

x ,. y
)

appLSub =: 4 : 0

NB. apply an L-system substitution
NB.
NB. X - defines substitution - created with defLSub
NB. Y - string to be "substituted" 
NB.

NB. this isn't really efficient to re-compute our hash table lookup each time

LUT =: (> 0&{"1 x)&i.
LUV =: (<'') ,~ 1&{"1 x

; LUV {~ LUT y
)

NB. explore random stitch patterns

ranStitch =: 3 : 0

NB. generate a two dimensional random stitch pattern
NB.
NB. X - box width (default = 4)
NB. Y - number of boxes per side (pattern size will be (X*Y) by ((X*Y))

4 ranStitch y 

:
mr00 =. 1&, }: (x * y) $ (3 5) # (0 1) 
mr01 =. 4 |. mr00 
sp00 =. 0 $~ y ,~ _1&+ x

sel=: (mr00 , sp00) ,: (mr01 , sp00)

((,/)@:((? y $ 2)&{)  +. |:@:(,/)@:((? y $ 2)&{)) (mr00 , sp00) ,: (mr01 , sp00)
)




NB. simple stylesheet for colorizing things like hexdumps


styleBlockHex =: 0 : 0
.iw {color:Green;}
.sub {color:Violet;}
.pad {color:DarkGray;}
.val {color:Purple;}
.box > div {
     border-radius: 10px;
     padding: 10px;
     border: 2px solid green;
     background-color: black;
     width: 90%;
     max-width: 300px;
     }    
.box {
     display: grid;
     grid-template-columns: 300px 300px 300px;
     }
)

toStyle =: {{ '<STYLE>',y,'</STYLE>' }}

testHTML =: 0 : 0
<div class="box">
  <div>infoword</div>
  <div>subscripts of fun</div>
  <div>pads</div>
  <div>values for the things</div>
</div>
)


NB. some functions to play around with the chaos game
NB.
NB.
chaosGame =: 4 : 0

NB. X - number of points to generate (def 100) , number vertices (def 4) , fractional distance to vertex for each move
NB. Y - (starting point - x,y)

np =. 0&{ :: 100&[ x
nv =. 1&{ :: 4: x
dv =. 2&{ :: 0.5&[ x

dvcp =. 1 - dv 

sp =. y

vertices =. }. 2&{."1 simpleCircle nv,  50 50 50

NB. vertices ( ] ([ , {:@:] ,~ [: dv&* }:@:{:@:[ + }:@:]) [ ({~ , ]) ?@:<:@:#@:[ { i.@:#@:[ -. {:@:{:@:] )^:np  (,: sp)

vertices ( ] ([ , {:@:] ,~ dvcp&*@:}:@:{:@:[ + dv&*@:}:@:]) [ ({~ , ]) ?@:#@:[ )^:np  (,: sp) 
)

oneDmeanShift =: 1 : 0 

NB.
NB. oneDmeanShift
NB.
NB. simple one dimensional mean shift algorithm implemnentation as an adverb
NB.
NB.       kernelFunction oneDmeanShift Y 
NB.
NB. X = original / starting set of points {sp} 
NB. Y = current set of points {cp}
NB.
NB. kernelFunction - kernel function - mondadic - take (x - y) 
NB.
NB. Both {sp} and {cp} are one dimensional arrays with same length
NB.
NB. returns {cp'} = where cpi = sum over j ( K( |cpi - pj| ) * pj) / sum over j ( K( |cpi - pj) )
NB.
NB. where K() is the "kernel function" - current hard coded to be a simple Gaussian
NB.
NB. Essentially cpi goes to a weighted average of {sp}, where weights are given by K( |cpi - spj| )
NB.

NB. compute all of the kernel functions at the same time - inefficient because it makes us build an NxN matrix 

x ([ ( +/@:* % +/@:] )  [: (u"0) [: | -"(1 0)) y 
)

LSystemApply =: 4 : 0 

NB. Apply a simple L System and generate a set of points 
NB.
NB. L System specified as the following:
NB.
NB. - Boxed Nx4 array - each row defines behavior of one symbol 
NB.
NB.   (Symbol - normally as 1 Byte String) ; (Step Size - index) ; (Direction Change - delta index) ; (Replacement Value)
NB.
NB. - Boxed array with Ndx2 elements - defines possible directions
NB. - Boxed one D array with Nm elements - defines possible step lengths 
NB. 
NB. Given definition of L System, L System string
NB.
NB. - return path spefieid by L System
NB.
NB. X - L System Def ; Directions ; Step Lengths
NB. Y - L System String 
NB.

'lSysDef possDir possStep' =. x 

numDir =. # possDir
numStep =. # possStep

lString =. y 

NB. start at (0,0) with current direction 0 

cp =. 0 0
cd =. 0 

symbolDict =. (> 0&{"1 lSysDef)&i.

stepList =: > 1&{"1 lSysDef
deltaDirList =: > 2&{"1 lSysDef 

pointList =. ,: 0 0

for_xsym. lString do.

  currSymb =: symbolDict xsym

  delta =. (possStep {~ currSymb { stepList) * (cd { possDir)

  if. -. delta -: (0 0) do. 

    cp =. cp + (possStep {~ currSymb { stepList) * (cd { possDir)

    pointList =. pointList , cp

  end. 

  cd =. numDir | cd + currSymb { deltaDirList

end.  

pointList
)

LSystemIter =: 4 : 0

NB. iterate an L System
NB.
NB. X - definition of L System to iterate
NB. Y - current L System string
NB.
NB. applies L System definition to current L system string
NB.
NB. Returns updated L system string
NB. 

'lSysDef dirs nsteps' =. x 

res =. 0 $ ''

symbolDict =. (> 0&{"1 lSysDef)&i.
symbolList =. > 0&{"1 lSysDef 
newSymbol =. _1&{"1 lSysDef

for_xsym. y do.

  newSym =. > (symbolDict xsym) { newSymbol  

  res =. res , newSym 

end. 

res
)

testLSystem =: 3 : 0

dirs =. (1 0) , (0 1) , (_1 0) ,: (0 _1)
delta =. 1

( ('a' ; 0 ; 1 ; 'ab') ,: ('b' ; 0 ; _1 ; 'ba') ) ; dirs ; delta
)

hilbertLS =: 3 : 0

dirs =. (1 0) , (0 1) , (_1 0) ,: (0 _1)
delta =. 0 1

( ( 'A' ; 0 ; 0 ; '+BF-AFA-FB+') , ('B' ; 0 ; 0 ; '-AF+BFB+FA-') , ('F' ; 1 ; 0 ; 'F') , ('+' ; 0 ; 1 ; '+') ,: ('-' ; 0 ; _1 ; '-')) ; dirs ; delta
)

gosperLS =: 3 : 0

pi3 =. pi % 3

dirs =. (1 0) , ( (cos pi3) , (sin pi3) ) , ( (cos 2&* pi3) , (sin 2&* pi3) )  , ( _1 , 0 ) , ( (cos 4&* pi3) , (sin 4&* pi3) ) ,: ( (cos 5&* pi3) , (sin 5&* pi3) )
delta =. 0 1

( ('A' ; 1 ; 0 ; 'A-B--B+A++AA+B-') , ('B' ; 1 ; 0 ; '+A-BB--B-A++A+B') ,('+' ; 0 ; 1 ; '+') ,: ('-' ; 0 ; _1 ; '-') ) ; dirs ; delta
)

thueMorseLS =: 3 : 0

NB. Generate Thue - Morse sequence using L System
NB.

dirs =. (cos ,. sin) (pi % 3) * i.6 

delta =. 1 

( ('0' ; 0 ; 0 ; '01') ,: ('1' ; 0 ; 1 ; '10') ) ; dirs ; delta
)

kochLS =: 3 : 0

dirs =. (1 0) , (0 1) , (_1 0) ,: (0 _1)
delta =. (0 1)

( ('F' ; 1 ; 0 ; 'F+F-F-F+F') , ('+' ; 0 ; 1 ; '+') ,: ('-' ; 0 ; _1 ; '-') ) ; dirs ; delta 
)

sierpLS =: 3 : 0

dirs =. (cos ,. sin) (2&* pi % 3) * i.3
delta =. 0 1

( ('F' ; 1 ; 0 ; 'F-G+F+G-F') , ('G' ; 1 ; 0 ; 'GG') , ('+' ; 0 ; 1 ; '+') ,: ('-' ; 0 ; _1 ; '-') ) ; dirs ; delta 
)

dragonLS =: 3 : 0

dirs =. (1 0) , (0 1) , (_1 0) ,: (0 _1)
delta =. 0 1 

( ('F' ; 1 ; 0 ; 'F+G') , ('G' ; 1 ; 0 ; 'F-G') , ('+' ; 0 ; 1 ; '+') ,: ('-' ; 0 ; _1 ; '-') ) ; dirs ; delta 
)

NB.
NB. Mess around with continued fractions
NB.

contFract =: 3 : 0

NB. given numerator and denominator for a rational number - return the continued fraction expansion
NB.
NB. Y - (a , b) - where rational number is a % b -
NB.
NB. return list of qi where (a % b) = (q0 + 1 % (q1 + 1 % (q2 + 1 % (q3 + .....
NB.

(0,y) (contFractIterOut F: contFractIter) (0 , y) 
)

contFractIterOut =: 3 : 0

NB. output filter for continued fraction computation
NB.
NB. just return first element of y
NB.

_2 Z: 0&= 1&{ y 

{. y 
)

contFractIter =: 4 : 0

NB. continued fraction iteration
NB.
NB. X - ignored
NB. Y - qn-1 , rn-2 , rn-1
NB.
NB. return qn, rn-1, rn
NB.
NB. Divide rn-2 by rn-1, qn=. <. (rn-2 % rn-1) and rn=. rn-1 | rn-2
NB. 

NB.prevent runaway iteration

_3 Z: 100 

'q ro r' =. y

(ro <.@:% r) , r , (r | ro) 
)


NB.
NB. simple out formatting - currently for output
NB.


boxText =: 3 : 0

NB. take a blob of text and spit out the same text enclosed in a box
NB.
NB. Need to handle text as a single string (e.g. N array)
NB. NxM array of characters - really N - M arrays of characters
NB.
NB. for one dimensional arrays, likely need to break into lines at (10{a.)
NB.


NB. assume that we now have an NxM array

'n m' =. $ y

vert =. n # u: 16b2502
horiz =. m # u: 16b2500

((u: 16b250c) , horiz , (u: 16b2510)) , (vert ,. y ,. vert) , ((u: 16b2514) , horiz , (u: 16b2518)) 
)

