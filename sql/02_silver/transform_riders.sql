CREATE TABLE silver.riders (
    rider_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    rating DECIMAL(3,2) NULL,
    total_trips INT NOT NULL,
    created_at DATETIME2
);

WITH cleaned AS (
    SELECT
        r.rider_id,
        r.user_id,
        CASE
            WHEN r.rating BETWEEN 0 AND 5 THEN r.rating
            ELSE NULL
        END AS rating,
        CASE
            WHEN r.total_trips >= 0 THEN r.total_trips
            ELSE 0
        END AS total_trips,
        ISNULL(r.created_at, GETDATE()) AS created_at,
        ROW_NUMBER() OVER (
            PARTITION BY r.rider_id
            ORDER BY r.created_at DESC
        ) AS rn
    FROM bronze.riders r
    WHERE EXISTS (
        SELECT 1
        FROM bronze.users u
        WHERE u.user_id = r.user_id
    )
)

INSERT INTO silver.riders (
    rider_id,
    user_id,
    rating,
    total_trips,
    created_at
)
SELECT
    rider_id,
    user_id,
    rating,
    total_trips,
    created_at
FROM cleaned
WHERE rn = 1;

SELECT * FROM silver.riders;
SELECT * FROM bronze.riders;