CREATE TABLE silver.locations (
    location_id INT PRIMARY KEY,
    zone_name   VARCHAR(100) NOT NULL,
    city        VARCHAR(80) NOT NULL,
    latitude    DECIMAL(9,6),
    longitude   DECIMAL(9,6),
    zone_type   VARCHAR(50)
);

INSERT INTO silver.locations (
    location_id,
    zone_name,
    city,
    latitude,
    longitude,
    zone_type
)
SELECT
    location_id,
    LTRIM(RTRIM(zone_name)) AS zone_name,
    UPPER(LTRIM(RTRIM(city))) AS city,
    CASE
        WHEN latitude BETWEEN -90 AND 90 THEN latitude
        ELSE NULL
    END AS latitude,
    CASE
        WHEN longitude BETWEEN -180 AND 180 THEN longitude
        ELSE NULL
    END AS longitude,
    LOWER(LTRIM(RTRIM(zone_type))) AS zone_type
FROM bronze.locations
WHERE location_id IS NOT NULL;

SELECT * FROM silver.locations;
SELECT * FROM bronze.locations;