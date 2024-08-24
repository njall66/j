NB.
NB. functions to help with doing sixel graphics
NB.

startSixel =: (27&{ a.) , 'P;;3000q'
endSixel =: (27&{ a.) , '\'

sixelColors1 =: 0 : 0
#0;2;0;0;0
#1;2;100;0;0
#2;2;0;100;0
#3;2;0;0;100
#4;2;80;10;70
)

testSixel =: 3 : 0

startSixel , sixelColors1 , y , endSixel
)


sixelStripChart =: 3 : 0

1000 sixelStripChart y

NB. Simple Sixel based strip chart
NB.
NB. X - width for chart (def = 1000)
NB. Y - list of data values for strip chart
NB.

xw =. 0&{ :: 1000 x 

minData =. min y
maxData =. max y

scaledData =. <. xw * (y - minData) % (maxData - minData)

)


arrayToSixelRow =: {{)v

NB. convert 6 rows of an array to Sixel characters
NB.
NB. y - array - first six rows will be converted to Sixel characters
NB.

a.&({~) 63&+ #. |: |. 6&{. y 
}}

arrayToSixel =: {{)v

NB. take array and convert to Sixel characters
NB.
NB. y - array to convert to Sixel characters - should be all 1's and 0's
NB.

_6 arrayToSixelRow \ y 
}}

sixelSimpleCircle =: {{)v

NB. generate circle in a sixel bit map
NB.
NB. Y - radius
NB.
NB. bitmap will have dimensions 2 * radius
NB.

r =. 0&{ :: 5 y

rint =. >. r 

dim =. 2 * >. rint

arrayToSixel (r^2)&> (|."1 ,. ]) (|. , ]) +/~ *: 0.5&+ i. rint 
}}