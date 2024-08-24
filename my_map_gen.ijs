NB.
NB. Try to create a simple map generator - implement as a class because - why not ? 
NB.
NB.

require 'fwti.ijs'
require 'tui_kvm.ijs'
require 'numeric'
require 'trig'
require 'stats'
require 'graphics/bmp'
require 'graphics/png'

coclass 'mapGen'

create =: {{)v

NB. y - "map" size in pixels

mapSize =: y 
mapArea =: 1 initMapArea mapSize  

$ mapArea 
}}

initMapArea =: {{)v

1 initMapArea y 

:

NB. generate an initial map
NB.
NB. x - initialization value - defaults to 1 
NB. y - size in pixels
NB.

y $ x 
}}

insArrInArea =: {{)d

NB. given an nxm array and a position (x,y) - insert array into mapArea with upper left corner at (x,y)
NB.
NB. x - vector of length 2 giving upper left corner for insertion
NB. y - 2D array to insert



}}

genRanElement =: {{)v

NB. choose a random map element 
NB.
NB. y - max scale parameter for (x,y)
NB. 

'maxScaleX maxScaleY' =. y 

|:^:(? 2) (1&+ ? maxScaleX)#"1 (1&+ ? maxScaleY)&# >@:(?@:# { ]) ELEMENT_SET 
}}

ELEMENT_SET =: (1 1 ,: 1 1) ; (5 2 $ 1) 

ranRectanlgles1 =: {{)v

(<. mapSize % 8) ranRectangles1 y 

:

NB. test simple random rectangle insertion
NB.
NB. x - max size of rectangles to insert - default to 1/8 size of map area 
NB. y - number of rectangles to insert 
NB.

maxInsertRectSize =. x 

freeList =. ,: (0 0) , mapSize 

for_ir. i. y do. 

  insertSize =. ? maxInsertRectSize 

  insertRectIndex =. (?@:# { ]) I. 2&= (+/"1) insertSize <"(_ 1) freeList 

  'targetRectanglePoint targetRectangleSize' =. insertRectIndex { freeList

  insertPoint =. targetRectanglePoint - (targetRectangleSize - insertSize)

  

end. 

}}

initRanRectangles1 =: {{)v

NB. init set of random non-overlapping rectangles and free list 
NB.
NB. y - size for free list rectangles (n , m) - default to size of Map Area % 10 

mapArea =: initMapArea mapSize 

if. 2&> # y do. 

  sizeFreeRectX =. <. 10 %~ {. mapSize
  sizeFreeRectY =. <. 10 %~ {: mapSize

else. 

  'sizeFreeRectX sizeFreeRectY' =. 2&{. y

end. 

numFreeRectX =. <. sizeFreeRectX %~ {. mapSize
numFreeRectY =. <. sizeFreeRectY %~ {: mapSize

numFreeRect =. numFreeRectX * numFreeRectY 

ranRect =: 0 10 $ 0
ranRectFree =: rectTopLeftSizeToVertexes_base_"1 (numFreeRect $ sizeFreeRectX&* i. numFreeRectX) ,. (numFreeRectX # sizeFreeRectY&* i. numFreeRectY) ,. (numFreeRect # ,: sizeFreeRectX , sizeFreeRectY) 

# ranRectFree 
}}

insIntoRanTarg =: {{)v

NB. insert a randomly sized rectangle into a randomly chosen target free rectangle
NB.
NB. y - ignored for now

insertIndex =. ? # ranRectFree

targSize =. _2&{. insertIndex { ranRectFree 

insSize =. 200 <. ? _10&+ targSize

insPoint =. ? targSize - insSize 

smoutput insPoint , insSize 

insertRectIntoTargRect insertIndex , insPoint , insSize 
}}


insertRectIntoTargRect =: {{)v

NB. given index of target rectangle in free list, insert rectangle uppper left corner (relative to upper left of target), and insert rectangle size 
NB. update free list and list of inserted rectangles 
NB.
NB. Free list property - ranRectFree
NB. inserted rectangle list property - ranRect 
NB. 
NB. attempt to choose new "free" rectangles to maximize sizes
NB.
NB. y - target rectangle (index into free list) , top left corner of insert rectangle - relative to top left corner of insert rectangle, size of insert rectangle 
NB.

'targetRectIndex insertRectX insertRectY insertSizeX insertSizeY' =. y 

targRect =. targetRectIndex { ranRectFree

'Lx Ly' =. 8&}. targRect 

NB. generate up to four new rectangles with empty space after inserting new rectangle - start with just the vertices (add in sizes at end) 

newFreeRect =. 0 8 $ 0

'TLx TLy' =. insertRectTL =. insertRectX, insertRectY 
'BLx BLy' =. insertRectBL =. insertRectTL + (0 ,~ <: insertSizeX)
'TRx TRy' =. insertRectTR =. insertRectTL + (0 , <: insertSizeY)
'BRx BRy' =. insertRectBR =. insertRectBL + (0 , <: insertSizeY)

if. 0 < BLy do.

  newFreeRect =. newFreeRect , (0 0) , (0 , <: BLy) , (BLx, <: BLy) , (BLx , 0) 

end.

if. 0 < TLx do.

  newFreeRect =. newFreeRect , (0, TLy) , (0, <: Ly) , ( (<: TRx) , <: Ly) , ( (<: TRx) , TLy) 

end.

if. (<: Ly) > TRy do.

  newFreeRect =. newFreeRect , (TRx , >: TRy) , (TRx , <: Ly) , (<: Lx , Ly) , ( (<: Lx) , >: TRy ) 

end.

if. (<: Lx) > BRx do.

  newFreeRect =. newFreeRect , ( (>: BLx) , 0 ) , ( (>: BLx) , BRy ) , ( (<: Lx) , BRy ) , ( (<: Lx) , 0) 

end. 

deltaPoint =. 8 $ 2&{. targRect 

newFreeRect =. (] #~ [: 10&< 8&{"1) (] #~ [: 10&< 9&{"1) (] ,. (4 5)&{"1 >:@:- (0 1)&{"1) deltaPoint +"1 newFreeRect 

numFreeRect =. # ranRectFree
ranRectFree =: newFreeRect ,~ (targetRectIndex -.~ i. numFreeRect) { ranRectFree

insertRectPath =. deltaPoint +"1 (TLx , TLy , TRx, TRy, BRx, BRy, BLx, BLy) 

mapArea =: (insertRectPath ; 0 ; 1) insPathArr_tui_ mapArea 

ranRect =: ranRect , insertRectPath , (insertSizeX , insertSizeY) 
}}

insFreeRect =: {{)v

NB. insert all of the free rectangles into the map area - because - why not ? 
NB.
NB. y - insert value 

for_rect. ranRectFree do.

  mapArea =: ( (_2&}. rect) ; y ; 1 ) insPathArr_tui_ mapArea

end. 

$ mapArea 
}}




coclass 'base' 
