NB.
NB. Class to do a simple SVG bar chart
NB.

coclass 'svgBar'

NB. Set Defaults
NB.

NB. start out setting the following on a <g> element

barOP =: 1
barSW =: 1

barRX =: 5
barRY =: 5   NB. not really needed - but doesn't hurt to include at the beginning 

barHeight =: 10 

svgSize =: 1000 500

plotWin =: 1000 500 

dw =: <. 0.5&* svgSize - plotWin 

NB. set the plot ranges to undefined 

plotRangeX =: a:
plotRangeY =: a:  

barColors =: 'blue' ; 'red' ; 'purple' ; 'orange' ; 'green' 

initTagList =: 3 : 0

tagFormat =: ,:'rect' ; < <;._1 ' x="%s" y="%s" width="%s" height="%s" rx="%s" ry="%s" fill="%s"'
tagFormat =: tagFormat , 'circle' ; < <;._1 ' cx="%s" cy="%s" r="%s"'
tagFormat =: tagFormat , 'path' ; < <;._1 ' fill="%s" stroke="%s" d="%s"'

1
)

create =: 3 : 0

init y 
)

init =: 3 : 0

setLabels 0&{ a:&[ y
setData > 1&{ (0 $ 0)&[ :: y 

1
)

setSVGSize =: 3 : 0

svgSize =: y

setDW ''

1
)

setPlotWin =: 3 : 0

plotWin =: y

setDW '' 

1
)

setDW =: 3 : 0

dw =: <. 0.5&* svgSize - plotWin

1
)



setData =: 3 : 0

NB. set data for the bar graph

data =: y 

if. 1 = # $ data do.

  NB. data is one dimensional - add in a dummy x values 0..(_1&+ # data)

  data =: (] ,.~ [: i. #) data 

end. 

$ data
)

setLabels =: 3 : 0

NB. Set labels for graph
NB.
NB. Y - baxed array of labels for each data value
NB.

labels =: y 

$ labels 
)


validatePlotWindow =: 3 : 0

NB. check if plot window set to undefined placeholder a: - if so, set to SVG element size
NB.
NB. Note needed now - as we are defaulting plot window to SVG element size 

1
)

setPlotRangeX =: 3 : 0

plotRangeX =: y 

1
)

setPlotRangeY =: 3 : 0

plotRangeY =: y

1
)

validatePlotRange =: 3 : 0

NB. if plot ranges set to a: (undefined placeholder), set to values based on data
NB.
NB. assumed that data is set
NB.
NB. 

if. plotRangeX -: a: do.

  plotRangeX =: (min , [: 1.1&* max) 0&{"1 data 

end.

if. plotRangeY -: a: do.

  plotRangeY =: (min , [: 1.1&* max) 1&{"1 data

end. 

plotRange =: plotRangeX ,: plotRangeY

plotRangeDelta =: -~/"1 plotRange 

plotRange 
)


scaleData =: 3 : 0

NB. Scale the Data - using plotRangeX, plotRangeY, 
NB.
NB. Takes raw data (stored in variable data), plot range, plot window width + height ==> return data points scaled to SVG element 
NB.
NB. Assumes that data, plot ranges, plot window  all set 

<. plotWin *"(_ 1) plotRangeDelta (%~)"(_ 1) (0&{"1 plotRange) (-~)"(_ 1) y 
)

flipData =: 3 : 0

NB. take scaled data and flip y-values so we can plot on area that goes from (0,0) in upper left corner to (width,height) in lower right corner 

(0&{"1 ,. ({: plotWin)&[ - }."1) y 
)

drawGraph =: 3 : 0

NB. generate SVG for a simple bar graph
NB.
NB. Y - orientation - 0 - vertical bars, 1 - horizontal bars - doesn't work yet 
NB.

orient =. (] ` 0:) @. (''&-:) y 

numBar =. # data 

NB. set height/width of each bar based on height of SVG element and number of bars
NB. Spacing between bars is 0.5 * bar height
NB. Thus  barH <. =: svgH  % N + (N+1) % 2 and spaceH =. barH % 2 

barH =. <. (orient { plotWin)  % numBar + (numBar + 1) % 2 

spacing =. <. barH % 2     

validatePlotRange '' 

if. orient = 0 do. 

    NB. scale the data

    dataScaled =: scaleData  data    

    'rect'&formatTag"1 (numBar $ barColors) ,.~ (<"0)  (({. dw) + 0&{"1 dataScaled) ,. ( ({: dw) + ({: plotWin) - 1&{"1 dataScaled )  ,.  (numBar # barH)  ,. (1&{"1 dataScaled)  ,. (numBar # barRX) ,. (numBar # barRY)

else.

    NB. scale the data

    dataScaled =: scaleData  |."1 data    

    'rect'&formatTag"1 (numBar $ barColors) ,.~ (<"0)  (({. dw) + numBar # 0) ,. ( ({: dw) + 1&{"1 dataScaled )  ,.  (({. dw) + 0&{"1 dataScaled)  ,. (numBar # barH)  ,. (numBar # barRX) ,. (numBar # barRY)

end.

)

drawLine =: 3 : 0

NB. Y - orientation - (0 - don't invert x,y), 1 - swap x,y coordinates
NB.

validatePlotRange ''

dataScaled =: flipData scaleData data

'path'&formatTag 'none'; 'blue' ; ('M'&[ , ','&(iv_base_)@:{. , ' L'&[ , ','&(iv_base_)@:,@:}.) dataScaled 
)


formatTag =: 4 : 0

NB. Given tag name and tag attributes, format SVG element
NB.
NB. X - tag name - needs to match first column of tagFormat array
NB. Y - attribute values - need to match tagFormat attribute list 

tagIndex =: (0&{"1 tagFormat) i. < x 

attribList =. (<' ') ,.~ |: > {: tagIndex { tagFormat

paramFilt =. a: -.@= y

attribFilt =. (# attribList) {. (0 #~ # attribList) ,~ paramFilt

NB. (attribFilt # attribList) sprintf attribFilt # y

'<' , x , ' ' , '/>' ,~ (; attribFilt # attribList) sprintf ": each paramFilt # y 
)


coclass 'base' 