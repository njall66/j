NB.
NB. Break Out Some of My General Functions / Wrappers
NB.

doc_general_utilities =: 0 4 $ a:

addDoc =: {{ doc_general_utilities =: doc_general_utilities , ( ({. , (<@:([: (] ;._1) (10&{a.)&, )@:>@:(1&{)) , {: ) y ) , <'doc_general_utilities.ijs' }}

NB. wrapper functions to make getting size, timing, etc easier:

objSize =: (7!:5) 

addDoc 'objSize' ; 'Dump size of object.  Works on atoms, arrays, and boxed data.';'#info' 

NB. simple formatting functions - display list of items in a table with specified width 

fillAtom =: ( (0:)`(' '&[)`(0:)`(0:)`((0j0)&[)`(a:&[)`(0:)`((0r1)&[)`(0:)`(0:)`(' '&[)`(0:)`(0:)`((0j0)&[)`(a:&[)`(' '&[)`((u:0)&[)`((u:0)&[) @. (2&^.)@:(3!:0) ) 
tableMe =: {{ (x ,~ >. x %~ # y)   $!.(fillAtom y) y }}

addDoc 'fillAtom' ; 'Given an atom or array, figure out an appropriate fill' ; '#format'

exec_in_dir =: 1 : 0 

currdir =. 1!:43 '' 

1!:44 x

res =. u y

(1!:44 currdir)  

res
)

addDoc 'exec_in_dir'; {{)n
Adverb:
  X - directory
  U - function
  Y - parameter for function U

Switch to directory X, execute U Y, then return to initial directory
}} ; '#general #adverb'

opc =: 1 : 0 

NB. adverb - apply u to data in columns (>@:{: x) grouped by (>@:{. x) 

groupCol =. > {. x 
datacol =. > 1&{ :: 1: x 
boxres =. > 2&{ :: 0: x 

((<^:boxres"0)@~.@:(groupCol&{"1) ,. groupCol&{"1 u /. datacol&{"1) y
) 

addDoc 'opc' ; {{)n
Adverb - simple wrapper for /.:
  X - (grouping columns) ; (data columns)
  U - function to apply to data columns grouped using grouping columns
  Y - 2D array 
Doesn''t work for complex cases.  Works best when U applied to grouped data returns single line.
}} ; '#adverb #analysis #grouped_data'


NB. atbx - simple adverb - given two sets of boxed data - apply v to each set, unbox, apply u dyadically, rebox - probably painfully inefficient 

atbx =: atbx =: 2 :  '>@:v@:[ <@u >@:v@:]' 

addDoc 'atbx' ; {{)n
Conjunction - unbox X + Y, apply v to each, combine with y, rebox
  X - input array 1
  U - function to combine
  V - process data prior to combine
  Y - input array 2

}} ; '#adverb #conjunction #analysis'


NB.  min ..  max 
mrstep =: ({: + [: i. [: 1&+ -/)@:\:~

addDoc 'mrstep' ; 'DON''T USE: Generate sequence of integers from (min y) to (max y) - only works for (#y)=2.' ; '#sequence #baddesign'

NB. Hexdump and related utilities

hxdmp =: 3 : 0

16 hxdmp y

:

hx =. '..' ,~ ,/ '0123456789abcdef' ,."(0 1)  '0123456789abcdef'
cd =. ' '&(,~)  (32 # '.') , ((32+i.96) { a.) , 128 # '.' 

width =. x
len =. >. (# y) % x 

(8&d2h@:(width&*)@:i.@:# ,. [: ' '&,. ]) (cd&({~) ,~ [: ' '&(,~) [: ' '&iv hx&({~) )"1 (len , width)&$ (width # 256)&(,~) a.&i. y 
)

addDoc 'hxdmp';{{)n
Variable width hexdump:
  x - width
  y - binary / string
Generate hexdump of binary blob / string y
}};'#hexdump'


a2d =: a.&i.
d2a =: a.&{~
a2h =: [: (,/ '0123456789abcdef' ,."(0 1)  '0123456789abcdef' )&({~) a.&i.

addDoc 'a2d' ; 'Convert string to decimal ascii values.' ; '#string #convert'
addDoc 'd2a' ; 'Convert sequence of decimal ascii values to a string' ; '#string #convert'
addDoc 'a2h' ; 'Convert string to list of hex values (as N x 2 array of strings).' ; '#string #convert'


NB.
NB. Simple table / list analysis and manipulation 
NB. 


NB. sinz dyadic - subtract if right operand not zero, else return 0

sinz =: {{ (x&-)`0: @. (0&=) y }}

addDoc 'sinz' ;{{)n
Dyadic only - subtract if not zero:
  - y -.@:-: 0 ==> x - y 
  - y -: 0     ==> 0
}}; '#math' 

sbc =: 3 : 0

1 sbc y 

:

NB. subtract if not zero - two boxed columns - useful for table manipulation
NB. return boxed result
NB.
NB. X - column numbers - subtract column (0{x) from column (1{x) ,  header? (default = 1 - yes) 
NB. Y - boxed array
NB.
NB. if header?=1 - cuts off header before unboxing and subtracting
NB.
NB. assumed numeric data in boxes - doesn't do any type conversions 

c1 =. 0&{ x
c2 =. 1&{ x 
isHeader =. 2&{ :: 1: x 

(c1&{"1 (sinz"0 atbx (}.^:isHeader)) c2&{"1) y
)

addDoc 'sbc' ; {{)n
Subtract columns if non-zero
  X - column 1 , column 2 , header ?
  Y - boxed array
Subtracts (column 1) - (column 2) where column 2 non-zero 
}} ; '#math'

setCol =: 4 : 0 

NB. set specified column of array 
NB. x  - col # ; col values 
NB. y - array 

'iCol colData' =. x 

colData iCol }"(_1 1) y 
)

addDoc 'setCol' ;{{)n
Set a column in array:
  X - (column number) ; column values
  Y - target array
}} ; '#array'

sumcol =: 4 : 0 

NB. sum columns 
NB. X - list of columns to sum 
NB. y - array 


+/"_1 x&{"1 y 
)

addDoc 'sumcol' ; 'Sum columns x from array y' ; '#array' 

first =: 3 : 0 

NB. return first y elements of x or first x elements of y 

10 first y 

:


if. (1 = # x) *. (1 < # y) do.

x {. y

elseif. (1 < # x) *. (1 = # y) do.

y {. x 

elseif. 1 do. 

nl =. > 0&{ :: 10&[ x 
fl =. > 1&{ :: 0: x 

(fl&{. , nl&{.) y

end. 

)

addDoc 'first' ; 'Return first x rows or array y.   x can be negative.' ; '#array #select'

c2hf =: 3 : 0 

NB. take column specified by x (def = 1) and convert from seconds to hours 

1 c2hf y 

:

s2hf@:(x&{"1) y 
)

addDoc 'c2hf' ; 'Assume column x of array y is seconds and convert to hours' ; '#array #time'  

fh =: 3 : 0 

NB. filter to specified hours 
NB.
NB. x - start hour, end hour, time column (def = 1) , notrange (def 0) , header? (def 0)
NB. y - data array 

(8, 12 , 1) fh y

:

'sh eh' =. 2&{. x 
tc =. 2&{ :: 1: x
notRange =. 3&{ :: 0: x 
header =. 4&{ :: 0: x 


(header ,~ notRange ,~ tc ,~ 3600*(sh , eh))&fcr y 
)

addDoc 'fh' ; {{)n
Filter array y to hour range specified by x:
  X - (start hour - can be fractional , end hour - can be fractional , time column)
  Y - array to filter
Time column is assumed to be seconds.
}} ; '#array #timefilter'

fam =: 3 : 0 

NB. filter to AM - e.g. 12:00 AM - 12:00 PM

1 fam y 

:

(0,12,x) fh y  

)

addDoc 'fam' ; 'Filter array y where column x (def = 1) is time in seconds to AM' ; '#array #timefilter'

fpm =: 3 : 0 

NB. filter to PM - e.g. 12:00 PM - 11:59:59 PM 

1 fpm y 

:

(12, 24, x) fh y 

)

addDoc 'fpm' ; 'Filter array y where column x (def = 1) is time in seconds to PM' ; '#array #timefilter'

