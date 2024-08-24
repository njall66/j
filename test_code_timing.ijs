NB.
NB. Timing Tests - what code is actually efficient ???
NB.

timeSentence =: (7!:2) 

NB. 
NB. =====================================================================
NB.
NB. String Concatenation
NB.

NB. keep adding 1 character to strings of different lengths 

timeConcatCharToN =: {{ ($ xx =. y # 'x') ; x&timeSentence 'xxx =. xx , ''a''' }}

concatOneChar =: ] , [ 

1000 timeSentence 'currString =: currString , newChar' 