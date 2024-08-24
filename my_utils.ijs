NB. simple utility functions

NB. variable width hexdump


NB. convert list to string and insert specified character between each list item 

iv =: 4 : '( dropSpaces@[ , [: x&, ])/ ":"0 y'
 
ivws =: 4 : '( [ , [: x&, ])/ ":"0 y'

NB. simple function to drop all spaces - ' ' - from y 
dropSpaces =: ' '&(-.~)

NB. simple function that returns y -. x 
dropX =: -.~ 

NB. simple decimal to hex string 

d2hv =: {{ ([: ,/ [: '0123456789abcdef'&({~) (x#16)&#:) y }}  

d2h =: 3 : 0 

16 d2hv"0 y 

:

x d2hv"0 y 

)

dt2fl =: 3 : 0 

NB. pull dayno and time (sec) from array columns and convert to dayno + (time / 86400) for plotting

(0 1) dt2fl y

:

+/"1  ( (1 86400)&(%~)"(_ 1) x&{"1 y )
)


NB. define some simple convenience function

d2n =: todayno
n2d =: todate 

NB. get the name of the month 

monthName =: ('--';'January';'February';'March';'April';'May';'June';'July';'August';'September';'October';'November';'December')&({~)

n2month =: [: monthName [: 1&{"1 n2d 

NB. gwd - get weekday from day number 

gwd =: 7 | 3 + <.


NB. return name of weekday 

gwds =: [: > [: ('Sun';'Mon';'Tues';'Wed';'Thurs';'Fri';'Sat')&({~) gwd 


NB. return 1 if day is business week, 0 if weekend 

iswd =: (0&< *. 6&>)@gwd 

wdarr =: 4 : 0

      NB. filter array to data for weekdays
      NB. x - column with day number
      NB. y - array

      (] #~ [: iswd x&{"1) y 
)


fwd =: 3 : 0 

NB. filter to specified weekday 

NB. x - weekday , day number col (def =: 0)
NB. y - array to filter 

(0 0) fwd y 

:

weekDay =. 0 { x
dayCol =. 1&{ :: 0: x 

(weekDay&=@:gwd@:(dayCol&{"1) # ]) y 
)


fwdr =: 3 : 0 

NB. filter to specified range of weekdays 

NB. x - start, end, day number col (def =: 1,3,0) 
NB. y - array to filter 

(1 3 0) fwdr y 

:

wdBeg =. 0 { x
wdEnd =. 1 { x 
dayCol =. 2&{ :: 0: x 

( (wdBeg&<: *. wdEnd&>:)@:gwd@:(dayCol&{"1) # ] ) y 
)



id =: <.@%~

NB. calculate the week number from day number 

wn =: [: 7&id 3&+ 

NB. calculate day number from week number - get day number of Sunday 

wn2dt =: _3&+@:(7&*) 

NB. calculate the month number - year * 12 + month - from a day number

mn =: [: (12&*@(0&{) + _1&+@(1&{)) [: }: n2d

NB. convert month number to date - just set to first day of the specified month 

mn2dt =: (1 ,~ 12&id , 1&+@(12&|))

NB. stupid string functions

isLeadChar =: #@:[ > [ i. {.@:] 
isLeadDigit =: '0123456789'&isLeadChar 

trimE =: (] ` ([: $: }:) @. (' '&=@:({:!.'-')) ) 
trimB =: (] ` ([: $: }.) @. (' '&=@:({.!.'-')) ) 


NB. unique values from column(s) in array y specified by x 

uq =: [: ~. {"1  

fcr =: 4 : 0

NB. filter array based on column range value 
NB. x - (minRange, maxRange, col # - def=0, not range - def=0), header? (def - 0) 

    col =. (0: ` (2&{) @. ((2&<)@#) ) x
    minv =. 0{x
    maxv =. 1{x
    notRange =. 3&{ :: 0: x
    header =: 4&{ :: 0: x
    
    (header&{. , header&}. #~ [: (-.^:notRange) ((minv&<:) *. (maxv&>:))@:(>@:(header&}.)@:(col&{"1)) ) y 
)


fcre =: 4 : 0 

NB. filter array based on regular expression match to specified column 
NB. x = (col ; 'regular expression to match on') 
NB. y - array to filter 

if. 0 < L. x  do.
  if. 1 < # x do.  
    col =. > {. x
    re =. > 1&{  x 
    fl =. > 2&{ :: 0: x  
  else.
    re =. > x 
    col =. 0 
    fl =. 0 
  end. 
else.
  col=.0
  re =. x
  fl =. 0  
end. 

(fl&{. , ] #~ [: _1&<@:{.@:{.@:(re&rxmatch)"1 [: > col&{"1) y
)

fcresv =: 4 : 0 

NB. return selection vector to filter array based on regular expression match to specified column 
NB. x - (col; 'regular expression';negate? (def - 0))
NB. y - array to filter

if. 1 = L. x do. 
  if. 1 = # x do.
    col =. 0
    re =. > x 
    neg =. 0 
  else. 
    col =. > 0&{ :: 0: x 
    re =. > 1&{ x 
    neg =. 2&{ :: 0: x 
  end.
else.
  col=.0
  re =. > x 
  neg =. 0 
end. 

([: (]`-.@. neg&[) [: (_1&<)@:{.@:{.@:(re&rxmatch)"1 [: > col&{"1) y
)

fcrei =: 4 : 0 

NB. filter columns based on regular expression and return indices of matching elements 
NB. x - (col ; 'regular expression' ; negate?) or just ('regular expression') with column defaulting to 0 
NB. y - array to match on 

(x&fcresv # i.@:#) y 
)

fcnrei =: 4 : 0 

NB. filter columns based on regular expression and return indices of matching elements 
NB. x - (col ; 'regular expression') or just ('regular expression') with column defaulting to 0 
NB. y - array to match on 

if. 1 = L. x do.

col =. > 0&{ :: 0: x 
re =. > 1&{ x 

par =. col ; re ; 1

else.

par =. 0 ; x ; 1 

end.

(par&fcresv # i.@:#) y 
)

flt =: 4 : 0 
NB. filter array to where column C is <= than V
NB. x - (V , C - default 0)
NB. y - array to filter 

V =. {. x 
C =. > 1&{ :: 0: x 

(] #~ [: V&>: >@:( (] ` (C&{"1)) @. ([: 1&< #@:$) )) y 
)

fgt =: 4 : 0 
NB. filter array to where column C is >= than V
NB. x - (V , C - default 0)
NB. y - array to filter 

V =. {. x 
C =. 1&{ :: 0: x 


NB. if. 0 = L. y do.
NB.	(] #~ [: V&<: C&{"1) y 
NB. else. 
NB. 	(] #~ [: V&<: >@:C&{"1) y
NB. end.

(] #~ [: V&<: [: (] ` > @. L.) (] ` (C&{"1)) @. ([: 1&< #@:$) ) y


)

fgti =: 4 : 0 
NB. return indices where colum c is greater than some specified value v
NB. x - (V , C - default 0)
NB. y - array to filter 

V =. {. x 
C =. 1&{ :: 0: x 


NB. if. 0 = L. y do.
NB.	(] #~ [: V&<: C&{"1) y 
NB. else. 
NB. 	(] #~ [: V&<: >@:C&{"1) y
NB. end.

( [: I. [: V&<: [: (] ` > @. L.) (] ` (C&{"1)) @. ([: 1&< #@:$) ) y
)

fgta =: 4 : 0 
NB. return selections from y +/ n rows where column c is greater than specified value v
NB. x - v , c (def 0) , n (def 5) 

v =. {. x
c =. 1&{ :: 0: x 
n =. 2&{ :: 5: x 

sr =. i. 1 + 2&* n 

(] {~  [: ( sr - n )&+"(_ 0) ((v , c)&fgti)) y
)

fnv =: 3 : 0

(0,0) fnv y 

:
NB. filter to rows where column not equal to specified value  

col =. (0: ` (1&{) @. ((1&<)@#) ) x
val =. 0{ x
    
(] #~ [: -. [: val&= col&{"1) y

)


NB. convert month number to date - just set to first day of the specified month 

mn2dt =: (1 ,~ 12&id , 1&+@(12&|))

wdpx =: 3 : 0

    (0 1) wdpx y 
    
:

    colDayNo =. 0 { x
    colTime =. 1 { x 

    (wn@(colDayNo&{"1) ,:@< /. 86400&(%~)@(colTime&{"1) + gwd@(colDayNo&{"1)) y
)

wdpy =: 3 : 0

     (0 3) wdpy y

:

     'colDayNo colData' =. x 

     (wn@(colDayNo&{"1) ,:@< /. colData&{"1) y
)

plotwd =: 3 : 0

     (0 1 3) plotwd y

:
     if. 4 = # x do.  

       'colDayNo colTime colData plotType' =. x

     else. 

       'colDayNo colTime colData' =. x
       plotType =. 1

     end.	

     plotdata =. ( (colDayNo, colTime)&wdpx ,. (colDayNo,colData)&wdpy ) y

     if. plotType=1 do. 
      plot 0 { plotdata
      plotdata =. 1 }. plotdata 
     end.
 
     pd"1 plotdata 
 	

     pd 'show'
)

plotwd_sa =: 3 : 0 

NB. set axes for a "weekday plot" 

if. 1&= y do. 

ticpos =. '1 1.5 2 2.5 3 3.5 4 4.5 5 5.5'
ticlabs =. 'Mon "" Tue "" Wed "" Thu "" Fri ""'

else. 

ticpos =. '0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6'
ticlabs =. 'Sun "" Mon "" Tue "" Wed "" Thu "" Fri "" Sat'

end. 

pd 'xticpos ' , ticpos  
pd 'xlabel ' , ticlabs 

1
)

NB. my_date_label =: ( ('-'&(,~))@":@(1&{) , ('-'&(,~))@":@(2&{) , _2&{.@":@(0&{) ) @: todate 

my_date_label =: 3 : 0

0 my_date_label y

:

'-'&iv@:(}.^: (-. x))@:todate y
)

plot_dates_sa =: 3 : 0 

0 plot_dates_sa y 

:

NB. plot date (or date+time) data and label X axis with dates for Mondays only 
NB. x - whether to use plot (0 - default) or pd (1) ; extra plot options (optional) ; include year? - def 0 - no 
NB. y - plot data (same format used by pd or plot) 

usePlot =. > {. x
plot_options =. > 1&{ :: ''&[ x
incYear =. > 2&{ :: 0: x  
maxTicLabels =. > 3&{ :: 20&[ x

x_data =. > {. y 


if. usePlot do.

	tic_minmax =. (] , (-~)/) (<.@min , >.@max) x_data 

	raw_ticpos =. steps tic_minmax 
                
	if. (2&{ tic_minmax) > 20 do.

		NB. filter tic positions to just Mondays 

		raw_ticpos =. (1&=@:gwd # ]) raw_ticpos 

	end.

        if. 20 < # raw_ticpos do.

          raw_ticpos =. raw_ticpos {~ (i.20) * <. (20 %~ # raw_ticpos)  

        end.
        
	if. (15&> # raw_ticpos) do. 

		raw_tic_labels =. (' '&,) each (<@(incYear&my_date_label))"0 raw_ticpos

	else.	

	  raw_tic_labels =. (' '&,) each (<@(2&{.)@('""'&,)@": ` (<@(incYear&my_date_label)) @. (1&=@gwd))"0 raw_ticpos
          
	end. 

	if. (maxTicLabels&< # raw_tic_labels) do.

		NB. only print every other label (otherwise axis labels will blur together) 

		NB. raw_tic_label_skips =. ([: 1&+ [: 2&* [: i. [: <. [: 2&db #) raw_tic_labels 

                NB. try to just print 20 labels maximum

                raw_tic_label_skips =. (i. # raw_tic_labels) -. <. steps 0 , maxTicLabels ,~ _1&+ # raw_tic_labels 

                xxx =: raw_tic_labels
                xxx1 =: raw_tic_label_skips 
                
		raw_tic_labels =. (<' ""') raw_tic_label_skips } raw_tic_labels 

	end. 

	plot_options plot y 

	xxtp =: raw_ticpos 
	xxtl =: raw_tic_labels

	pd 'xticpos ' , ": raw_ticpos 
	pd 'xlabel ' , ; raw_tic_labels 

else. 

	pd y
	pd plot_options 

end. 

pd 'show'

1
)

plotdts =: plot_dates_sa 

sh =: 3 : 0 

NB. simple histogram function 

 0 sh y 
: 
  (] ,. (+/)@:(1&{"1) %~ [: (+/\ ,. ]) 1&{"1) (] /: x&{"1)@freqcount y
)

rnt =: 3 : 0 

NB. divide by x, round, multiply by x - effectively round y to nearest mult of x 

10 rnt y 

:

x&* round x&db y 
)

NB. divide by 

db =: %~ 

round =: <.@(0.5&+)


NB. fun with some simple iterated functions

tpi =: 2*pi

NB.
NB. Have some fun with using unicode to draw boxes - maybe make simple outputs
NB.
NB Draw a boxed character 
NB.

boxMe =: {{    (u: 16b250c 16b2500 16b2510) , (10 { a.) , (u: 16b2502) , y , (u: 16b2502) , (10 { a.) , (u: 16b2514 16b2500 16b2518) }}


sj =: 4 : 0 

NB. simple join on specified columns 
NB. x - A ; ca - default 0 
NB. y - B ; ca - default 0

NB. returns - A joined with B on columns ca from A and cb from B 

ca =. 0: ` ([: > 1&{ :: 0:) @. ((32&=)@(3!:0)) x 
cb =. 0: ` ([: > 1&{ :: 0:) @. ((32&=)@(3!:0)) y 

A =. ] ` (>@{.) @. (32&=@(3!:0)) x 
B =. ] ` (>@{.) @. (32&=@(3!:0)) y 

boxA =. (32&=)@(3!:0) A
boxB =. (32&=)@(3!:0) B 

if. boxA *. -. boxB do.

	B =. <"0 B 
	boxAll =. 1 
	
elseif. boxB *. -. boxA do. 

	A =. <"0 A 
	boxAll =. 1 

end.  


fill =. 0: ` ((<0)&[) @. (32&=)@(3!:0) B 

A ,.  (B , fill) {~ (cb&{"1 B) i. (ca&{"1 A) 
) 

sjh =: 4 : 0 

NB. simple join with headers - see sj 

x ( ([: ,: {.@>@{.@[ , {.@>@{.@]) , (}.@>@{. ; >@{:)@[ sj (}.@>@{. ; >@{:)@] ) y
) 


sjx =: 4 : 0 

NB. simple join on specified columns - don't include match column of B 
NB. x - A ; ca - default 0 
NB. y - B ; ca - default 0 
NB. returns - A joined with B on columns ca from A and cb from B 

ca =. 0: ` ([: > 1&{ :: 0:) @. ((32&=)@(3!:0)) x 
cb =. 0: ` ([: > 1&{ :: 0:) @. ((32&=)@(3!:0)) y 

A =. ] ` (>@{.) @. (32&=@(3!:0)) x 
B =. ] ` (>@{.) @. (32&=@(3!:0)) y 

boxA =. (32&=)@(3!:0) A
boxB =. (32&=)@(3!:0) B 

if. boxA *. -. boxB do.

	B =. <"0 B 
	boxAll =. 1 
	
elseif. boxB *. -. boxA do. 

	A =. <"0 A 
	boxAll =. 1 

end.  

selB =. cb -.~ i. 1&{ $ B 

fill =. 0: ` ((<0)&[) @. (32&=)@(3!:0) B 

A ,.  selB&{"1 (B , fill) {~ (cb&{"1 B) i. (ca&{"1 A) 
) 

fj =: {{)d

  NB. full join on specified columns - old interface 

  if. 0&= # x do. y return. elseif. 0&= # y do. x return. end. 

  0 fjv x ; < y

}} 

fjv =: 4 : 0 

NB. full join on specified columns - new array has rows for every member of specified columns in A and B 

0 fjv y 

:

NB. x - fillValue - default to 0 
NB. y - (A ; ca) ; < B ; cb  

infoA =. > 0&{ y
infoB =. > 1&{ y  

fillValue =. x 

ca =. 0: ` ([: > 1&{ :: 0:) @. ((32&=)@(3!:0)) infoA 
cb =. 0: ` ([: > 1&{ :: 0:) @. ((32&=)@(3!:0)) infoB 

A =. ] ` (>@{.) @. (32&=@(3!:0)) infoA
B =. ] ` (>@{.) @. (32&=@(3!:0)) infoB

boxA =. (32&=)@(3!:0) A
boxB =. (32&=)@(3!:0) B 

if. boxA *. -. boxB do.

	B =. <"0 B 
	boxAll =. 1 
	
elseif. boxB *. -. boxA do. 

	A =. <"0 A 
	boxAll =. 1 

end.

NB. get unique set of columns 

allCol =: ~. (ca {"1 A) , (cb {"1 B) 

NB. fills for A and B 

numDrop =. 1&{ :: 1: $ allCol 

((A ; ca ; fillValue)&selColFill ,. [: numDrop&}."1 (B ; cb ; fillValue)&selColFill) allCol
)

selColFill =: 4 : 0 

NB. select rows from A where columns ca match SC  - fill with 0's 

NB. X - A ; ca - default 0 ; fillValue 
NB. y - SC 

SC =. y

fillValue =. x getArg 2 0 
ca =. > 1&{ :: 0: x 
A =. > {. x 

fillA =. ( (fillValue&[) ` ((<fillValue)&[) @. (32&=)@(3!:0) ) A

selA =. ca -.~ i. 1&{ $ A 

SC ,. selA&{"1 (A , fillA) {~ (ca&{"1 A) i. SC
)

sclu =: 4 : 0 

NB. simple column lookup - simulate a dictionary / hash table with a two column array or translation table 
NB. x - two columns - lookup_value ,. return_value 
NB. y - value to lookup / translate 

x ( _1&(,~)@:(1&{"1)@:[ {~ ] i.~  [: {."1 [) y  
)

boxsiqu =: {{)v

 'must be called dyadically'

:

NB. simple query for a 2D boxed array 
NB.
NB. X - define query
NB.     (col name ;'in'; (v1;v2;...vn))
NB.     (col name ;'nin'; (v1;v2,...vn))
NB.     (col name ;'eq'; v)
NB.     (col name ;'ne'; v)
NB.     (col name ;'gt'; v)
NB.     (col name ;'lt'; v)
NB.     (param ;'='; v)  - sets parameter - current parameters:
NB.           svo - if 1, just return selection vector
NB.           noHead - if 1, assume first row is data - columns must be specified by number (and in that case why not just use other functions) 
NB.
NB. Y - 2d boxed array - first row is assumed to be column names, unless noHead set 
NB.
NB. Parses X and pulls out parameter options first.
NB.
NB. Applies conditions one by one and returns either selection vector or results.   Currently combines all conditions with AND or OR (if param or set) 
NB.

NB. parse out parameters:

logOR =. svo =. noHead =. 0 

for_currParam. ('=';1) fcv x do.

  res =. ('selVec';'noHead';'or')&i. {. currParam

  if. res < 3 do.

    ". (> res { 'svo';'noHead';'logOR') , ' =. 1' 

  end. 

end.

NB. construct column name mapping

'nrow ncol' =. $ y

if. noHead do.

  colNames =. <"0 i. ncol 

else.

  colNames =. {. y 

end. 

NB. build up our selection array

if. noHead do.

  selVec =. nrow # -. logOR

else.

  selVec =. (-. logOR) #~ nrow - 1

end.

for_currQuery. ('=';1)&fnv x do.

  debugme =: currQuery

  currCol =. colNames&i. {. currQuery

  if. currCol >: ncol do. continue. end.     

  currComm =. > 1&{ currQuery

  val =. a: -.~ 2&}. currQuery

  if. (1&< # val) *. (1&= L. val) do. val =. < val end.

  NB. if. 1 < # val do. val =. < val end. 
  
  if. (currComm -: 'in') +. (currComm -: 'eq')  do.

       selVec =. selVec ,. (currCol ; val)&fcisv (}.^:(-. noHead)) y

  elseif. (currComm -: 'nin') +. (currComm -: 'ne') do.

      selVec =. selVec ,. -. (currCol ; val)&fcisv (}.^:(-. noHead)) y

  elseif. (currComm -: 'gt') do.

      selVec =. selVec ,. (currCol ,~ > {. val)&fgtv (}.^:(-. noHead)) y

  end.

end. 

if. logOR do. selVec =. +./"1 selVec else. selVec =. *./"1 selVec end. 

if. svo do.

  selVec

else.

  ( (-. noHead)&{. , [: selVec&# (}.^:(-. noHead)) ) y

end. 
}}

boxsisc =: {{)d

NB. select columns from 2D boxed array by column header
NB.
NB. X - boxed list of column headers
NB. Y - 2D boxed array 

NB. (] #~"1 (#x)&[ > x&i.@:{.) y

(] {~"1 [: ( ] #~ (# {. y)&[ > ] ) {. i. x&[) y
}}


boxsisort =: {{)d

NB. sort 2D Boxed array on columns specified by X
NB.
NB. X - regular expression(s) to match to column headers
NB. Y - 2D Boxed Array 
NB.

sortCols =. ; x <@fsetrei"(0 _) {. y 

(sortCols ; 1) scv y 
}}


sh =: 3 : 0 
  NB. simple histogram 
  NB. X - histogram column to sort on - 0 items, 1-count (def = 0) 
  NB. y - data - can be boxed 
  0 sh y 
:
  boxedY =. 0&< L. y 
  
  NB. (] ,. (+/)@:(1&{"1) %~ [: (+/\ ,. ]) 1&{"1) (] /: x&{"1) (~. ,. (<^:boxedY)"0 #/.~) y
  (] ,. [: (<^:boxedY)"0 (+/ %~ +/\ ,. ])@:>@:(1&{"1)) (] /: x&{"1) (~. ,. [: (<^:boxedY)"0 #/.~) y	
)
