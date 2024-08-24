NB.
NB. functions to play around with orthogonal polynomials
NB.


initCheby =: 3 : 0

NB. Initialize array used to compute Chebyshev polynomials on a specified grid of x-values
NB.
NB. Y - N - number of points to use for grid
NB.
NB. returns first two Chebyshev polynomials - T0(x)=1, T1(x)=x on grid of N x-values from _1 to 1
NB.
 
(y # 1) ,: steps _1, 1, (y - 1)
)

iterCheby =: 3 : 0

NB. Y - N x M array 
NB.
NB.     N - number of Chebyshev polynomials already computed - where row i is Ti(xj) (xj are row 1)
NB.     M - number of x-grid values
NB.
NB.     compute next Chebyshev polynomials and return Y with new polynomial added - e.g (N + 1) x M array 
NB.


(] , _2&{ -~ 2&[ * 1&{ * _1&{) y  
)

iterChebyPoly =: 3 : 0

NB. given array with coefficients for Chebyshev polynomials - line n has coefficients for Chebyshev polynomial n
NB. needs to have at least two rows 
NB.
NB. adds line for next Chebyshev polynomial
NB.
NB. Tn+1(x) = 2*x*Tn(x) - Tn-1(x)
NB.


(] , ([: 2&* (0 1)&[ multPoly _1&{) - _2&{ , 0&[) y 
)

initLeg =: 3 : 0

NB. Initialize array used to compute Legendre polynomials on a specified grid of x-values
NB.
NB. Y - N - number of points to use for grid
NB.
NB. returns first two Legendre polynomials - P0(x) = 1, P1(x) = 1 on grid of N x-values from _1 to 1
NB.

(y # 1) ,: steps _1, 1, (y-1)
)

iterLeg =: 3 : 0

NB. Add row to existing NxM array with Legendre polynomial values at set of M values on [_1,1]
NB.
NB. Y - NxM array
NB.     N - number of Legendre polynomials already computed - where row i is Pi(xj) - xj are also row 1
NB.     M - number of x grid values
NB.

n =. _1&+ # y 

(] , [: (n+1)&db n&*@:(_2&{) -~ [: (1 + 2&* n)&* 1&{ * _1&{) y
)

simpleTrapRule =: 3 : 0

NB. compute integral of function using trapezoidal rule
NB.
NB. int f(x) ~ (deltaX / 2) * ( f(x0) + 2*f(x1) + ...... + 2*f(xn-1) + f(xn) )
NB.
NB. Y - xi ,: yi
NB.

X =. 0&{ y
Y =. 1&{ y 

NB. assume that the X are evenly spaced 

dx =. (1&{ - 0&{) X   

dx&* +/ (0.5&*@:({. + {:) , }.@:}:) Y 
)

simpleTrapRuleDyad =: 4 : 0

simpleTrapRule x ,: y
)

simpleLegExp =: 3 : 0

NB. given function specified by {xi} ,. {yi} and N 
NB.
NB. return coefficients An for an approximation to specified function in Legendre polynomials = sum An Pn({xi}) for n=0..N
NB.
NB. Note - {xi} assumed to be (_1 ... 1) - in future need to handle general cases 
NB.
NB. X - N - defaults to 100
NB. Y - ({xi} ,: f({xi}))
NB.
NB. first generate first N+1 Legendre polynomials on {xi} 

20 simpleLegExp y

:

NB. first set up array with Legendre polynomials

nx =. 1&{ $ y 

legs =. iterLeg^:(x - 2) initLeg nx

legs_coeff =. (] * 2&[ %~ [: 1&+ [: 2&* i.@:#) (0&{ y)&simpleTrapRuleDyad"1 (1&{ y) *"1 legs

legs_coeff ,. legs   
)


simpleInvert =: 3 : 0

NB.
NB. Simple matrix inversion - only works for square matrices
NB.
NB. Y - NxN matrix
NB.

minors =. 1 |:\."2^:2 ]
det    =. -/ .*
adjoint=. [: |: */~@($&1 _1)@# * det@minors
(adjoint % det) y
)

multPoly =: (+//.)@:(*/)

estZeroes =: 3 : 0

NB. Simple Numerical Estimation of Zeroes of Function
NB.
NB. Y - (x ,. y) - Nx2 array - first column is x values and second column is y values
NB.
NB. Strategy - step through y values and find location where sign changes
NB.          - for each sign change, do linear interpolation to find location of zero
NB.          - the more granular the the (x,y) values, the more accurate our zeroes should be
NB.

NB. get list of points where sign changes occur

signChanges =. I. ([: 2&(~:/\) [: (] , {:) [: * 1&{"1) y 

NB. list of points around each sign change 

signChanges =. y {~ , signChanges ,. 1&+ signChanges 

NB. simple function - given points on either side of sign change, do linear interpolation and return estimated zero 
NB. x - first / left point, y - second / right point
NB.
NB. zero ~ xl + (0 - yl) * (xr - xl) / (yr - yl)
NB.

linearEstFun =. {{ ({. x) + ( 0&- {: x ) * ( {. % {: ) y - x }}

_2 (linearEstFun/\) signChanges 
)

dividePoly =: 4 : 0

NB. x - numerator
NB. y - denominator
NB. 
NB. divide two polynomials - return result - (x % y)  d + remainder 
NB.

degD =. # y
leadDen =. {: y 

degN =. # x

currNum =. x

currNumD =. # currNum 

res =. 0 $ 0 

while. currNumD >: degD do.

  resCoeff =. ({: currNum) % leadDen
  resDeg =. currNumD - degD

  res =. res , resCoeff  

  currNum =. }: currNum - resCoeff * (resDeg # 0) , y 

  currNumD =. $ currNum 

end. 

(|. res) ; currNum 
) 


arrToPolyXY =: {{)d

NB. given NxN array with coefficients of x^n * y^m for a polynomial in x + y
NB. and a grid of x - y values
NB.
NB. compute polynomial on all of the gridpoints
NB.
NB. x - xvalues ; yvalues
NB. y - NxN array with polynomial coefficients
NB. 

'xv yv' =. x 

N =. # y 

maxPow =. N - 1 

xPow =. xv ^"(_ 0) i. N
yPow =. yv ^"(_ 0) i. N

arrSel =. (N # i. N) ,. (N^2) $ i. N

nx =. # xv
ny =. # yv

arrRes =. (nx, ny) $ 0 

for_iSel. i. # arrSel do.

  arrRes =. arrRes + (y {~ < iSel { arrSel) * (xPow {~ iSel { 0&{"1 arrSel) */ (yPow {~ iSel { 1&{"1 arrSel) 

end.

arrRes
}}
