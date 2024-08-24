NB.
NB. Play around with functions to generate random numbers with various distributions
NB.

knuthPoisson =: 3 : 0

(0.1 1) knuthPoisson y 

:

NB. use simple Knuth Algorithm to generate a set of Poisson distributed random numbers
NB.
NB. r - rate for events
NB. t - time window
NB.
NB. poisson distribution - p(k events in time t) =  (rt)^k * e^(-rt) / k!
NB.
NB. X = r t - defaults 0.1 1
NB. Y = number of random numbers to generate

r =. 0&{ :: 0.1&[ x
t =. 1&{ :: 1&[ x

n =. y

ll =. ^ - r * t

mrp =: [: (1: `] @. (ll&[ < ])) [ * ] 

_1&+ 2 -~/\ I. 1&= 1 ] F:. mrp 100000&(%~) ? y # 100000
) 
