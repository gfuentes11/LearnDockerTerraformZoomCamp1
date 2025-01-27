-- Active: 1737843034572@@127.0.0.1@5433@ny_taxi
/*
During the period of October 1st 2019 (inclusive) and November 1st 2019 (exclusive), how many trips, **respectively**, happened:
1. Up to 1 mile
2. In between 1 (exclusive) and 3 miles (inclusive),
3. In between 3 (exclusive) and 7 miles (inclusive),
4. In between 7 (exclusive) and 10 miles (inclusive),
5. Over 10 miles 
*/

-- 1
SELECT count(*) FROM public.green_taxi_trips
    WHERE 
        lpep_pickup_datetime >= '2019-10-01' AND lpep_pickup_datetime < '2019-11-01'
        AND trip_distance <= 1;
-- 2 In between 1 (exclusive) and 3 miles (inclusive)
SELECT count(*) FROM public.green_taxi_trips
    WHERE 
        lpep_pickup_datetime >= '2019-10-01' AND lpep_pickup_datetime < '2019-11-01'
        AND trip_distance > 1 AND trip_distance <= 3;
-- 3 In between 3 (exclusive) and 7 miles (inclusive)
SELECT count(*) FROM public.green_taxi_trips
    WHERE 
        lpep_pickup_datetime >= '2019-10-01' AND lpep_pickup_datetime < '2019-11-01'
        AND trip_distance > 3 AND trip_distance <= 7;

-- 4 In between 7 (exclusive) and 10 miles (inclusive),
SELECT count(*) FROM public.green_taxi_trips
    WHERE 
        lpep_pickup_datetime >= '2019-10-01' AND lpep_pickup_datetime < '2019-11-01'
        AND trip_distance > 7 AND trip_distance <= 10;

-- 5 Over 10 miles 
SELECT count(*) FROM public.green_taxi_trips
    WHERE 
        lpep_pickup_datetime >= '2019-10-01' AND lpep_pickup_datetime < '2019-11-01'
        AND trip_distance > 10;