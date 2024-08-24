NB.
NB. My simple string utilities
NB.

doc_general_string_utilities =: 0 4 $ a:

addDoc =: {{ doc_general_string_utilities =: doc_general_string_utilities , ( ({. , (<@:([: (] ;._1) (10&{a.)&, )@:>@:(1&{)) , {: ) y ) , <'general_string_utilities.ijs' }}


NB. stupid string functions

isLeadChar =: #@:[ > [ i. {.@:] 
isLeadDigit =: '0123456789'&isLeadChar 

addDoc 'isLeadChar' ; 'Return 1 if first character of y is in set x.' ; '#string #info'
addDoc 'isLeadDigit' ; 'Return 1 if first character of string y is a digit';'#string #info'

trimE =: (] ` ([: $: }:) @. (' '&=@:({:!.'-')) ) 
trimB =: (] ` ([: $: }.) @. (' '&=@:({.!.'-')) )

addDoc 'trimE' ; 'Remove trailing blanks - use standard library function dtb instead.' ; '#string #deprecate'
addDoc 'trimB' ; 'Remove leading blanks - probably not efficient, but works';'#string'

src =: {{)d

NB. x - char to replace ; new character
NB. y - string

'oc nc' =. x 

nc (I. oc&= y) } y 
}}

addDoc 'src' ; {{)n
Simple character replace.
  X - current_characater ; replacement_characater
  Y - string
Replace occurrences of current_characater with replacement_character.
}} ; '#string'

NB. convert list to string and insert specified character between each list item 

iv =: 4 : '( dropSpaces@[ , [: x&, ])/ ( ]`,:) @. (1&[ = #@:$) ":"0 y' 

ivr =: {{ ( [ , [: x&, ])/ ":"0 y }} 

addDoc 'iv' ; 'Join array y inserting character x between elements and drop spaces' ; '#string #convert'
addDoc 'ivr' ; 'Join array y inserting character x between elements' ; '#string #convert'

