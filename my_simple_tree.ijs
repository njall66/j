NB.
NB. Try to implement a simple tree data structure - or at least something that approximates it
NB.

coclass 'simpleTree'

NB. Store tree structure as a set of arrays
NB.
NB. parentChild - N x 2 array - (parent node # , child node #)
NB.
NB.		can have multiple entries for each parent
NB.             can have only one entry for each child
NB.
NB. nodeValue - boxed list of length N - node n value is element n
NB.
NB. y - value for root node 

init =: {{)v

CHUNKSIZE =: 128

numNodes =: 1

parentChild =: (CHUNKSIZE, 2) $ 0 0

nodeValues =: (< y) , (<: CHUNKSIZE) $ a:

currentAllocated =: CHUNKSIZE 

numNodes 
}} 

addNode =: {{)d

NB. add a node to the tree
NB.
NB. x - parent node ID
NB. y - value (will be stored in a box)
NB.
NB. adds a childe node to node # x
NB.
NB. returns ID of new node (_1 on failure) 
NB.

parentNodeID =. x 
newNodeValue =. < y

if. parentNodeID >: numNodes do. _1 return. end. 

if. -. numNodes < currentAllocated do. xx =. allocateChunk '' end. 

newNodeID =. numNodes 

parentChild =: (parentNodeID , newNodeID) numNodes } parentChild

nodeValues =: newNodeValue numNodes } nodeValues 

numNodes =: >: numNodes

}}

allocateChunk =: {{)v

NB. allocate chunkSize additional nodes

parentChild =: parentChild , (chunkSize , 2) $ 0
nodeValues =: nodeValues , chunkSize $ a:

currentAllocated =: currentAllocated + chunkSize 

currentAllocated 
}}




coclass 'base' 