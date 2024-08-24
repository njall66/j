NB.
NB. can I build a simple json parser
NB.



parseJson =: 3 : 0

'' parseJson y 

:

NB. simple JSON parser
NB.
NB.

inObject =. 0
inString =. 0
inKeyName =. 0
inKey =. 0
inValue =. 0
currObj =. _1
numObj =. 0 

objList =. 0 $ a:

for_c. y do.

  if. inString do.

    if. c = '"' do.

      inString =. 0

    else.

      rawString =. rawString , c

    end. 

  elseif. inValue do.

  elseif. inKeyName do.

  

  elseif. inKey do.

  elseif. inObj do.

    if. c = '"' do.

      inKey =. 1
      inKeyName =. 1
      inString =. 1

    end. 

  else.

    if. c = '{' do.

      inObj =. 1
      numObj =. numObj + 1
      currObj =. currObj + 1

      rawObj =. a:

    end.

  end. 


end. 


)