NB.
NB. Functions to process source files, pull out functions + comments + code, adverbs, and nouns
NB.

NB. Given name of source file, read in file, drop all the character 13's, break on character 10, parse each line into j-tokens, drop empty lines 

parseFile =: [: (] #~ a:&[ ~: ]) [: (<@:;:);._1 (10&{a.)&[ , (13&{a.)&[ -.~ fread

NB.
NB. classify line:
NB. - comment - starts w. NB.
NB. - start definition - verb
NB. - start definition - adverb
NB. - start definition - noun
NB. - one line definition - verb - e.g. {{ }} 
NB. - define a name (could be noun or verb)
NB.

classifyLine =: 3 : 0

NB. given a boxed set of boxed j tokens - classify the line 
NB.
NB. (.*)(=.|=:)(0|1|3|4):0 - start a multiline definition - 1-adverb, 3+4 - verb, 0 - noun
NB.
NB. Y - line to classify
NB.
NB. return - classification of line
NB.

defVerbM =. ;: '=: 3 : 0'
defVerbD =. ;: '=: 4 : 0'
defNoun =. ;: '=: 0 : 0'
defAdv =. ;: '=: 1 : 0'
defEnd =. ;: ')' 

tail =. }. y 
head =. > {. y 

if. (tail -: defVerbM) do. 
 res =. 1
elseif. tail -: defVerbD do.
 res =. 2
elseif. tail -: defAdv do.
 res =. 3
elseif. tail -: defNoun do.
 res =. 4 
elseif. y -: defEnd do.
 res =. _1
elseif. 'NB.' -: 3&{. ,/ > y do.
 res =. 99
else.
 res =. 0
end.

res
)

parseList =: 3 : 0

NB. Given set of parsed lines from parseFile
NB.
NB. step through lines, classify them, and build list of functions with comments and code
NB.

inDef =. 0 
currFunName =. ''
currFunBody =. 0 0 $ ''
currFunComm =. 0 0 $ '' 

funSet =. 0 $ a: 

for_currLineBoxed. y do.

  currLine =. > currLineBoxed

  defCode =. classifyLine currLine

  if. defCode = 0 do.

    if. inDef do.
      currFunBody =. currFunBody , < ; ;  ' '&(,~) each currLine
    end.

  elseif. defCode = 99 do.

    if. inDef = 1 do.
      currFunComm =. currFunComm , currLine
    end.

  elseif. defCode = _1 do.

    if. inDef = 1 do.
      funSet =. funSet , < currFunName ; (currFunComm) ; (,. currFunBody)
      currFunName =. ''
      currFunComm =. 0 $ a:
      currFunBody =. 0 $ a:
      inDef =. 0
      
    end.

  elseif. (defCode > 0) *. (defCode < 5) do.

    inDef =. 1 
    currFunName =. > {. currLine
    currFunBody =. ,: < ; ;  ' '&(,~) each currLine

  end. 

end.

funSet
)