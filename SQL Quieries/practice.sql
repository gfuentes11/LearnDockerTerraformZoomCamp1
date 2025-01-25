-- Active: 1737843034572@@127.0.0.1@5432@ny_taxi
-- Connected to NY_TAXI dataset through VS Code ext to use instead of running everything through PG Admin

# Joining tables where pick up loaction matches  PickUp and Drop Off LCoation to ZPI Location ID. 
SELECT 
* 
FROM
    yellow_taxi_trips t,
    zones zpu,
    zones zdo
WHERE
    t."PULocationID" = zpu."LocationID" AND
    t."DOLocationID" = zdo."LocationID"
LIMIT 100

# Obviousoly hard to see results for both tables. Specifc columns instead of using *
# Below is an example of inner join without using JOIN COmmand
SELECT 
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    concat(zpu."Borough" , ' / ' , zpu."Zone") AS "Pick_up_loc",
    concat(zdo."Borough" , ' / ' , zdo."Zone") AS "Pick_up_loc"
FROM
    yellow_taxi_trips t,
    zones zpu,
    zones zdo
WHERE
    t."PULocationID" = zpu."LocationID" AND
    t."DOLocationID" = zdo."LocationID"
LIMIT 100

# Here is another example on how to write with the JOIN. 
# Check to see how performance compares. 
SELECT 
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
    concat(zpu."Borough" , ' / ' , zpu."Zone") AS "Pick_up_loc",
    concat(zdo."Borough" , ' / ' , zdo."Zone") AS "Drop_off_loc"
FROM
    yellow_taxi_trips t JOIN zones zpu
        ON t."PULocationID" = zpu."LocationID"
    JOIN zones zdo
        ON t."DOLocationID" = zdo."LocationID"
LIMIT 100

# Let us check if "PULocationID" is Null or "DOLocationID" is null

SELECT 
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
    "PULocationID",
    "DOLocationID"
FROM
    yellow_taxi_trips 
WHERE
    "PULocationID" is NULL
    or 
    "DOLocationID" is NULL
LIMIT 100

# Now let us check if any PU IDs or DO IDs not in the Zones Tables 
SELECT 
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
    "PULocationID",
    "DOLocationID"
FROM
    yellow_taxi_trips 
WHERE
    "PULocationID" NOT IN (SELECT "LocationID" from zones)
    or 
    "DOLocationID" NOT IN (SELECT "LocationID" from zones)
LIMIT 100

# Now let us explore how to use the Delete function and that will help explain the Left Join 
DELETE FROM zones where "LocationID" = 142;

# Now let us run the Left Join to see what we get and rerun the join and see if you can see the '142' id
SELECT 
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
    concat(zpu."Borough" , ' / ' , zpu."Zone") AS "Pick_up_loc",
    concat(zdo."Borough" , ' / ' , zdo."Zone") AS "Drop_off_loc"
FROM
    yellow_taxi_trips t LEFT JOIN zones zpu
        ON t."PULocationID" = zpu."LocationID"
    LEFT JOIN zones zdo
        ON t."DOLocationID" = zdo."LocationID"
LIMIT 100;

# You should see blanks in Pick Up lcoation and drop off location. Let us see what happens when we do Right Join
SELECT 
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
    concat(zpu."Borough" , ' / ' , zpu."Zone") AS "Pick_up_loc",
    concat(zdo."Borough" , ' / ' , zdo."Zone") AS "Drop_off_loc"
FROM
    yellow_taxi_trips t RIGHT JOIN zones zpu
        ON t."PULocationID" = zpu."LocationID"
    RIGHT JOIN zones zdo
        ON t."DOLocationID" = zdo."LocationID"
LIMIT 100;

#Let us do some Date trunction  and Group by
SELECT
    CAST(tpep_dropoff_datetime AS DATE) AS "day",
    COUNT(1)
FROM 
    yellow_taxi_trips t
GROUP BY
    CAST(tpep_dropoff_datetime AS DATE)
LIMIT 100;

-- Let us apply some Order By See what happens between asc and desc
SELECT
    CAST(tpep_dropoff_datetime AS DATE) AS "day",
    COUNT(1)
FROM 
    yellow_taxi_trips t
GROUP BY
    CAST(tpep_dropoff_datetime AS DATE)
ORDER BY "count" DESC
LIMIT 100;

SELECT
    CAST(tpep_dropoff_datetime AS DATE) AS "day",
    COUNT(1)
FROM 
    yellow_taxi_trips t
GROUP BY
    CAST(tpep_dropoff_datetime AS DATE)
ORDER BY "count" ASC
LIMIT 100;

-- Now let us use max function

SELECT
    CAST(tpep_dropoff_datetime AS DATE) AS "day",
    COUNT(1) AS "count",
    MAX(total_amount) AS "total_amount",
    MAX(passenger_count) AS "passenger_count"
FROM 
    yellow_taxi_trips t
GROUP BY
    CAST(tpep_dropoff_datetime AS DATE)
ORDER BY
    "count" DESC
LIMIT 100;

-- Now let us use a group by of multile fields 
