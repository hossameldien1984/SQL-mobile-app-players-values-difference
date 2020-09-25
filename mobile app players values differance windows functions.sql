/*
Please review the dataset schema provided on the 'data_2' table. 
Please create SQL query presenting difference between the last value over time and 
the first value over time for each player_id (clarification: not the biggest and
 the lowest values difference).
Desired final schema is: player_id, difference
*/
use sales;
with Q as(
SELECT data2.player_id,(
last_value(data2.value) 
over (partition by data2.player_id order by STR_TO_DATE(data2.date, '%m/%d/%y') ) -
first_value(data2.value) 
over (partition by data2.player_id order by STR_TO_DATE(data2.date, '%m/%d/%y') )
) difference_val,
row_number() over (partition by data2.player_id) ind
from data2
order by data2.player_id,ind desc) 

select Q.player_id,Q.difference_val
from Q
group by Q.player_id
;