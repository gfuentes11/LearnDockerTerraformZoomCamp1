/*
For the passengers picked up in October 2019 in the zone
named "East Harlem North" which was the drop off zone that had
the largest tip?

Note: it's `tip` , not `trip`

We need the name of the zone, not the ID.

- Yorkville West
- JFK Airport
- East Harlem North
- East Harlem South
*/

SELECT
    dozone."Zone" as dropoffzone,
    max(tip_amount) as maxtipamount
    FROM green_taxi_trips 
    INNER JOIN zones as puzone ON "PULocationID" = puzone."LocationID"
    INNER join zones as dozone  ON "DOLocationID" = dozone."LocationID"
    WHERE date_part('month',lpep_pickup_datetime) = '10'
    AND puzone."Zone" = 'East Harlem North'
    GROUP BY dozone."Zone"
    ORDER BY maxtipamount DESC

    