NB.
NB. try to play around with Canvas element - what kind of interesting visualizatiions can we do
NB.

NB. copy initialization from lab

   require'~addons/ide/jhs/page/jcanvas.ijs'
   'jsxw_z_ jsxh_z_'=: jsxwh_z_=: 300 300 NB. width,height 
   p=: 'jcanvas;_' cojhs jsxwh NB. create locale - no show
   title__p=: 'canvas-tour'
   refresh__p=: '' NB. initial and refresh is blank canvas


   f1=: 3 : 0
jsxnew''              NB. clear jsxbuf buffer
jscbeginPath''        NB. start path that will be painted
jsclineWidth 4        NB. pen width
jscstrokeStyle jsxucp'red' NB. red pen
jscmoveTo 0 0         NB. upper left 
jsclineTo jsxwh       NB. lower right
jscstroke''           NB. draw line
jsxnew''              NB. return jsxbuf and clear
)

