SELECT
    t.trip_id,t.rider_id,t.driver_id,t.pickup_location_id,t.dropoff_location_id,t.base_fare,t.surge_multiplier,t.[status],t.distance_km,t.duration_mins,t.total_fare,t.payment_method,t.trip_date,t.trip_hour
FROM
    silver.trips t

