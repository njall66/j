coclass 'todo'

create =: 3 : 0

NB. initialize the list of todo's 

t =: 1000 7 $ a: 

ni =: 0 

1
)

nt =: 3 : 0

NB. add a task to the list in boxed list t 
NB. y - specification for the new task
NB.     date ; category ; action ; notes ; priority ; links

NB. convert date to internal format

int_date =: {. y 

t =: (ni;y) ni } t 

ni =: ni + 1

)

dt =: 3 : 0

NB. delete a task
NB.
NB. x - override - if 1 allow delete of incomplete tasks (default 0) 
NB. y - task identifier

0
)

sts =: 3 : 0

NB. set status of to do item
NB.
NB. y - task identifier 

0
)

convert_date =: 3 : 0

NB. convert box containing a date in one of the following formats to an internal date
NB.
NB. y - boxed date
NB.
NB. formats: YYYY MM DD, t, t+/-N, w+/-N, m+/-N
NB.

NB. figure out data type of specified date 

input_val =. > y 

input_type =. datatype input_val

if. (input_type = 'integer') +. (input_type = 'float') do.

  NB. we were given either set of floating points or integers 

  input_len =. # input_type

  out_date =. todayno input_val 

elseif. (input_type = 'literal') do.

  NB. given a string
  NB. now need to see if of form (t/w/m)+N or date in form of year, month, date in some combination



end. 

)

destroy=: codestroy

coclass 'base'


NB. What do I want in a simple to do list manager
NB.
NB. Common actions need to be simple
NB. - adding to do item
NB. - modifying
NB. - marking action as done
NB.
NB. Important features
NB. - task groups
NB. - projects - aren't these really just task groups with a name
NB. - 
NB. 
NB. Views - what should be standard
NB. - tasks due on or before date X
NB. - tasks due on or before today (really just need good way to specify dates ?)
NB. - 