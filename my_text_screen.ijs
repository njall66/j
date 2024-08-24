coclass 'mts'


NB. winStack - (wy, wx, sx, sy, type, visible) 

create =: {{)v

    init y 

}}

init =: {{)v

    winStack =: 0 $ 0
    winArr =: 0 6 $ 0
    winConStack =: 0 $ < '' 
    winNum =: 0 

}}

clearScreen =: {{)v

    puts_vt_ clearScreen_tui_ 

}}

createWindow =: {{)d

  NB. create a window
  NB.
  NB. X - (wy, wx, sy, sx, type) - where:
  NB.     (wy, wx) - upper left hand corner of window
  NB.     (sy, sx) - nomninal size of window (currently should be same as size of content)
  NB.     type - window type (currently only support type 0)
  NB.
  NB. Y - content
  NB.

  winIndex =. winNum 

  winNum =: winNum + 1

  NB. need to increment sizes by 2 to account for window border 

  winArr =: winArr , x , 0 

  NB. for now, expect the raw content - generate variable name and store data 

  contentName =. 'winCon' , ": winIndex  

  ". contentName , '=:y' 

  winIndex 
}}


displayWindow =: {{)v

  NB. display window
  NB.
  NB. Y - window index 

  'wy wx wsy wsx wt wv' =. y { winArr 

  ". '(wy, wx, 0 , 0, 1) boxALXY_tui_ ',  'winCon' , ": y

  winArr =: (wy, wx, wsy, wsx, wt, 1) y } winArr

  1
}}

NB. function to pull formatting characters from a chunk of text
NB. 
NB. function that inserts single character at a specified location
NB. 
NB. function that inserts multiple characters at a specified location
NB.
NB. given set of windows (essentially squares and locations) - figure out all the intersections (use to minimize redraw efforts)
NB.
NB. add colors and type to window borders (e.g. border of just empty spaces)
NB.




coclass 'base' 