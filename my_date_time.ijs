NB.
NB. My Date and Time functions
NB.

doc_my_date_utilities =: 0 4 $ a: 

addDoc =: {{ doc_my_date_utilities =: doc_my_date_utilities , ( ({. , (<@:([: (] ;._1) (10&{a.)&, )@:>@:(1&{)) , {: ) y ) , <'my_date_utilities.ijs' }}

NB. define some simple convenience function

d2n =: todayno
n2d =: todate 

NB. get the name of the month 

monthName =: ('--';'January';'February';'March';'April';'May';'June';'July';'August';'September';'October';'November';'December')&({~)

monthAbbrev =: ('--';'JAN';'FEB';'MAR';'APR';'MAY';'JUN';'JUL';'AUG';'SEP';'OCT';'NOV';'DEC')&({~)

n2month =: [: monthName [: 1&{"1 n2d 

NB. make a list of holidays - makes sense to drop these when analyzing data as they are generally outliers 

zzz_dropDates =: d2n"1 (2023 7 4) , (2023 9 4) , (2023 5 29) , (2021 7 5) , (2021 9 6) , (2021 11 24) , (2021 11 25) , (2021 11 26) , (2021 12 24) , (2021 12 27) , (2021 12 28) , (2021 12 29) , (2021 12 30) ,: (2021 12 31)

zzz_dropDates =: zzz_dropDates , d2n"1 (2022 1 1) , (2022 7 4) ,: (2022 9 5)

NB. 

zzz_weekdays =: 'Sun','Mon','Tue','Wed','Thu','Fri',: 'sat'


ty =: 3 : 0 

NB. filter data to only this year 
NB. assumes date is the first column 
NB. x - column with date (def = 0) , (min date - default 2021 1 1) 
NB. y - data to filter 

(0 ; 2021 1 1) ty y 

:

y fgt~ (>@:(0&{ :: 0:) ,~ d2n@:>@:(1&{ :: (2021 1 1)&[)) x 
)

dayInYear =: {{)v

NB. given a day number - compute the "day of the year" - (0 - 1/1/YYYY) 

if. 1 = # y do.

  (] - [: d2n (1 1)&[ ,~ n2d) y 

else.

  'miny maxy' =. (min , max) y

  firstLastYear =. {."1 n2d miny, maxy 

  yearList =. ({. + [: i. 1&[ + {: - {.) firstLastYear

  yearJanOneList =. d2n 1 ,.~ 1 ,.~ yearList 

  yearJanOneList (] - [ {~ [ <:@:I. 0.0000001&+@:]) y 

end. 

}}