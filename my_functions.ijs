NB.
NB. Play around with simple functions - computation, visualization, etc.
NB.



polyTwoD =: {{)d

NB. compute values of specified two dimensional polynomial on a grid
NB.
NB. x - specify grid - minx, deltax, numx, miny, deltay, numy
NB. y - specify polynmial - rank 2 - N x M - entry (n,m) is coefficient of x^n, y^m
NB.

xgrid =. steps 3&{. x
ygrid =. steps 3&}. x

nx =. # xgrid
ny =. # ygrid 

NB. given table of coefficients - pull out nx2 array of powers (x power , y power) 

arrPow =. ; (>@{. <@,. >@{:)"1 (<@{."1 ,. <@(I."1)@(0&(-.@=))@:}."1)  (i.@:# ,. ]) y

xpow =. ~. 0&{"1 arrPow
ypow =. ~. 1&{"1 arrPow 

xvals =. xgrid ^"(_ 0) xpow
yvals =. ygrid ^"(_ 0) ypow 

sum =. (nx, ny) $ 0

for_currTerm. arrPow do.

  xp =. {. currTerm
  yp =. {: currTerm
  coeff =. (< currTerm) { y

  smoutput currTerm
  smoutput xp, yp
  smoutput coeff
  smoutput (xpow i. xp) , (ypow i. yp)
  smoutput '' 

  sum =. sum + coeff * ( (xpow i. xp) { xvals ) */ (ypow i. yp) { yvals 

end. 

sum ; arrPow ; xvals ; yvals  
}}