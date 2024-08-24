NB. random color schemes that I took from other places

svgColors1 =: ] ;._1 ',' , '#332288,#88CCEE,#44AA99,#117733,#999933,#DDCC77,#CC6677,#882255,#AA4499'
svgColors2 =: 'orange' , 'aqua' , 'purple' , 'blue' ,: 'green'
svgColors3 =: ] ;._1 ',' , }. }: '" ' -.~ '["#ea5545", "#f46a9b", "#ef9b20", "#edbf33", "#ede15b", "#bdcf32", "#87bc45", "#27aeef", "#b33dc6"]'
svgColors4 =: ] ;._1 ',' , }. }: '" ' -.~ '[#e60049", "#0bb4ff", "#50e991", "#e6d800", "#9b19f5", "#ffa300", "#dc0ab4", "#b3d4ff", "#00bfa0"]'
svgColors5 =: ] ;._1 ',' , }. }: '" ' -.~ '["#b30000", "#7c1158", "#4421af", "#1a53ff", "#0d88e6", "#00b7c7", "#5ad45a", "#8be04e", "#ebdc78"]'
svgColors6 =: ] ;._1 ',' , }. }: '" ' -.~ '["#fd7f6f", "#7eb0d5", "#b2e061", "#bd7ebe", "#ffb55a", "#ffee65", "#beb9db", "#fdcce5", "#8bd3c7"]'
svgColors7 =: ] ;._1 ',' , '" ' -.~ '"#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7"'
svgColors8 =: ] ;._1 ',' , '" ' -.~ '"#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7"'
svgColorsSeq1 =: ] ;._1 ',' , }. }: '" ' -.~ '["#115f9a", "#1984c5", "#22a7f0", "#48b5c4", "#76c68f", "#a6d75b", "#c9e52f", "#d0ee11", "#d0f400"]'
svgColorsSeq2 =: ] ;._1 ',' , }. }: '" ' -.~ '["#d7e1ee", "#cbd6e4", "#bfcbdb", "#b3bfd1", "#a4a2a8", "#df8879", "#c86558", "#b04238", "#991f17"]'
svgColorsSeq3 =: ] ;._1 ',' , }. }: '" ' -.~ '["#2e2b28", "#3b3734", "#474440", "#54504c", "#6b506b", "#ab3da9", "#de25da", "#eb44e8", "#ff80ff"]'
svgColorsSeq4 =: ] ;._1 ',' , }. }: '" ' -.~ '["#0000b3", "#0010d9", "#0020ff", "#0040ff", "#0060ff", "#0080ff", "#009fff", "#00bfff", "#00ffff"]'
svgColorsDiv1 =: ] ;._1 ',' , }. }: '" ' -.~ '["#1984c5", "#22a7f0", "#63bff0", "#a7d5ed", "#e2e2e2", "#e1a692", "#de6e56", "#e14b31", "#c23728"]'
svgColorsDiv2 =: ] ;._1 ',' , }. }: '" ' -.~ '["#ffb400", "#d2980d", "#a57c1b", "#786028", "#363445", "#48446e", "#5e569b", "#776bcd", "#9080ff"]'
svgColorsDiv3 =: ] ;._1 ',' , }. }: '" ' -.~ '["#54bebe", "#76c8c8", "#98d1d1", "#badbdb", "#dedad2", "#e4bcad", "#df979e", "#d7658b", "#c80064"]'
svgColorsDiv4 =: ] ;._1 ',' , }. }: '" ' -.~ '["#e27c7c", "#a86464", "#6d4b4b", "#503f3f", "#333333", "#3c4e4b", "#466964", "#599e94", "#6cd4c5"]'

NB. convert list of colors in hex to comma delimited list of colors specified in decimal 

NB. define hex to decimal function - unique for this source file - just don't want to step on the 3 others I have lying around in other files - frowny face 

h2d_loc =: [: 16&#. [: ]`(_16&+)@.(16&<) '0123456789abcdefzzzzzzzzzzABCDEF'&i.

hexRGB2Dec =: [: _2&(h2d_loc@:]\) }.

hexRGB2DecL =: [: ','&ivws [: ": hexRGB2Dec"1

NB. convert all of the color lists above - for convenience

svgColorsD1 =: hexRGB2DecL svgColors1
svgColorsD2 =: hexRGB2DecL svgColors2
svgColorsD3 =: hexRGB2DecL svgColors3
svgColorsD4 =: hexRGB2DecL svgColors4
svgColorsD5 =: hexRGB2DecL svgColors5
svgColorsD6 =: hexRGB2DecL svgColors6
svgColorsD7 =: hexRGB2DecL svgColors7
svgColorsD8 =: hexRGB2DecL svgColors8

svgColorsSeq1D =: hexRGB2DecL svgColorsSeq1
svgColorsSeq2D =: hexRGB2DecL svgColorsSeq2
svgColorsSeq3D =: hexRGB2DecL svgColorsSeq3
svgColorsSeq4D =: hexRGB2DecL svgColorsSeq4

svgColorsDiv1D =: hexRGB2DecL svgColorsDiv1
svgColorsDiv2D =: hexRGB2DecL svgColorsDiv2
svgColorsDiv3D =: hexRGB2DecL svgColorsDiv3
svgColorsDiv4D =: hexRGB2DecL svgColorsDiv4


NB. Color schemes for j-plots 

PCS_TWO_LT =: 'aqua';'fuchsia';'mediumspringgreen';'peachpuff';'beige';'coral'
PCS_THREE_LT =: 'BlueViolet';'DarkBlue';'FireBrick';'MediumSeaGreen';'Olive';'Orange';'Black';'DarkGray'
PCS_FOUR_LT =: 'DarkGoldenrod';'SandyBrown';'Thistle';'Sienna';'SlateGray';'DarkSlateBlue';'SeaGreen';'DarkRed'
PCS_FIVE_LT =: 'DarkBlue';'DarkCyan';'DarkMagenta';'OrangeRed';'DarkRed';'Green';'SlateGray';'Black' 

PCS_ONE_DK =: 'orchid';'turquoise';'goldenrod';'springgreen';'tomato';'lavender'
PCS_TWO_DK =: 'pink';'lightcyan';'magenta';'lime';'red';'lavender'
PCS_THREE_DK =: 'whitesmoke';'azure';'plum';'armyolive';'khaki';'lawngreen'
PCS_FOUR_DK =: 'whitesmoke';'orchid';'skyblue';'aquamarine';'khaki';'peachpuff';'tomato';'cornflowerblue'

PCS_DEC_COOL_ONE =: hexRGB2Dec"1  '#41afaa' , '#466eb4' , '#00a0e1' , '#e6a532' , '#d7642c' ,: '#af4b91'

NB. color schemes for my simple / stupid plots

PCS_1 =: (128 0 0) , (0 128 0) , (0 135 215) , (95 0 135) , (0 95 95) , (175 95 0) , (175 0 95) , (255 135 0) ,: (255 255 0) 