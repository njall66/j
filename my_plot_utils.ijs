NB.
NB. Utility functions to help making plots
NB.



NB. define some color schemes that I might enjoy using

PCS_PLOT_BLACK =: 'backcolor black; axiscolor mediumgray; captioncolor lightgray; titlecolor white; labelcolor lightgray;'


pcs_set_color =: 3 : 0 

';' ,~ 'color ', ',' iv > y 
)

NB. "naked" plot configuration string

npcs =: 3 : 0

NB. configuration string generator - add options to remove axes, frame, grid, tics, and labels to configuration string Y 
NB.

'tics 0 0 ; grids 0 0 ; labels 0 0 ; axes 0 0 ; frame 0 ; ' , y
)


sortedBarPlot =: 3 : 0

NB. generate sorted bar chart from data
NB.
NB. X - plot options - always prepend 'type bar;' 
NB. Y - data values - currently only support sinlge series
NB.
NB. Always plot data using plot 
NB.

'' sortedBarPlot y 

:

('type bar;' , x) plot \:~ y
)


lagPlot =: 3 : 0

NB. plot a lag plot
NB.
NB. X - lag (def = 1) 
NB. Y - data values
NB.
NB. plot (Yi-x , Yi) - e.g. plot ith value of Y against (i-x)th value of Y
NB.
NB. always use pd to plot data - caller is responsible for setting up the plot
NB.

1 lagPlot y 

:

pd ps01 (x+1) ({. , {:)\ y 
)


oneDplot =: 3 : 0

NB. do simply 1-D plot
NB.
NB. X - min + max for each data point, min + max for yrange - default - (2 3 0 5)
NB. Y - data values
NB.
NB. use to do quick check for gaps in data
NB.

(2 3 0 5) oneDplot y 

:

'pmin pmax ymin ymax' =. x 

('yrange ',(": ymin, ymax) , ';type hilo') plot ( ] ; [: |: (,: pmin, pmax)&[ #~ # ) y 
)


floatAreaPlot =: 3 : 0 

NB.
NB. floatAreaPlot
NB.
NB. floating area / "band" style plot
NB.
NB. X - additional plot options
NB. Y - xi values ; N sets of yi  - M x N array
NB.

'' floatAreaPlot y 

:

NB. try to come up with reasonable sort order by sorting each column of Y data, summing sort positions, and the sorting 

opts =. ';' ,~ > {. x
cols =: > 1&{ :: (< 'blue';'red';'green';'purple';'yellow';'azure')&[ x 

arrX =. > 0&{ y
arrY =. > 1&{ y 

sortYV =. /: +/"1 |: /:"1 |: arrY

arrY =. sortYV { arrY 

('type areab;',opts,'color ', >@:{. cols) plot (arrX , |. arrX) ; ,: (0&{ , [: |. 1&{) arrY

if. 2 < (# arrY) do.

for_ip. }: }. i. # arrY do.

pd 'color ', >@:{. ip |. cols 

pd (arrX , |. arrX) ; ,: (ip&{ , [: |. (ip+1)&{) arrY 

end.

pd 'show'

end. 

)

NB.
NB. Generate demo plot to do quick test of a color scheme
NB.

testColorSchemePlot =: 3 : 0

NB.
NB. Test a color scheme with a default / statis plot
NB.
NB. X - General plot colors - 'backcolor';'axis color';'label color';'title color';'caption color';'grid color' - default - 'black';'mediumgray';'white';'white';'white';'darkgray' 
NB. Y - list of colors ('color1';'color2';'color3') - can be specified by names (in J's color table) or by 'r g b' 
NB.
NB. Plot up to 6 lines from 0 - 2*PI - sine - one period , cosine - one period , square wave - w/ 2 peaks, triangle wave, sine - two periods, cosine - two periods
NB.

('black';'mediumgray';'white';'white';'white';'darkgray') testColorSchemePlot y 

:

nplots =. # y

ps =. > 0&{ :: 1: x
bc =. > 1&{ :: 'black'&[ x 
ac =. > 2&{ :: 'mediumgray'&[ x
lc =. > 3&{ :: 'white'&[ x
tc =. > 4&{ :: 'white'&[ x
cc =. > 5&{ :: 'white'&[ x 
gc =. > 6&{ :: 'darkgray'&[ x 

NB. 'bc ac lc tc cc gc' =. x 

pd 'new;reset;pensize 3;'

if. ps do. 
    pd 'backcolor ',bc,';axiscolor ',ac,';labelcolor ',lc,';titlecolor ',tc,';captioncolor ',cc,';gridcolor ',gc
end.

xpts =. steps 0 , (2*pi) , 100

basePlots =.  (sin , cos , ([: sin (pi%4)&+) , ([: cos (pi%4)&+) , ([: sin 2&*) ,: ([: cos 2&*)) xpts 

pd ('color ', ',' iv > y)
pd xpts ; nplots {. basePlots
pd 'show'
)

testCS =: 3 : 0

'' testCS y

:

NB. test a color scheme with simple standard plot
NB.
NB. X - plot options (other than colors) 
NB. Y - boxed list of colors 
NB.

pd 'new;reset'
pd x
pd 'pensize 100'

pd pcs_set_color y 

numLines =. # y

pd"1 (2&#@:] ; (1&+ , ])@:sin)"0  (1 + i.numLines)

pd 'show'
)

