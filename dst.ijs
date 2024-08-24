NB.
NB. simple daylight savings time conversions for unix timestamps
NB.

NB. dates where DST begins and ends - all at 2:00 AM 
 	 

NB. 2015	March 8	        November 1	
NB. 2016	March 13	November 6	
NB. 2017	March 12	November 5	
NB. 2018	March 11	November 4	
NB. 2019	March 10	November 3	
NB. 2020	March 8	        November 1
NB. 2021	March 14	November 7

NB. break these into a simple array

dateLines =: 0 , 7200 ,~ todayno 2000 1 1 
dateLines =: dateLines ,: 1 , 7199 ,~ todayno 2015 3 8
dateLines =: dateLines , 0 , 7199 ,~ todayno 2015 11 1
dateLines =: dateLines , 1 , 7199 ,~ todayno 2016 3 13
dateLines =: dateLines , 0 , 7199 ,~ todayno 2016 11 6
dateLines =: dateLines , 1 , 7199 ,~ todayno 2017 3 12
dateLines =: dateLines , 0 , 7199 ,~ todayno 2017 11 5
dateLines =: dateLines , 1 , 7199 ,~ todayno 2018 3 11
dateLines =: dateLines , 0 , 7199 ,~ todayno 2018 11 4
dateLines =: dateLines , 1 , 7199 ,~ todayno 2019 3 10
dateLines =: dateLines , 0 , 7199 ,~ todayno 2019 11 3
dateLines =: dateLines , 1 , 7199 ,~ todayno 2020 3 8
dateLines =: dateLines , 0 , 7199 ,~ todayno 2020 11 1
dateLines =: dateLines , 1 , 7199 ,~ todayno 2021 3 14
dateLines =: dateLines , 0 , 7199 ,~ todayno 2021 11 7
dateLines =: dateLines , 1 , 7199 ,~ todayno 2022 3 14
dateLines =: dateLines , 0 , 7199 ,~ todayno 2022 11 6
dateLines =: dateLines , 1 , 7199 ,~ todayno 2023 3 12
dateLines =: dateLines , 0 , 7199 ,~ todayno 2023 11 5
dateLines =: dateLines , 1 , 7199 ,~ todayno 2024 3 10
dateLines =: dateLines , 0 , 7199 ,~ todayno 2024 11 3
dateLines =: dateLines , 0 , 7199 ,~ todayno 2100 1 1

dateLines =: (] ,. 2&{"1 + [: 86400&* 1&{"1) dateLines

euroDL =: 0 , 7200 ,~ todayno 2000 1 1
euroDL =: euroDL ,: 1 , 7199 ,~ d2n 2015 3 29
euroDL =: euroDL , 0 , 7199 ,~ d2n 2015 10 25
euroDL =: euroDL , 1 , 7199 ,~ d2n 2016 3 27
euroDL =: euroDL , 0 , 7199 ,~ d2n 2016 10 30
euroDL =: euroDL , 1 , 7199 ,~ d2n 2017 3 26
euroDL =: euroDL , 0 , 7199 ,~ d2n 2017 10 29
euroDL =: euroDL , 1 , 7199 ,~ d2n 2018 3 25
euroDL =: euroDL , 0 , 7199 ,~ d2n 2018 10 28
euroDL =: euroDL , 1 , 7199 ,~ d2n 2019 3 31 
euroDL =: euroDL , 0 , 7199 ,~ d2n 2019 10 27
euroDL =: euroDL , 1 , 7199 ,~ d2n 2020 3 29
euroDL =: euroDL , 0 , 7199 ,~ d2n 2020 10 25
euroDL =: euroDL , 1 , 7199 ,~ d2n 2021 3 28
euroDL =: euroDL , 0 , 7199 ,~ d2n 2021 10 31 
euroDL =: euroDL , 1 , 7199 ,~ d2n 2022 3 27
euroDL =: euroDL , 0 , 7199 ,~ d2n 2022 10 30
euroDL =: euroDL , 1 , 7199 ,~ d2n 2023 3 26
euroDL =: euroDL , 0 , 7199 ,~ d2n 2023 10 29
euroDL =: euroDL , 1 , 7199 ,~ d2n 2024 3 31
euroDL =: euroDL , 0 , 7199 ,~ d2n 2024 10 27
euroDL =: euroDL , 0 , 7199 ,~ todayno 2100 1 1

euroDL =: (] ,. 2&{"1 + [: 86400&* 1&{"1) euroDL

NB. Euro - dates until 2099:
NB.
NB. beginning of summer time: 
NB. A formula which can be used to calculate the beginning of European Summer Time is:

NB. Sunday (31 − ((((5 × y) ÷ 4) + 4) mod 7)) March at 01:00 UTC

NB. The corresponding formula for the end of European Summer Time is:

NB. Sunday (31 − ((((5 × y) ÷ 4) + 1) mod 7)) October at 01:00 UTC

NB. where y is the year, and a mod b is b times the fractional part of a/b. These formulae are valid until 2099.[26]

ausDL =: 0 , 7200 ,~ todayno 2000 1 1
ausDL =: ausDL ,: _1 , 7199 ,~ d2n 2019 4 7
ausDL =: ausDL , 0 , 7199 ,~ d2n 2019 10 6 
ausDL =: ausDL , _1 , 7199 ,~ d2n 2020 4 5 
ausDL =: ausDL , 0 , 7199 ,~ d2n 2020 10 4 
ausDL =: ausDL , _1 , 7199 ,~ d2n 2021 4 4 
ausDL =: ausDL , 0 , 7199 ,~ d2n 2021 10 3
ausDL =: ausDL , _1 , 7199 ,~ d2n 2022 4 3
ausDL =: ausDL , 0 , 7199 ,~ d2n 2022 10 2
ausDL =: ausDL , _1 , 7199 ,~ d2n 2023 4 2
ausDL =: ausDL , 0 , 7199 ,~ d2n 2023 10 1
ausDL =: ausDL , _1 , 7199 ,~ d2n 2024 4 7
ausDL =: ausDL , 0 , 7199 ,~ d2n 2024 10 6
ausDL =: (] ,. 2&{"1 + [: 86400&* 1&{"1) ausDL

NB. places that don't observe daylight savings

noDL =: 0 , 7200 ,~ todayno 2000 1 1
noDL =: noDL ,: 0 , 7199 ,~ d2n 2100 1 1
noDL =: (] ,. 2&{"1 + [: 86400&* 1&{"1) noDL

utc2loc =: 4 : 0 

NB. convert UTC to local time 
NB. x - standard time offset in hours (assumes ST = UTC - offset) , eurorTZ? (def 0) 
NB. y - UTC timestamp (assumed to be J timestamp)
NB. 
NB. returns - local timestamp 
NB.
NB. only works for 3/8/2015 - 11/7/2021 or so 
NB.

NB. first convert timestamp to local time assuming standard time 

locTS =. y - (3600 * {. x) 

mDL =. (dateLines&[) ` (euroDL&[) ` (ausDL&[) ` (noDL&[) @. {: x 

(] + [: 3600&* [: (0&{"1 mDL)&({~) [: _1&+ (3&{"1 mDL)&I.) locTS 
)


loc2utc =: 4 : 0 

NB. convert local time to UTC 
NB. X - standard time offset in hours (assumes ST = UTC - offset) , timezone type (def 0) 
NB. Y - local timestamp (j instant in local time zone) 
NB. 
NB. returns - timestamp in UTC 
NB. 
NB. NOTE - local timestamp is always assumed to be standard time for 2:00 - 3:00 AM of fall back time period 
NB.

utcTS =. y + (3600 * {. x) 

mDL =. (dateLines&[) ` (euroDL&[) ` (ausDL&[) ` (noDL&[) @. {: x 

(] - [: 3600&* [: (0&{"1 mDL)&({~) [: _1&+ (3&{"1 mDL)&I.) utcTS
)


utc2locDate =: 4 : 0 

NB. convert  j UTC instanst to date info in time zone specified by x 
NB. x - time zone info (standard time offset in hours , TZ type - 0-US, 1-Euro, 2-Aussie, 3-No Daylight Savings)

rawInst =. x utc2loc y 
rawDate =. <.@(86400&db) rawInst

NB. (todate@(0&{"1) ,. ]) (round@(86400&db) ,. 86400&| ,: ]) rawInst
if. (# $ y)=0 do. 
(todate rawDate) , (gwd rawDate) , rawDate , (86400&| rawInst) , rawInst
else. 
(todate rawDate) ,. (gwd rawDate) ,. rawDate ,. (86400&| rawInst) ,. rawInst
end.
) 

dtutc2loc =: 4 : 0

NB. convert date and time in form of (date number, time in seconds) from UTC to time zone specified by offset in hours 
NB. x - offset from UTC in hours 
NB. y - (date number, time in seconds)
NB. 
NB. returns the time in the specified time zone
NB.

utcjinst =. (_3600 * {. x) + +/"1 (86400 1)&*"(_ 1) y  

mDL =. (dateLines&[) ` (euroDL&[) ` (ausDL&[) ` (noDL&[) @. {: x 

(<.@:(86400&db) ,. 86400&|) (] + [: 3600&* [: (0&{"1 mDL)&({~) [: _1&+ (3&{"1 mDL)&I.) utcjinst
)