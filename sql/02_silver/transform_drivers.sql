CREATE TABLE silver.drivers (
    driver_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    vehicle_make VARCHAR(50),
    vehicle_model VARCHAR(50),
    vehicle_year INT,
    license_plate VARCHAR(20),
    rating DECIMAL(3,2),
    join_date DATE,
    is_active BIT
);

WITH cleaned AS (
    SELECT
        driver_id,
        user_id,
        UPPER(LTRIM(RTRIM(vehicle_make))) AS vehicle_make,
        UPPER(LTRIM(RTRIM(vehicle_model))) AS vehicle_model,
        CASE 
            WHEN vehicle_year BETWEEN 1990 AND YEAR(GETDATE()) 
            THEN vehicle_year 
            ELSE NULL 
        END AS vehicle_year,
        UPPER(REPLACE(LTRIM(RTRIM(license_plate)), ' ', '')) AS license_plate,
        CASE 
            WHEN rating BETWEEN 0 AND 5 
            THEN ROUND(rating, 2) 
            ELSE NULL 
        END AS rating,
        CASE 
            WHEN join_date <= GETDATE() 
            THEN join_date 
            ELSE NULL 
        END AS join_date,
        CAST(is_active AS BIT) AS is_active
    FROM bronze.drivers
    WHERE user_id IS NOT NULL
      AND license_plate IS NOT NULL
),
deduplicated AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY license_plate
               ORDER BY join_date DESC, driver_id DESC
           ) AS rn
    FROM cleaned
)

INSERT INTO silver.drivers
SELECT
    driver_id,
    user_id,
    vehicle_make,
    vehicle_model,
    vehicle_year,
    license_plate,
    rating,
    join_date,
    is_active
FROM deduplicated
WHERE rn = 1;