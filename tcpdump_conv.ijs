coclass 'tcpconv' 

NB. simple class to help processing parsed tcpdump files 

create =: 3 : 0

	tcpdump =: ''

	servList =: 0 $ ''	
	convList =: 0 $ ''
	servType =: 0 $ ''
	
	servHist =: 0 3 $ 0
	convHist =: 0 3 $ 0
	servTypeHist =: 0 3 $ 0 0 

	NB. lenMS =: 0 $ 0

       1
)

destroy =: codestroy 

load =: 3 : 0 

	tcpdump =: '|' readdsv y

	servList =: /:~ ~. 9&{"1 tcpdump
	convList =: /:~ ~. 12&{"1 tcpdump 
	servTypeList =: /:~ ~. 11&{"1 tcpdump 

	servHist =: ((_1&}."1)@:] ,. >@:(0&{"1) { _1&{"1) servList ,.~ <"0 (1 sh_base_ servList&i. 9&{"1 tcpdump)
	convHist =: ((_1&}."1)@:] ,. >@:(0&{"1) { _1&{"1) convList ,.~ <"0 (1 sh_base_ convList&i. 12&{"1 tcpdump)
	servTypeHist =: ((_1&}."1)@:] ,. >@:(0&{"1) { _1&{"1) servTypeList ,.~  <"0 (1 sh_base_ servTypeList&i. 11&{"1 tcpdump) 

	NB. lenRaw =.  (0&". > (0 6 2 3 7 5)&{"(_ 1) tcpdump)

	NB. lenMS =: <. 0.5&+ 1000&* ( ( (2 3)&tos_base_ - (0 1)&tos_base_ ) + [: 86400&* [: -/"1 (3 1)&{"(_ 1) )  lenRaw 
	
	lenMS =: 0&". > 8&{"1 tcpdump 
	startSec =: +/"1 (86400 1)&*"(_ 1) 0&". > (0 6)&{"(_ 1)  tcpdump 
	endSec =: +/"1 (86400 1)&*"(_ 1) 0&". > (3 7)&{"(_ 1) tcpdump 

	startSecD =: 0&". > 6&{"1 tcpdump 
	endSecD =: 0&". > 7&{"1 tcpdump 
	
	startDT =: (0&". > 0&{"1 tcpdump) + startSecD % 86400
	
1
)


selServ =: 3 : 0 

NB. return selection vector for specified server 

(< y)&= 9&{"1 tcpdump 
)

selServType =: 3 : 0 

(< y)&= 11&{"1 tcpdump
)


selConv =: 3 : 0 

(< y)&= 12&{"1 tcpdump
)


selCol =: 3 : 0 

0&". > y&{"1 tcpdump 

) 

selDate =: 3 : 0 

y = 0&". > 0&{"1 tcpdump 
)

sptype =: 3 : 0 

NB. simple stacked plot of server type counts per specified bucket: x - bucket size in seconds 

300 sptype y 

:

servTypeIndex =. - y 

numDays =. # ~. 0&{"1 tcpdump   NB. total number of days 
numBuckets =. numDays * 86400 % x 

selMat =. selServType@> servTypeIndex&{. _1&{"1 servTypeHist

(y # ,: (86400%x)&db_base_ i.(numDays * 86400 % x)) ; +/\ selMat ([: 1&{"1 (numDays*86400%x)&th_base_ )@# round_base_@(x&db_base_) startSec
)

coclass 'base'
