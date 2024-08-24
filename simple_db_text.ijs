coclass 'simpleDBText'

NB. define behavior for simple text blob class

display =: {{)v

NB. display data for a record
NB.
NB. Y - record - type ; data
NB.

> {: y 

}}

set =: {{)v

NB. convert raw data into internal format
NB.
NB. Y - raw data (in this case text)
NB.
NB. returns "internal format - in this case simply box the text 

< y



}}

coclass 'base'  