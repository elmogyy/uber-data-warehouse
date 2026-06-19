CREATE TABLE silver.trips (
    trip_id INT PRIMARY KEY,
    rider_id INT NOT NULL,
    driver_id INT NOT NULL,
    pickup_location_id INT NOT NULL,
    dropoff_location_id INT NOT NULL,
    requested_at DATETIME2,
    started_at DATETIME2,
    completed_at DATETIME2,
    status VARCHAR(20),
    distance_km DECIMAL(10,2),
    duration_mins INT,
    base_fare DECIMAL(10,2),
    surge_multiplier DECIMAL(5,2),
    total_fare DECIMAL(10,2),
    payment_method VARCHAR(20),
    trip_date DATE,
    trip_hour INT
);

TRUNCATE TABLE silver.trips;

INSERT INTO silver.trips (
    trip_id,
    rider_id,
    driver_id,
    pickup_location_id,
    dropoff_location_id,
    requested_at,
    started_at,
    completed_at,
    status,
    distance_km,
    duration_mins,
    base_fare,
    surge_multiplier,
    total_fare,
    payment_method,
    trip_date,
    trip_hour
)
SELECT
    trip_id,
    rider_id,
    driver_id,
    pickup_location_id,
    dropoff_location_id,
    TRY_CAST(requested_at AS DATETIME2),
    TRY_CAST(started_at AS DATETIME2),
    TRY_CAST(completed_at AS DATETIME2),
    CASE
        WHEN LOWER(status) IN ('completed', 'done') THEN 'Completed'
        WHEN LOWER(status) IN ('cancelled', 'canceled') THEN 'Canceled'
        WHEN LOWER(status) IN ('in_progress', 'ongoing') THEN 'In Progress'
        ELSE 'Unknown'
    END,
    CASE
        WHEN distance_km < 0 THEN NULL
        ELSE distance_km
    END,
    CASE
        WHEN duration_mins < 0 THEN NULL
        ELSE duration_mins
    END,
    ISNULL(base_fare, 0),
    ISNULL(surge_multiplier, 1),
    CASE
        WHEN total_fare IS NULL
            THEN ISNULL(base_fare, 0) * ISNULL(surge_multiplier, 1)
        ELSE total_fare
    END,
    CASE
        WHEN LOWER(payment_method) IN ('cash', 'card', 'wallet')
            THEN UPPER(LEFT(LOWER(payment_method), 1))
                 + SUBSTRING(LOWER(payment_method), 2, LEN(payment_method))
        ELSE 'Other'
    END,
    CAST(requested_at AS DATE),
    DATEPART(HOUR, requested_at)
FROM bronze.trips
WHERE trip_id IS NOT NULL;

SELECT *
FROM silver.trips;