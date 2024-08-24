NB.
NB. play around with SVG elements
NB.


NB. Wrapper functions for generating SVG elements
NB.
NB. Intended to be displayed with something like jhtml
NB.

svgCirc =: 3 : 0

NB. SVG Circle
NB.
NB. Y = Cx ; Cy ; radius ; fill opacity ; fill ; stroke ; stroke-width   

cx =. dquote ": > 0&{ :: '50%'&[ y
cy =. dquote ": > 1&{ :: '50%'&[ y
r =. dquote ": > 2&{ :: '25%'&[ y
op =. dquote ": > 3&{ :: 1: y
fc =. dquote > 4&{ :: 'black'&[ y
s =. dquote > 5&{ :: 'black'&[ y
sw =. dquote ": > 6&{ :: '1'&[ y


'<circle cx=',cx,' cy=',cy,' r=',r,' fill-opacity=',op,' fill=',fc,' stroke=',s,' stroke-width=',sw,'></circle>' 
)

svgRect =: 4 : 0

NB. SVG Rectangle
NB.
NB. X = Cx ; Cy ; rx ; ry ; width ; height ; fill opacity ; fill ; stroke ; stroke-width   
NB. Y - data to include in between <rect> tags -  <rect ......> y </rect> 

cx =. dquote ": > 0&{ :: '50%'&[ x
cy =. dquote ": > 1&{ :: '50%'&[ x
rx =. dquote ": > 2&{ :: '25%'&[ x
ry =. dquote ": > 3&{ :: '25%'&[ x
width =. dquote ": > 4&{ :: '25%'&[ x
height =. dquote ": > 5&{ :: '25%'&[ x
op =. dquote ": > 6&{ :: 1: x
fc =. dquote > 7&{ :: 'black'&[ x
s =. dquote > 8&{ :: 'black'&[ x
sw =. dquote ": > 9&{ :: '1'&[ x

'<rect x=',cx,' y=',cy,' rx=',rx,' ry=',ry,' width=',width,' height=',height,' fill-opacity=',op,' fill=',fc,' stroke=',s,' stroke-width=',sw,'>',y,'</rect>' 
)

svgTag =: 3 : 0

'' svgTag y

:

'<svg ' ,x,'>', '</svg>' ,~ y
)


genTag =: 4 : 0

NB. Put in an element
NB.
NB. X = (tag) ; boxed array of attributes
NB.
NB. Y - content for element
NB.

element =. > {. x
attributes =. > {: x

'<' , element , ' ' , attributes , '>' , ('</' , element , '>') ,~ y 
)

svgBarGraph =: 3 : 0

(1000;500;50;'svgColors1';'black') svgBarGraph y 

: 

NB. try to construct a simple bar graph using SVG rectangles 
NB.
NB. x - size of SVG window - (width, height) , leftMargin , colorSchemeName, backgroundColor 
NB. y - data - list of bar values
NB.

NB. 'svgWd svgHt leftMargin' =. x

svgWd =. > 0&{ :: 1000&[ x
svgHt =. > 1&{ :: 500&[ x
leftMargin =. > 2&{ :: 50&[ x
colorSchemeName =. > 3&{ :: 'svgColors1'&[ x
backgroundColor =. > 4&{ :: 'black'&[ x 

svgTagAttribs =. 'width="' , (": svgWd) , '" height="' , (": svgHt) , '" style="background-color:',backgroundColor,'"'  

numBars =. # y 

NB. total height of SVG element - (# y) * barHt + (_1 + # y) * barSpacing + 2 * header_footer

NB. just go with standard spacing between bars and standard header / footer sizes 

barSpacing =. 4 

header_footer =. 10

NB. compute bar height and set rounding for 

barHt =. <. numBars %~ svgHt - (2 * header_footer) + (numBars - 1) * barSpacing 

barRnd =. 2

NB. bar N is at (leftMargin , (N-1)* (barHt + barSpacing)) 
NB.
NB. scale width of bars to be 80% of full width
NB.

maxRawWidth =. max y

scaleWidth =. maxRawWidth %~ 0.8 * (svgWd - leftMargin)

scaledY =. <. scaleWidth * y 

NB. use a cheesy loop to build up all the rectangles - easy for now (future do it more elegantly ???)

res =. '' 

for_i. i. numBars do.

currColor =. (i (] {~ [  |~ #@:]) ". colorSchemeName)

res =. res , (leftMargin ; (header_footer + i * barHt + barSpacing) ; barRnd ; barRnd ; (i { scaledY) ; barHt ; 1 ; currColor ) svgRect ''  

end. 

svgTagAttribs svgTag res
)


svgSimpleXYPlot =: 3 : 0

1000 svgSimpleXYPlot y 

:

NB. simple x-y plot
NB.
NB. X -
NB. Y - set of points -either 2xN or Nx2 ( 2x2 will be taken as x,.y )
NB.
NB. 

svgWd =. > 0&{ :: 1000&[ x
svgHt =. > 1&{ :: 500&[ x
leftMargin =. > 2&{ :: 50&[ x
colorSchemeName =. > 3&{ :: 'svgColors1'&[ x
backgroundColor =. > 4&{ :: 'black'&[ x 

header_footer =. 10

NB. some base attributes 

svgTagAttribs =. 'width="' , (": svgWd) , '" height="' , (": svgHt) , '" style="background-color:',backgroundColor,'"'  

NB. define a symbol to use for plotting 

res =. '<symbol id="s0" width="9" height="9"><circle cx="5" cy="5" r="4"/></symbol>'

NB. scale our points - we will also need to flip Y points around
NB.
NB. plotting area is 0.9*(svgWd - leftMargin) , 0.9*(svgHt - 2 * header_footer)
NB.

NB. scale X points 

plotWidth =. ( svgWd - leftMargin ) * 0.9
plotHeight =. ( svgHt - 2 * header_footer) * 0.9 

NB. Figure out ranges for plot - so we can scale our data sensibly

if. 2 = # $ y do.

 'dataMinX dataMinY' =. min y
 'dataMaxX dataMaxY' =. max y

else.

  'dataMinY dataMaxY' =. (min, max) y 
  dataMinX =. 0
  dataMaxX =. _1 + # y 

  NB. just add column to y with "x" coordinates 

  y =. (] ,.~ [: i. #) y 

end. 

deltaDataX =. dataMaxX - dataMinX
deltaDataY =. dataMaxY - dataMinY 

scaledDataX =. <. leftMargin + plotWidth * deltaDataX %~ (0&{"1 y) - dataMinX 
scaledDataY =. <. header_footer + plotHeight * deltaDataY %~ (1&{"1 y) - dataMinY 

svgTagAttribs svgTag ('path'; ' stroke="red" d=" M ' , '"' ,~ ' ' iv ',' iv"1  scaledDataX ,. scaledDataY) genTag ''
)

