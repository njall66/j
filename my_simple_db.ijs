coclass 'simpleDB1'

NB. very simple database - kind of like a document 
NB.
NB. Structure of record:
NB.
NB.    type ; data
NB.
NB. type - determines how the record "behaves" - how to display, etc.
NB.
NB. structure of "database" - Nx2 boxed array - (type column ,. record data column) - where both are boxed 
NB.

create =: {{)v

NB. initialize the database

DB =: 0 2 $ a:
NUM =: 0

INDEX_TYPE =: 0 $ 0 
TYPE_SEL =: 0 0 $ 0 
TYPE_LIST =: 0 $ 0 

''
}}

addRecord =: {{)v

NB. add a record
NB.
NB. add type;data to DB array
NB. increment number of records
NB.
NB. Y - type ; data 

NB. add in validation 

currType =. {. y

currTypeCat =. TYPE_LIST i. currType 

if. currTypeCat = # TYPE_LIST do.

  TYPE_LIST =: TYPE_LIST , currType

  TYPE_SEL =: TYPE_SEL ,. 0 

end. 

INDEX_TYPE =: INDEX_TYPE , currTypeCat 

currTypeCount =. currTypeCat { {. TYPE_SEL

if. currTypeCount = # TYPE_SEL do.

  TYPE_SEL =: (] , (20&[ , {:@:$) $ 0&[) TYPE_SEL  

end. 

currTypeCount =. currTypeCount + 1 

TYPE_SEL =: (NUM , currTypeCount) ((currTypeCount , currTypeCat) ; (0 , currTypeCat) ) } TYPE_SEL

DB =: DB , y

NUM =: NUM + 1

NUM

}}

dispRecord =: {{)v

NB. display record number Y

currRecNum =. ". y 

if. (currRecNum >: - NUM) *. (currRecNum < NUM) do.

    currRecord =. currRecNum { DB 

    recordType =. {. currRecord

    display__recordType {: currRecord

else.

    ''

end. 

}}


coclass 'base'

