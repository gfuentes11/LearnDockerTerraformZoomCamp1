-- Active: 1737843034572@@127.0.0.1@5433@ny_taxi@public
/*
Which was the pick up day with the longest trip distance?
Use the pick up time for your calculations.

Tip: For every day, we only care about one single trip with the longest distance. 

- 2019-10-11
- 2019-10-24
- 2019-10-26
- 2019-10-31
*/
SELECT 
    DATE(lpep_pickup_datetime) AS pickup_date, 
    MAX(trip_distance) AS max_trip_distance
FROM 
    green_taxi_trips
WHERE 
    DATE(lpep_pickup_datetime) IN ('2019-10-11', '2019-10-24', '2019-10-26', '2019-10-31')
GROUP BY 
    DATE(lpep_pickup_datetime)
ORDER BY 
    max_trip_distance DESC