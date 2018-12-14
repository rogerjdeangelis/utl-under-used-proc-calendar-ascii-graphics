
Under used proc calendar ascii graphics                                                                                     
                                                                                                                            
see SAS doc                                                                                                                 
http://support.sas.com/documentation/cdl/en/proc/61895/HTML/default/viewer.htm#calendarex01.htm                             
                                                                                                                            
inspired by                                                                                                                 
https://tinyurl.com/y8629u9r                                                                                                
https://communities.sas.com/t5/SAS-Visual-Analytics-Gallery/Visualizing-the-busiest-travel-days-in-December/ta-p/521298     
                                                                                                                            
Sometimes a table like calendar is more informational than fnacy graphics?                                                  
                                                                                                                            
INPUT                                                                                                                       
=====                                                                                                                       
                                                                                                                            
 WORK.MEALS total obs=16                                                                                                    
                                                                                                                            
      DATE       BRKFST    LUNCH    DINNER                                                                                  
                                                                                                                            
    02DEC1996      123      234       238                                                                                   
    03DEC1996      188      188       198                                                                                   
    04DEC1996      123      183       176                                                                                   
    05DEC1996      200      267       243                                                                                   
    06DEC1996      176      165       177                                                                                   
                                                                                                                            
                                                                                                                            
 WORK.CLOSED total obs=6                                                                                                    
                                                                                                                            
     DATE       HOLIDAY                                                                                                     
                                                                                                                            
   26DEC1996    Repairs                                                                                                     
   27DEC1996    Repairs                                                                                                     
   30DEC1996    Repairs                                                                                                     
   31DEC1996    Repairs                                                                                                     
   24DEC1996    Christmas Eve                                                                                               
   25DEC1996    Christmas                                                                                                   
                                                                                                                            
                                                                                                                            
EXAMPLE OUTPUT (did some minor edits using the excellent ascii classic editor)                                              
------------------------------------------------------------------------------                                              
                                                                                                                            
Meals Served in Company Cafeteria                                                                                           
Mean Number by Business Day                                                                                                 
                                                                                                                            
+----------------------------------------------------------------+                                                          
|                                                                |                                                          
|                         December  2018                         |                                                          
|                                                                |                                                          
|----------------------------------------------------------------|                                                          
|   Monday   |  Tuesday   | Wednesday  |  Thursday  |   Friday   |                                                          
|------------+------------+------------+------------+------------|                                                          
|      2     |      3     |      4     |      5     |      6     |                                                          
|            |            |            |            |            |                                                          
| 123 Brkfst | 188 Brkfst | 123 Brkfst | 200 Brkfst | 176 Brkfst |                                                          
| 234 Lunch  | 188 Lunch  | 183 Lunch  | 267 Lunch  | 165 Lunch  |                                                          
| 238 Dinner | 198 Dinner | 176 Dinner | 243 Dinner | 177 Dinner |                                                          
|------------+------------+------------+------------+------------|                                                          
|      9     |     10     |     11     |     12     |     13     |                                                          
|            |            |            |            |            |                                                          
| 178 Brkfst | 165 Brkfst | 187 Brkfst | 176 Brkfst | 187 Brkfst |                                                          
| 198 Lunch  | 176 Lunch  | 176 Lunch  | 187 Lunch  | 187 Lunch  |                                                          
| 187 Dinner | 187 Dinner | 231 Dinner | 222 Dinner | 123 Dinner |                                                          
|------------+------------+------------+------------+------------|                                                          
|     16     |     17     |     18     |     19     |     20     |                                                          
|            |            |            |            |            |                                                          
| 176 Brkfst | 156 Brkfst | 198 Brkfst | 178 Brkfst | 165 Brkfst |                                                          
| 165 Lunch  |          . | 143 Lunch  | 198 Lunch  | 176 Lunch  |                                                          
| 177 Dinner | 167 Dinner | 167 Dinner | 187 Dinner | 187 Dinner |                                                          
|------------+------------+------------+------------+------------|                                                          
|     23     |     24     |     25     |     26     |     27     |                                                          
|            |Christmas Ev| Christmas  |  Repairs   |  Repairs   |                                                          
| 187 Brkfst |            |            |            |            |                                                          
| 187 Lunch  |            |            |            |            |                                                          
| 123 Dinner |            |            |            |            |                                                          
|------------+------------+------------+------------+------------|                                                          
|     30     |     31     |            |            |            |                                                          
|  Repairs   |  Repairs   |            |            |            |                                                          
|            |            |            |            |            |                                                          
|            |            |            |            |            |                                                          
|            |            |            |            |            |                                                          
+----------------------------------------------------------------+                                                          
                                                                                                                            
+-----------------------------------+                                                                                       
|                   | Sum  |  Mean  |                                                                                       
|                   |      |        |                                                                                       
| Breakfasts Served | 2763 | 172.69 |                                                                                       
|    Lunches Served | 2830 | 188.67 |                                                                                       
|    Dinners Served | 2990 | 186.88 |                                                                                       
+-----------------------------------+                                                                                       
                                                                                                                            
                                                                                                                            
PROCESS                                                                                                                     
=======                                                                                                                     
                                                                                                                            
proc sort data=meals;                                                                                                       
   by date;                                                                                                                 
run;                                                                                                                        
                                                                                                                            
proc format;                                                                                                                
   picture bfmt other = '000 Brkfst';                                                                                       
   picture lfmt other = '000 Lunch ';                                                                                       
   picture dfmt other = '000 Dinner';                                                                                       
run;                                                                                                                        
                                                                                                                            
options nodate pageno=1 linesize=132 pagesize=60;                                                                           
                                                                                                                            
proc calendar data=meals holidata=closed weekdays;;                                                                         
   start date;                                                                                                              
   holistart date;                                                                                                          
   holiname holiday;                                                                                                        
   sum brkfst lunch dinner / format=4.0;                                                                                    
   mean brkfst lunch dinner / format=6.2;                                                                                   
   label brkfst = 'Breakfasts Served'                                                                                       
         lunch  = '   Lunches Served'                                                                                       
         dinner = '   Dinners Served';                                                                                      
   format brkfst bfmt.                                                                                                      
          lunch lfmt.                                                                                                       
          dinner dfmt.;                                                                                                     
   title 'Meals Served in Company Cafeteria';                                                                               
   title2 'Mean Number by Business Day';                                                                                    
run;                                                                                                                        
                                                                                                                            
*                _              _       _                                                                                   
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _                                                                            
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |                                                                           
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |                                                                           
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|                                                                           
                                                                                                                            
;                                                                                                                           
                                                                                                                            
data meals ;                                                                                                                
   format date date9.;                                                                                                      
   input date : date7. Brkfst Lunch Dinner;                                                                                 
   datalines;                                                                                                               
02Dec96       123 234 238                                                                                                   
03Dec96       188 188 198                                                                                                   
04Dec96       123 183 176                                                                                                   
05Dec96       200 267 243                                                                                                   
06Dec96       176 165 177                                                                                                   
09Dec96       178 198 187                                                                                                   
10Dec96       165 176 187                                                                                                   
11Dec96       187 176 231                                                                                                   
12Dec96       176 187 222                                                                                                   
13Dec96       187 187 123                                                                                                   
16Dec96       176 165 177                                                                                                   
17Dec96       156   . 167                                                                                                   
18Dec96       198 143 167                                                                                                   
19Dec96       178 198 187                                                                                                   
20Dec96       165 176 187                                                                                                   
23Dec96       187 187 123                                                                                                   
;                                                                                                                           
                                                                                                                            
data closed ;                                                                                                               
   format date date9.;                                                                                                      
   input date date. holiday $ 11-25;                                                                                        
   datalines;                                                                                                               
26DEC96   Repairs                                                                                                           
27DEC96   Repairs                                                                                                           
30DEC96   Repairs                                                                                                           
31DEC96   Repairs                                                                                                           
24DEC96   Christmas Eve                                                                                                     
25DEC96   Christmas                                                                                                         
;                                                                                                                           
                                                                                                                            
