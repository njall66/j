NB. Code for random Euler Problems

NB. Problem 01
NB. sum of multiples of 3 or 5 smaller than 1000 

eul01 =: [: +/ (0: ` ] @. ( 0&=@:(3&|) +. 0&=@:(5&|)) )"0

NB. run: eul01 }. i.1000 

NB. Problem 02
NB. sum even terms of fibonacci series that do not exceed 4000000 

eul02_fibby =: [: (}. ,~ ({. ` ({. + {:) @. ([: 0&= 2&|@:{:)) )  {. , {: , +/@:}.

eul02_fibby_02 =: {{ (}: ` (2&}. ,~ ({. ` ({. + {:) @. ([: 0&= 2&|@:{:)) ) @. ([: x&>: {:) ) (] , +/@:}.) y }}

eul02_fibby_debug =: {{0: ` 1:  @. ([: x&>: {:) ) (] , +/@:}.) y }}

NB. run: 4000000 eul01_fibby_02 0 1 1
NB. call with current sum, fib term N-1, fib term N
NB. returns sum, fib term N, fib term N+1

NB. Problem 03
NB.
NB. 
NB. simple recursive solution - fails for large numbers (even moderately large numbers) due to number of recursive calls 
NB. 
eul03 =: {{ ] ` ([: $: 1&+@:{. , (}. ` (}. , p:@:{.)  @. ([: 0&= p:@:{. | x&[) ) ) @. ([: (x%2)&>: p:@:{.) y }}

NB. simple iterative function - needs to be called with ^:_ - problem is too slow for even moderately larger numbers 

eul03_iter =: {{ ] ` (1&+@:{. , (}. ` (}. , p:@:{.)  @. ([: 0&= p:@:{. | x&[) ) ) @. ([: (x%2)&>: p:@:{.) y }}

NB. Problem 04
NB.
NB. Find largest palindrome number that is the product of two three digit numbers
NB.

NB. helper functions to take an integer and turn it into a palindrom - doubling number of digits 

eul04_makePalinEven =: [: 10&#.@:(] , |.) 10&(#.^:_1)

eul04_makePalinOdd =: [: 10&#.@:(] , [: }. |.) 10&(#.^:_1)

NB. get factorization of each number using the following one liner - columns are # of 3 digit factors, factors
NB. note that row number is index of 3 digit "generating number" in (100 + i.900) (or 100 .... 999) 

eul04_palin5_factors =: ([: (] ,~ +/@:(99&< *. 1000&>))  q:@:eul04_makePalinOdd)"0 (100 + i.900)

eul04_palin6_factors =: ([: (] ,~ +/@:(99&< *. 1000&>))  q:@:eul04_makePalinEven)"0 (100 + i.900)

NB. finally - looking 6 digit palindromes with at least two three digit factors - all of them also have a factor of 11:
NB.
NB. the following one liner shows that all 6 digit palindromes that have 2+ three digit factors also have 11 as a factor
NB.
NB. 11&e."1 (1&<@:{."1 # ])  eul04_palin6_factors
NB.
NB. Following one liner gives list of factors for all 5 digit palindromes that have 2+ three digit factors
NB.
NB. (1&<@:{."1 # ])  eul04_palin5_factors
NB.
NB. the largest of these is:
NB.
NB. 2 283 353   0   0 0 0 0 0 0 0 0 0
NB.
NB. 283 * 353 = 99899
NB.
NB. Above answers are all wrong - key point is that q: gives full prime factorization, whereas we want all factorizations with 2 factors that are both 3 digits
NB. found answer - by manual inspection:  906609 = 993 * 913

NB. Problem 5
NB.
NB. smallest positive integer divisible by all integers 1..20
NB.

eul05 =: {{ */ (p: i. y) ^ max y q: 1&+ i. y }}

NB. run: eul05 20 ===> 232792560

NB. Problem 06
NB.
NB. Difference between the sum of squares of first 100 integers and square of sum of first 100 integers
NB.

eul06 =: ((+/)@:*: -~ *:@:(+/))@:([: 1&+ i.)


NB. Problem 07
NB.
NB. 10001 st prime number
NB.

q: 10000 NB. q: starts prime index at 0

NB. Problem 08
NB.
NB. 13 adjacent digits in a 1000 digit number with largest product - want the product, not the digits
NB.

NB. 7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450

eul08_num =: '7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450'

eul08 =: [: (] {~ /:@:(0&{"1)) 13&(( [: (*/ , ]) "."0)\)

NB. run as: eul08 eul08_num

NB. Problem 09
NB.
NB. find Pythagorean triple where a + b + c = 1000 and return a*b*c
NB.
NB. Manipulate a^2 + b^2 = c^2 and a+b+c = 1000
NB. Then solve for a - returns the formula below in function eul09_ab
NB.
eul09_ab =: (_1000000&[ + 2000&[ * ]) % (_2000&[ + 2&[ * ])

eul09_isint =: (<. -: ]) 

eul09 =: [: ( (isint"0)@:(1&{"1) # ]) (] ,. eul09_ab)

NB. call eul09 i.1000 - only positive, non-zero solutions are 200,375 and 375,200.   This results in c=425  (200 + 375 + 425 = 1000)

NB. Problem 10
NB.
NB. compute sum of primes less than 2000000
NB.
NB. "cheat" and use p: function to get lists of primes and prime right before 2000000
NB.

eul10 =: [: +/@:p:@:i. _1&p:

NB. Problem 11
NB.
NB. given 20 x 20 grid of integers - return max sum of 4 consecutive entries in columns, rows, and diagonals
NB.
NB. First set up array
NB.
eul11_arr =: 20 20 $ ". '08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08 49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00 81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65 52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91 22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80 24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50 32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70 67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21 24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72 21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95 78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92 16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57 86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58 19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40 04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66 88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69 04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36 20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16 20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54 01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48'

eul11 =: max@:( ,@:(4&(*/\)/.)@:(|."1)  , ,@:(4&(*/\)/.) , ,@:(4&(*/\)) , ,@:(4&(*/\)"1) )

NB. call as:  eul11 eul11_arr

NB. Problem 12
NB.
NB. Find first triangular number with over 500 divisors
NB.

NB. first build list of triangular numbers

eul12_triangNums =: +/\ }. i.40000

NB. take list of numbers and return list the numbers with more than 500 divisors
NB.
NB. note - number of divisors = */ exponents for prime factors 

eul12 =: [: (] #~ [: 500&< 1&{"1) (] ,. [: */ [: 1&+ [: 0&(-.~) _&q:)"0 

NB. Problem 13
NB.
NB. Given 100 50 digit numbers - compute first 10 digits of the sum
NB.

eul13_arr =: 100 50 $ '37107287533902102798797998220837590246510135740250463769376774900097126481248969700780504170182605387432498619952474105947423330951305812372661730962991942213363574161572522430563301811072406154908250230675882075393461711719803104210475137780632466768926167069662363382013637841838368417873436172675728112879812849979408065481931592621691275889832738442742289174325203219235894228767964876702721893184745144573600130643909116721685684458871160315327670386486105843025439939619828917593665686757934951621764571418565606295021572231965867550793241933316490635246274190492910143244581382266334794475817892575867718337217661963751590579239728245598838407582035653253593990084026335689488301894586282278288018119938482628201427819413994056758715117009439035398664372827112653829987240784473053190104293586865155060062958648615320752733719591914205172558297169388870771546649911559348760353292171497005693854370070576826684624621495650076471787294438377604532826541087568284431911906346940378552177792951453612327252500029607107508256381565671088525835072145876576172410976447339110607218265236877223636045174237069058518606604482076212098132878607339694128114266041808683061932846081119106155694051268969251934325451728388641918047049293215058642563049483624672216484350762017279180399446930047329563406911573244438690812579451408905770622942919710792820955037687525678773091862540744969844508330393682126183363848253301546861961243487676812975343759465158038628759287849020152168555482871720121925776695478182833757993103614740356856449095527097864797581167263201004368978425535399209318374414978068609844840309812907779179908821879532736447567559084803087086987551392711854517078544161852424320693150332599594068957565367821070749269665376763262354472106979395067965269474259770973916669376304263398708541052684708299085211399427365734116182760315001271653786073615010808570091499395125570281987460043753582903531743471732693212357815498262974255273730794953759765105305946966067683156574377167401875275889028025717332296191766687138199318110487701902712526768027607800301367868099252546340106163286652636270218540497705585629946580636237993140746255962240744869082311749777923654662572469233228109171419143028819710328859780666976089293863828502533340334413065578016127815921815005561868836468420090470230530811728164304876237919698424872550366387845831148769693215490281042402013833512446218144177347063783299490636259666498587618221225225512486764533677201869716985443124195724099139590089523100588229554825530026352078153229679624948164195386821877476085327132285723110424803456124867697064507995236377742425354112916842768655389262050249103265729672370191327572567528565324825826546309220705859652229798860272258331913126375147341994889534765745501184957014548792889848568277260777137214037988797153829820378303147352772158034814451349137322665138134829543829199918180278916522431027392251122869539409579530664052326325380441000596549391598795936352974615218550237130764225512118369380358038858490341698116222072977186158236678424689157993532961922624679571944012690438771072750481023908955235974572318970677254791506150550495392297953090112996751986188088225875314529584099251203829009407770775672113067397083047244838165338735023408456470580773088295917476714036319800818712901187549131054712658197623331044818386269515456334926366572897563400500428462801835170705278318394258821455212272512503275512160354698120058176216521282765275169129689778932238195734329339946437501907836945765883352399886755061649651847751807381688378610915273579297013376217784275219262340194239963916804498399317331273132924185707147349566916674687634660915035914677504995186714302352196288948901024233251169136196266227326746080059154747183079839286853520694694454072476841822524674417161514036427982273348055556214818971426179103425986472045168939894221798260880768528778364618279934631376775430780936333301898264209010848802521674670883215120185883543223812876952786713296124747824645386369930090493103636197638780396218407357239979422340623539380833965132740801111666627891981488087797941876876144230030984490851411606618262936828367647447792391803351109890697907148578694408955299065364044742557608365997664579509666024396409905389607120198219976047599490197230297649139826800329731560371200413779037855660850892521673093931987275027546890690370753941304265231501194809377245048795150954100921645863754710598436791786391670211874924319957006419179697775990283006991536871371193661495281130587638027841075444973307840789923115535562561142322423255033685442488917353448899115014406480203690680639606723221932041495354150312888033953605329934036800697771065056663195481234880673210146739058568557934581403627822703280826165707739483275922328459417065250945123252306082291880205877731971983945018088807242966198081119777158542502016545090413245809786882778948721859617721078384350691861554356628840622574736922845095162084960398013400172393067166682355524525280460972253503534226472524250874054075591789781264330331690'

NB. function - takes NxM string array - with set of numbers to add
NB.
NB.    converts each character to integer - results in NxM integer array
NB.
NB.    sum integer array columns - results in array of length M  
NB.
NB.    reverse order of sum array
NB.    
NB.    append four zeroes - results in one dimensional array of length M 
NB.
NB.    apply fold operation
NB. 

eul13 =: [: |. [: 0&( (10&(|)) F:. ( <.@:(10&(%~))@:] + [) ) [: (0 0 0 0)&(,~) [: |. [: +/ "."0

NB. call:  eul13 eul13_arr

NB. Problem 14
NB.
NB. find longest collatz sequence with starting term under one million
NB.


testFold_u =: 3 : 0

_2 Z: -. * foldCount =: foldCount - 1

y
)

testFold_v =: 2&*

eul14_v =: 3 : 0

NB.
NB. Collatz sequence iteration - designed to be used as "v" in unlimited fold - F:
NB.
NB. y - last sequence entry
NB.
NB. return next term in Collatz sequence
NB.
NB.   y - even => y % 2
NB.   y - odd  => 1 + 3 * y
NB.

(2&(%~)) ` (1&[ + 3&*) @. (2&|) y
)

eul14_u =: 3 : 0

NB.
NB. Collatz sequence control function - designed to be used as a "u" in unlimited fold F:

NB. Prevent endless loop 

_3 Z: 10000  

NB. Terminate when current entry is 1 

_2 Z: 1&= y 

y
)

NB. Problem 16
NB.
NB. Compute sum of digits of 2^1000
NB.
NB. Define function to treat one dimensional array as a number and carry overflow for each column
NB.

eul16_carry =:  [: |. 0&( (10&|) F:: (<.@:(10&(%~))@:] + [) ) 

eul16_iter =: [: eul16_carry 1024&*

NB. compute result

eul16_arr =: 1 ,~ 500 # 0

NB. compute result:  +/ eul16_iter^:100 eul16_arr

NB. Problem 17
NB.
NB. count of letters in numbers 1..1000 written out in words
NB.
NB.

eul17_num_0_19 =: '';'one';'two';'three';'four';'five';'six';'seven';'eight';'nine';'ten';'eleven';'twelve';'thirteen';'fourteen';'fifteen';'sixteen';'seventeen';'eighteen';'nineteen'

eul17_num_20_90 =: '';'ten';'twenty';'thirty';'forty';'fifty';'sixty';'seventy';'eighty';'ninety'

eul17_num_100_1000000000 =: |. 'hundred';'thousand';'ten thousand';'hundred thousand';'million';'ten million';'hundred million';'billion'

eul17_999_to_name =: 3 : 0

NB. take an integer 0 - 100 and spit out the name 

NB. special case - handle zero 

if. y = 0 do.
    'zero' return. 
end. 

NB. get names for two least significant digits - e.g. 0-99

lsd =. 100 | y

if. lsd < 20 do.

    NB. use names for 0 .. 20 

    lsd_name =: > lsd { eul17_num_0_19

else.

    NB. get names for 10^0:

    lsd_0 =. > eul17_num_0_19 {~ 10 | lsd 

    NB. get names for 10^1 (should be 20 +)

    lsd_1 =. > eul17_num_20_90 {~ <. lsd % 10 

    if. lsd_0 -: '' do.

        lsd_name =. lsd_1

    elseif. lsd_1 -: '' do.

        lsd_name =. lsd_0

    else. 

        lsd_name =. lsd_1 , ' ' , lsd_0

    end. 

end. 

NB. if specified number is < 100, then we are done - just return 

if. y < 100 do.

    lsd_name return.

end.

NB. get names for 10^2:  

msd_name =. > eul17_num_0_19 {~ _3&{ 10&(#.^:_1) y  

msd_name =. (] , ' hundred'&[) ` (]) @. (''&-:) msd_name 

debug =: msd_name ; lsd_name 

msd_name ( ([ , [: ' and '&, ]) ` [ @. ([: ''&-: ]) )  lsd_name 
)

NB. solve problem with following:
NB.
NB. # ' '&(-.~) 'one thousand'&, ,/ eul17_999_to_name"0 (1 + i.999)

NB. Problem 18
NB.
NB. start at top of triangle, each step move to adjacent number in next row - find path with largest sum
NB.
eul18_tri =: ". ;._1 ';75;95 64;17 47 82;18 35 87 10;20 04 82 47 65;19 01 23 75 03 34;88 02 77 73 07 63 67;99 65 04 28 06 16 70 92;41 41 26 56 83 40 80 70 33;41 48 72 33 47 32 37 16 94 29;53 71 44 65 25 43 91 52 97 51 14;70 11 33 28 77 73 17 78 39 68 17 57;91 71 52 38 17 14 91 43 58 50 27 29 48;63 66 04 68 89 53 67 30 73 16 69 87 40 31;04 62 98 27 23 09 70 98 73 93 38 53 60 04 23'



NB. Problem 19
NB.
NB. Number of Sundays that fall on first day of month between 1/1/1901 - Dec 31 2000
NB.

eul19_month_days =: 3 : 0

NB. Y - year (e.g. 1900, 2000, etc)
NB.
NB. return number of days in each month of specified year
NB.
NB.

NB. month_days =. 31 28 31 30 31 30 31 31 30 31 30 31

feb_days =. 28 

if. 0&= 4 | y do.

  if. (-. 0&= 100 | y) +. (0&= 400 | y) do.

    feb_days =. feb_days + 1

  end. 

end. 

31 , feb_days , 31 30 31 30 31 31 30 31 30 31
)

NB. solution = +/ 0&= }. 7&| 2&+ +/\ ,/ eul19_month_days"0  (1901 + i.100

NB. Problem 20
NB.
NB. Compute the sum of digits of !100
NB.
NB. re-use the eul16_carry function
NB.

NB. X - number of digits to calculate 
NB. Y - number to compute factorial of

eul20_fact =: {{ (<:@:{. , {. eul16_carry@:* }.)^:y (y , 1 ,~ x # 0) }} 

NB. solution:  +/ 160 eul20_fact 100

NB. Problem 21
NB.
NB. Find the sum of all amicable numbers less than 10000
NB.

NB. ( (}."1)@:] ; [ , [: ({. ^"(0 _) i.@:{:) [: 0&{"1 ]) 

eul21_calc_div =: 3 : 0

NB. Calculate divisors from set of prime factors and prime exponents
NB.
NB. Y - n (current number of prime factor + exponents), p1, e1, p2, e2, ... pn, en , list of current factors
NB.
NB. returns (n-1) , p2, e2, ... pn, en, updated list of factors
NB.
NB. if (0 = {. y) assume we are done with computation and just return y 

if. (0&= {. y) do.

    y return.

end.

n =. 0&{ y
np =. n - 1 

( np , (2*np)&{.@:(3&}.) , [: ,/ ( 1&{ ^"(0 _) i.@:>:@:(2&{) ) *"(0 _) ] }.~ (1&+)@:(2&*)@:{. ) y
)

NB. Build list of all divisors for n=1..9999 

NB. xx =:  ([: eul21_calc_div^:_ [: ( 1 ,~ -:@:# , ]) [: ,/@:|: __&q:)"0 (}. i.10000)

NB. Drop the zeroes from each list of divisors, drop n from each list of divisors to get list of proper divisors, add index column, entries for (0,0) 

NB. xx =: (0 ,. 0) ,  (}. i.10000) ,. ([: +/ [: }: 0&(-.~))"1 xx

NB. add column that specifies if sum of divisors is less than 10000 

NB. xx =: (] ,. [: 10000&> 1&{"1) xx

NB. Get list of Amicable numbers

NB. (] #~ 3&{"1 = 0&{"1)  (] ,. 1&{"1 { ~ 2&{"1 * 1&{"1) xx

NB. manually pull out Amicable numbers - leaving out the perfect numbers:  31626


NB. Problem 22
NB.
NB. Given set of names in a file - comma separated and in quotes
NB. Sort alphabetically
NB. Compute sum of position (starting at 1?) * alphabetic value
NB.
NB. alphabetic value - sum taking A=1, B=2, .....
NB.

NB. names file should be in the same directory as euler_fun.ijs 

eul22_namelist =: fread 'p022_names.txt'

eul22_summ_names =: [: +/ [: */"1 [: (] ,.~ [: 1&+ i.@:#)@:> [: ([: +/ [: _64&+ a.&i.) each [: /:~ [: (<@:}.@:}: ;._1) ','&, 

NB. solution: eul22_summ_names eul22_namelist

