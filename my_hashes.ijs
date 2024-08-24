NB.
NB. play around with some toy hash functions
NB. mainly trying to get insight into how some simple cases work
NB.

NB. Set of functions to work with tabulation hashing and mixed / multi tabulation hashing

initTableHash =: 3 : 0

NB. initialize table for "tabulation hashing"
NB.
NB. Y - (bits in block size) , (max key bits) , (target bits for final hash)
NB.

'bitsBS bitsMaxKey bitsHash' =. y

ncol =. 2 ^ bitsBS
nrow =. >. bitsMaxKey % bitsBS
maxElem =. 2^bitsHash

? (nrow , ncol) $ maxElem
)

tabulationHash =: 4 : 0

NB. do a simple tabulation hash
NB.
NB. X - table - created with initTableHealth
NB.
NB. Y - key to hash - should be a string 
NB.
NB. Given the key and the table, we can figure out the block size one of two ways:
NB.
NB. (bits in key - 8 * key length ) % (number of rows in table X)
NB.
NB. log2 number of columns in table X    ---- use this one - this allows us to use keys shorter than the maximum   
NB.

bitsBS =. 2 ^. {: $ x 

NB. get key in binary - need to make sure that we have 8 bits per character and prevent truncation of leading 0's 

keyBinary =. ,/ _8&{."1 (0 0 0 0 0 0 0 0)&,"(_ 1) #: a. i. y

tableSelector =. (- bitsBS) #.\ keyBinary 

xor =. 22 b. 

NB. bitsBS ; keyBinary 
xor / tableSelector {"(0 1) x 
)


foldingHash =: 3 : 0
NB. 
NB. simple hash
NB.
NB. X - # bits in the hash 
NB.
NB. Y - key
NB.
NB. 

1
)

NB. 
NB. help function for treating list as coefficients in power series for a number
NB.
NB.

long_carry =:  3 : 0

NB.
NB. X - base - default 10 
NB. Y - one dimensional array of length n - specifies a number sum (y0 * base^(n-1) + y1 * base^(n-2) + ......) 
NB. 


10 long_carry y

:

([: |. 0&( (x&|) F:: (<.@:(x&(%~))@:] + [) )) y
)

NB. wrapper for built-in SHA256, CRC32, 32 bit checksum 

sha256 =: 3&(128!:6)
crc32 =: 128!:3
check32 =: 128!:8


