/*
Please review the dataset schema provided on the 'data_2' table. 
Please create SQL query presenting difference between the last value over time and 
the first value over time for each player_id (clarification: not the biggest and
 the lowest values difference).
Desired final schema is: player_id, difference
*/
use sales;
SELECT 
    summery.player_id, (lv.value - fv.value) difference_val
FROM
    data2 lv,
    data2 fv,
    (SELECT 
        PLAYER_ID,
            MAX(STR_TO_DATE(data2.date, '%m/%d/%y')) last_date,
            MIN(STR_TO_DATE(data2.date, '%m/%d/%y')) first_date
    FROM
        data2
    GROUP BY PLAYER_ID) summery
WHERE
    summery.player_id = lv.player_id
        AND summery.last_date = STR_TO_DATE(lv.date, '%m/%d/%y')
        AND summery.player_id = fv.player_id
        AND summery.first_date = STR_TO_DATE(fv.date, '%m/%d/%y')
ORDER BY summery.player_id;
