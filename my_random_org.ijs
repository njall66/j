NB.
NB. Functions to download random numbers from www.random.org
NB.
NB. Account information:
NB. API Key Name   - sublimator
NB. API Key        - f0bca0bb-a884-44d7-acd0-dde6d3e8b918
NB. Hashed API Key - OtlgVLSIBqlPc/2Dsh4WalHvMqwl1ht9iDA8xx97ABVLir7qbXcVVI2FVhVTznqdtSIZg0TlIunzDgMweLowCA==
NB.
NB. Limits - 1000 requests per day
NB.        - 250000 bits per day    (unclear how this works with requests - does it limit us to 250000 % 7 ~ 35000 bytes per day
NB.

NB. Example request to get set of integers:
NB.
NB. {
NB.     "jsonrpc": "2.0",
NB.     "method": "generateIntegers",
NB.     "params": {
NB.         "apiKey": "6b1e65b9-4186-45c2-8981-b77a9842c4f0",
NB.         "n": 6,
NB.         "min": 1,
NB.         "max": 6,
NB.         "replacement": true
NB.     },
NB.     "id": 42
NB. }

NB. Example request to get my current usage:
NB. 
NB. {
NB.     "jsonrpc": "2.0",
NB.     "method": "getUsage",
NB.     "params": {
NB.         "apiKey": "00000000-0000-0000-0000-000000000000"
NB.     },
NB.     "id": 15998
NB. }



ranorgSendReq =: {{)v

'' ranordSendReq y 

:

NB. send request to random.org
NB.
NB. x - function name
NB. y - parameters - Nx2 boxed array
NB.
NB. returns result of call
NB.

postData =. '-s -H "Content-Type: application/json " -d ' , dquote (' ';~10&{a.)&src enc_pjson_ ('jsonrpc';'2.0') , ('method';x) , ('params'; < ('apiKey';'f0bca0bb-a884-44d7-acd0-dde6d3e8b918') , y) , ,: ('id';42) 

postData gethttp 'https://api.random.org/json-rpc/4/invoke'
}}

ranorgGetUsage =: {{)v

'getUsage' ranorgSendReq 0 2 $ a: 

}}

ranorgGenerateIntegers =: {{)v

NB. get specified number of integers (default 100) in specified range (default 0 - 99)
NB.
NB. y - number, min, max
NB.
NB. see above - params - n,min,max,replacement (binary)
NB.

n =. > 0&{ :: 100&[ y
minRange =. > 1&{ :: 0: y
maxRange =. > 2&{ :: 99&[ y 

params =. ('n' ; n) , ('min' ; minRange) ,: ('max' ; maxRange) 

'generateIntegers' ranorgSendReq params 
}}