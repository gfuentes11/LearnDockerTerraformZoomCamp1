/*
Which were the top pickup locations with over 13,000 in
`total_amount` (across all trips) for 2019-10-18?

Consider only `lpep_pickup_datetime` when filtering by date.

*/
SELECT
    "Zone", sum(total_amount)
    FROM green_taxi_trips 
    INNER JOIN zones ON "PULocationID" = "LocationID"
    WHERE DATE(lpep_pickup_datetime) = '2019-10-18'
    GROUP BY "Zone"
    having sum(total_amount) > 13000;