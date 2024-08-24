NB.
NB. play around with different sequences
NB.

NB.
NB. Fibonacci - almost feel stupid writing function for this
NB.

seqFibRecur =: (] , {: + _2&{)

NB.
NB. seqRecurLucas - Lucas sequence
NB.
NB. an = an-1 + an-2 with a0=1, a1=3     - same recurrence as fibonacci, but different starting point
NB.

seqLucasRecur =: (] , [: +/ _2&{.)

NB. Farey Sequence iteration
NB.

iterFarey =: 3 : 0

NB. Given Farey sequence Fn stored as rational numbers - compute Fn+1
NB.
NB. - start with elements of Fn - then add new elements between existing
NB. - take existing elements as (a % b) , (c % d)
NB. - then new element is (a + c) % (b + d)
NB.
NB. Y - nx2 array - each row is a member of the sequence - (numerator, denominator)
NB.
NB. - initial array should be (0 1) ,: (1 1) 

({. , [: ,/ 2&(( + ,: ] )/\) ) y
)

iterCollatz =: 3 : 0

NB. Collatz sequence iteration - designed to be used as "v" in unlimited fold - F:
NB.
NB. y - last sequence entry
NB.
NB. return next term in Collatz sequence
NB.
NB.   y - even => y % 2
NB.   y - odd  => 1 + 3 * y
NB.

(2&(%~)) ` (1&[ + 3&*) @. (2&|) y
)

seqCalkinWilfRecur =: 3 : 0

NB. Calikin - Wilf Tree and Stern Diatomic Series
NB.
NB. each node (a/b) has children a/(a+b) and (a+b)/b
NB.
NB. Y - list of nodes - breadth first traversal of full tree
NB.
NB. Initial rows - (1/1) , (1/2) (2/1), (1/3) (3/2) (2/3) (3/1) ...
NB.
NB. Len of each row - 1, 2, 4 , 8, .....
NB.
NB. Length of breadth first traversal as function of number of rows - 1, 3, 7, 15, 31 .....
NB.
NB. Formula for length of breadth first traversal = 2^N-1
NB.
NB. Therefore given breadth first traversal - number of rows is log2( length + 1)
NB. and last row is last (length + 1) / 2 elements
NB.
NB. Y - N x 2 array - holding numerators and denominators of nodes in Calkin Wilf tree 
NB.
NB. return: Y with next row of Calkin Wilf tree appended 

NB. compute the number of elements in the last row of the Calkin Wilf tree

nlast =. - 2&(%~) 1&+ # y 

(] , [: ,/@:( (({. , +/) ,: {: ,~ +/)"1) nlast&{.) y
)


NB. Convert fractional part of decimal number to other bases

fractToBaseIter =: 3 : 0

NB. iterator to help convert fractional part of number to specified base with specified number of digits (aka precision) 
NB.
NB. X - (base , precision) - default 2 
NB. Y - number to convert

NB.
NB. Computes X * fractional part of Y
NB.
NB. returns (X * fractional part of Y) , (}. Y) , (floor of X * fractional part of Y)
NB.
NB. - effectively adds digit to base X expansion of a fraction
NB.
NB. Compute N digits in base X expansion of Y:
NB.
NB.    }. X&fractToBaseIter^: N Y 

2 fractToBaseIter y

:

x ( ] (] , }.@:[ , <.@:]) [ * 1&|@:{.@:]) (] ` ,: @. (0&=@:#@:$)) y 
)

decToBase =: 3 : 0

NB. Convert number Y to base ({. X) using ({: X) digits of precision for fractional part
NB.
NB. X - (base , precision for fractional part) - default (2 5)
NB. Y - number to convert from decimal
NB.
NB. returns: (base , precision for fractional part , digits for integral part of Y in base {. X , digits for fractional part of Y )
NB.

(2 10) decToBase y 

:

NB. split input number into integer and fractional parts

intPart =. <. y
fracPart =. 1 | y

targBase =. {. x
decPrec =. {: x

debugme =: intPart , fracPart , targBase , decPrec 

intRes =. targBase #.^:_1 intPart
fracRes =. }. (targBase&fractToBaseIter^: decPrec) ` ([: decPrec&# 0&[) @. (0&=) fracPart

targBase , decPrec , intRes , fracRes 
)
 

baseToDec =: 3 : 0

NB. inverse function for decToBase
NB.
NB. given base, fractional part precision, and digits in the specified base - convert to decimal
NB.
NB. Y - (base, fractional part precision, digits - at least precision + 1)
NB.

baseInit =. {. y
fracPrec =. _1&* 1&{ y

NB. convert integral part to decimal

intRes =. baseInit #. fracPrec&}. 2&}. y 

fracRes =. (baseInit ^ - fracPrec) %~ baseInit #. fracPrec&{. y 

intRes + fracRes 
)

simpleCantor =: 3 : 0

NB. Simple and likely inefficient implementation of Cantor function
NB.
NB. X - precision - e.g. number of ternary digits to use - default = 20 
NB. Y - number in [0,1]
NB.
NB. Computes Cantor function:
NB. - convert y to ternary - x digits of precision 
NB. - find first 1 - if any - set all digits after first y to 0
NB. - convert all 2's to 1's
NB. - interpret as binary and convert back to decimal
NB.

20 simpleCantor y

:

NB. convert to Ternary - dump integral part of y to avoid problems later on 

ternY =. 2&}. (3, x) decToBase 1&| y

NB. length of ternY should be x+1 - integral part (which is 0) and fractional part 

lenTernY =. # ternY  

firstOne =. 1&+ ternY i. 1 

if. firstOne < lenTernY do.

  lenTernY =. firstOne

  ternY =. lenTernY {. ternY

end.

NB. convert 2's to 1's and convert from binary to decimal 

baseToDec 2 , (lenTernY - 1) , (] - 2&=) ternY 
)


totFun =: 3 : 0

NB. compute totient function
NB.
NB. phi(n) = number of positive integers less than n that are relatively prime to n
NB.
NB. phi(n) = n * PI (1-1/p) for all p that divide n  (in other words the unique prime factors of n > 1) 
NB.
NB. Compute prime factors of each element of y, take nub, compute phi(n) using formula above - do in rationals to avoid roundoff issues 

( ] * [: */ (1r1&[ - 1r1&[ % ])@:~.@:q:)"0 y
)

relPrime =: 3 : 0

NB. Given integer N and max M, return all integers relatively prime to N less than M
NB.
NB. X - max relatively prime integer to N (defaults to y) 
NB.
NB. Y - N

y relPrime y

:

NB. get prime factors of target integer

primeFact =. ~. q: y

NB. sieve out all multiples of prime factors of y from integers 1..x

resSeq =. 2 + i. x - 1

for_ip. primeFact do.

  resSeq =. resSeq -. ip * 1&+ i. <. x % ip 

end. 

resSeq
)

fordCircle =: 3 : 0

NB. given two integers - return points for Ford Circle:
NB.
NB. Integers - (h, k)
NB.
NB. Center - (h/k, +/- 1 / 2k^2)
NB. Radius - 1 / 2 k^2
NB.
NB. use simpleCircle function to generate circles
NB.
NB. For start - just return circles centered above x-axis -- y > 0 
NB.
NB. x - number of points in circle - defaults to 100
NB. y - (h, k) - assumed to be relatively prime 

100 fordCircle y 

:

h =. 0&{ :: 2: y
k =. 1&{ :: 3: y

simpleCircle x , (h % k) , 2 # (% +: *: k)  
)

seqSF =: 3 : 0

NB. Compute sequence of square free integers <= N
NB.
NB. X - power (default 2) 
NB.
NB. Y - N
NB.

2 seqSF y

:

maxPrime =. <. %: y 

numPrimes =. _1 p: maxPrime + 1

primeSquares =. *: p: i. numPrimes

numFact =. <. y % primeSquares 

(1 + i.y) -. , (] * [: 1&+@:i."0 <.@:(y&%)) primeSquares 
)


generateSequenceFoldM =: {{)a

maxIter =. x 

toIterator =. {{)a

_2 Z: x < {. y
_3 Z: x + 10

(>:@:{. , }.@:u) y
}}


maxIter ] F: (u toIterator) 0 , y 
}}

generateSequenceFoldS =: {{)a

maxIter =. x 

toIterator =. {{)a

_2 Z: x < {. y
_3 Z: x + 10

(>:@:{. , }.@:u) y
}}


maxIter ] F. (u toIterator) 0 , y 
}}

NB. Hilbert curve stuff 
NB.
NB. hilbert - takes a starting / initial value of (0j0) 

hilbert =: 0.5&*@( (_1j_1&+)@:(0j1&*)@:+ , _1j1&+ , 1j1&+ , [: 1j_1&- 0j1&*@:+ ) 

hilbertNC =: ( (_1j_1&+)@:(0j1&*)@:+ , _1j1&+ , 1j1&+ , [: 1j_1&- 0j1&*@:+ ) 

hilbertI =: 3 : 0

NB. Iterator for Hilbert Curve
NB.
NB. y - current curve as set of complex numbers
NB.
NB. initialize using starting value of (0j0) or just 0 

inArr =. ( (,:)`(]) @. (2&[ = #@:$) ) +. y

'xmin ymin xmax ymax' =. (min , max) inArr

dx =. xmax - xmin
dy =. ymax - ymin

( ( [: + (0j_1)&* - (ymin j. xmin)&[ ) , ( (-xmin) j. dy + 1 - ymin )&+ , ( (dx + 1 - xmin) j. dy + 1 - ymin )&+ , ( [: |. (0j1)&* + ( (1 + 2 * dy) j. 0 )&[ ) ) y 
)

NB.
NB. Space filling trees 
NB.

hilbertTFI =: {{)d

NB. use Hilbert curve to map an integer  - see if the sequence is interesting in any way
NB.
NB. x - hilbert curve points - length N = n^2 - represeented as an Nx2 array (although could be any curve 
NB. y - current position in the curve (integer from 0 .. N-1)
NB.
NB. Compute next position:
NB.
NB. y ==> +/ ( n , 1 ) * (y { x) 
NB.
NB. Essentially takes y as position along the (presumably Hilbert) curve
NB.
NB. - of course this doesn't work - I am being really stupid about something :( 

n =. %: # x

+/ ( n , 1 ) * y { x 
}}

squareSpaceFillTree =: {{)v

  NB. Simple "square" space filling tree
  NB.
  NB. Start with single point at (1/2, 1/2) 
  NB.
  NB. Iteration N - add vertex points around each point from prior iteration - (1 / 2^(N+1)) * (+/ 1 , +/1)
  NB.             - add edge from each new vertex point to central vertex point
  NB.
  NB. Y - current set of edges 


}}


NB. Blum Blum Shub - simple, likely inefficient
NB.
NB. x(i+1) = x(i)^2 mod M   where M = p*q where p,q are primes congruent to 3 mod 4
NB.
NB. this only works properly if all parameters are either exact or rational
NB.
NB. X - M
NB. Y - x(i)
bbsIter =: {.@:[ | *:@:x:@:]

bbsInit =: {{)v

NB. generate a Blum integer - p*q where p,q are primes congruent to 3 mod 4
NB.
NB. y - ignored ?
NB.
NB. choose at random from primes 50000000 - 99999999 until we have two that are congruent to 3 mod 4
NB.

res =. (] #~ [: 3&= 4&|) p:  50000000&+ ? 10 # 50000000

if. 2&> # res do. res =. res , (] #~ [: 3&= 4&|) p:  10000000&+ ? 10 # 90000000 end. 

res =. 2&{. res

x: (*/ , ] , [: *./ _1&+) res  
}}

bbsN =: {{)d

NB. compute nth term of BBS iteration
NB.
NB. x - result of bbsInit - (M , p , q , lcm(p-1,q-1))
NB.
NB. y - n , x0 
NB.
NB. return nth term of bbs iteration using formula xn = x0^(2^n mod lcm(p-1,q-1)) mod M
NB.

n =. x: {. y
x0 =. x: {: y 

({. x) | x0^( ({: x) | (x: 2)^n)
}}

weierFun =: {{)v

(200 0 2) weierFun y 

:

NB. simple approximation to Weirstrauss function - continuous everywhere, but differentiable nowhere
NB.
NB. x - (number of points def = 200) , (min - def = 0) , (max - def = 2), 
NB.
NB. y - a , b , nMax
NB.
NB. to get a continuous, but non-differentiable everywhere need ab > 1 + 3 * pi / 2 and b = odd integer
NB.

'numPoints min max' =. x

'a b nMax' =. y 

xp =. steps pi * min, max, numPoints 



}}

iterWeierFun =: {{)d

NB. Iterate Weierstrauss function
NB.
NB. x - a , b
NB.
NB. y - (a^n , b^n * pi * x0 ..... xmax) ,: (_ , sum 0..n cos[ b^n * pi * x0 ..... xmax ] )
NB. 

'a b' =. x

an =. a * 0&{ 0&{ y
xp =. (2*pi)&| b * }. 0&{ y

(an , xp) ,: (an , (}. {: y) + an * cos xp)
}}

initWeierFun =: {{) v

NB. generate initial state for Weierstrauss function iterator
NB.
NB. y - a, b, num x points, minX, maxX
NB.

'a b numPoints minX maxX' =. y 

xp =. pi * steps minX, maxX, numPoints

(1 , xp) ,: (1 , cos xp) 
}}


iterCatMap =: {{)d

NB. Iterate discrete Arnold cat map
NB.
NB. x - N - max for x and y - e.g. all results are taken mod N
NB. y - current point
NB.
NB. returns ( (x + y) mod N ) , (2*x + p) mod N 
NB.

x&| (+/ y) , ({: + 2&[ * {.) y 
}}

iterRan2D =: {{)v

NB. iterate a simple 2-D random walk
NB.
NB. y - current list of points - Nx2 array
NB.
NB. return y with next point in walk appended - (N+1)x2 array - y , nextPoint
NB. 

direction =. (?4) { (_1 0) , (0 1) , (1 0) ,: (0 _1)

NB. direction =. (?8) { (_1 0) , (_1 1) , (0 1) , (1 1) , (1 0) , (1 _1) , (0 _1)  ,: (_1 _1) 

count =. 1 + ? 100 

delta =. +/\ count # ,: direction 

(] , {: +"(_ 1) delta&[ ) y 
}}

iterRan3D =: {{)v

NB. iterate a simple 2-D random walk
NB.
NB. y - current list of points - Nx3 array
NB.
NB. return y with next point in walk appended - (N+1)x3 array - y , nextPoint
NB. 

NB. direction =. (?4) { (_1 0 0) , (1 0 0) , (0 _1 0) , (0 1 0) , (0 0 _1) ,: (0 0 1) 

direction =. (?6) {  (_1 0 0) , (1 0 0) , (0 _1 0) , (0 1 0) , (0 0 _1) ,: (0 0 1) 

(] , direction&[ + {:) y 
}}


iterComma =: {{)v

NB. Given current comma sequence - comput the next term
NB.
NB. Comma sequence - see On Line Encyclopedia of Integer Sequences - https://oeis.org/A121805
NB.
NB. Comma sequence - xn , xn+1
NB.    xn+1 - xn = (10 * least significant digit of xn) + (most significant digit of xn+1)
NB.
NB. If multiple values of xn+1 possible - choose the smallest possible value
NB.

lastTerm =. {: y

if. lastTerm = _ do.

  0 $ 0

  return. 

end. 

NB. lets go really cheesy  and get least significant digit by using mod operator

deltaStart =. 10&* 10&| lastTerm

nextTermDigit =. ". {. ": nextTerm =. lastTerm  + deltaStart

nextTerm =. nextTerm + nextTermDigit

if. -. nextTermDigit = ". {. ": nextTerm do.

  NB. have to try to iterate - not very elegant 

  nextTermDigit =. ". {. ": nextTerm

  nextTerm =. lastTerm + deltaStart + nextTermDigit 

  if. -. nextTermDigit = ". {. ": nextTerm do.

    nextTerm =. _

  end. 

end.

nextTerm 

}}

