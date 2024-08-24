NB.
NB. Play around with some simple HTML constructs
NB.


tag =: 4 : 0

NB. insert HTML tag
NB.
NB. X - tag name ; class (if any) ; tag attributes
NB.
NB. Y - tag contents

if. 0&= L. x do.

  NB. X is not boxed.  Just set tagName=x and set class=attribs='' 

  redX =. x 

  tagName =. > (] ` {. @.  L.) x
  tagClass =. ''
  tagAttribs =. ''

  snert =: 1 

else. 

  redX =. , x 

  tagName =. > {. redX

  tagClass =. ( (' class="'&[ , '"'&[ ,~ ]) ` ] @. (''&-:))  > 1&{ :: ''&[ redX  
  
  tagAttribs =. ((' '&[ , ]) ` ] @. (''&-:)) > 2&{ :: ''&[ redX 

  snert =: 2 

end. 

NB. smoutput x ; tagName ; tagClass ; tagAttribs 

if. y -: '' do.

  '<' , tagName , tagClass , tagAttribs , '/>'

else.

  '<' , tagName , tagClass , tagAttribs , '>' , (": y) , '</' , tagName , '>'

end.
)


htmlTable =: 4 : 0

NB. simple table
NB.
NB. X - table class ; table element attributes - passed to tag function ; row classes ? ; cell classes ? ; header row ?
NB. Y - (rowClasses - only use if row classes flag set) ; (cell classes - only use if cell classes flag set) ; data array to convert to table 

abba =: x ; y 

if. (0&< L. x) *. (2&< # x) do.

  classAndAttribs =. 2&{. x
  rowClasses =. > 2&{ :: 0&[ x
  cellClasses =. > 3&{ :: 0&[ x 

  tableHeader =. > 4&{ :: 0&[ x    
  
  NB. headerRow =. ,/ 'tr'&tag ,/ ('th'&tag@:>)"0 tableHeader
  
else.

  classAndAttribs =. x
  tableHeader =. 0
  rowClasses =. 0
  cellClasses =. 0 
  
end. 

NB. we expect Y to be 1-3 boxes - the third / last box should have the data

rawData =. > {: y 

if. rowClasses do.

  rowClassesDet =. > {."1 y

else.

  rowClassesDet =. (# rawData) # a: 

end. 

if. cellClasses do.

  cellClassesDet =. > 1&{"1 y

else.

  cellClassesDet =. ($ tableHeader&}. rawData) $ a:  

end. 


if. tableHeader -: 1 do.

  headerRow =. ,/ 'tr'&tag ,/ ('th'&tag@:>)"0 {. rawData

else.

  headerRow =. ''

end.

('table';classAndAttribs)&tag headerRow , ,/ (rowClassesDet ,.~ < 'tr') tag"1 ,/"_1  ((< 'td') ,"0 cellClassesDet) ([ tag >@:])"(1 0) headerRow&}. rawData
)

htmlhxdmp =: 3 : 0

NB. simple hexdump in an HTML table
NB.
NB. X - hexdump width ; hexdump - table element class ; base class name for rows ; base class name for cells ; raw row classes ; raw cell classes 
NB.
NB. Y - array to hexdump - assumed to be 1D array of bytes (e.g. a string) 
NB.

16 htmlhxdmp y 

:

hxWidth =. 16&". :: ] > 0&{ x
tableClass =. > 1&{ :: 'hex'&[ x
baseRowClass =. > 2&{ :: 'r'&[ x
baseCellClass =. > 3&{ :: 'c'&[ x
rowClasses =. > 4&{ :: ''&[ x
cellClasses =. > 5&{ :: ''&[ x 
tableAttribs =. > 6&{ :: ''&[ x

rawhxdmp =. hxWidth hxdmp y 

charSel =. (- hxWidth + 1)&{."1
charDrp =. (- hxWidth + 1)&}."1 

if. -.  baseRowClass = '' do.

  rowClasses =.  (baseRowClass&[ <@,"1 [: ":"0 i.@:#@:]) rawhxdmp 
  
end. 

if. -. baseCellClass = '' do.

  nrows =. # rawhxdmp

  cellClasses =. (nrows , hxWidth) $ , baseCellClass <@,"1 ":"0 i. # y 

  addClasses =. 'addr' <@,"1 ":"0 i. nrows
  charClasses =. 'char' <@,"1 ":"0 i. nrows 

  cellClasses =. addClasses ,. cellClasses ,. charClasses 

end.

(tableClass;tableAttribs;1;1) htmlTable (rowClasses) ; (cellClasses) ; < (([: (<"1) charSel) ,.~ [: (<;._1)"1 charDrp ) ' ' ,"1 rawhxdmp 
)


testHTML =: {{)n

<style>
.ccc { color: black; background-color: yellow; text-align: center; border: 2px solid green;}
</style>

<div class="ccc">
Is Everything OK ?
</div> 
<br><br> 
<div style="text-align: center"><para class="ccc">Pelican Can or Can Not</para></div>

}}