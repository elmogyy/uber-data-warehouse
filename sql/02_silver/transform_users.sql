CREATE TABLE silver.users (
    user_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(80),
    date_joined DATE,
    is_driver BIT NOT NULL DEFAULT 0,
    silver_loaded_at DATETIME2 DEFAULT SYSDATETIME()
);

INSERT INTO silver.users (
    user_id,
    name,
    email,
    phone,
    city,
    date_joined,
    is_driver
)
SELECT
    user_id,
    LTRIM(RTRIM(name)) AS name,
    LOWER(LTRIM(RTRIM(email))) AS email,
    CASE
        WHEN LEN(REGEXP_REPLACE(phone, '[^0-9]', '')) < 7 THEN NULL
        ELSE REGEXP_REPLACE(phone, '[^0-9+\-() ]', '')
    END AS phone,
    NULLIF(LTRIM(RTRIM(city)), '') AS city,
    CASE
        WHEN date_joined > CAST(GETDATE() AS DATE) THEN NULL
        WHEN date_joined < '2000-01-01' THEN NULL
        ELSE date_joined
    END AS date_joined,
    CASE
        WHEN is_driver IN (0, 1) THEN is_driver
        ELSE 0
    END AS is_driver
FROM bronze.users
WHERE
    user_id IS NOT NULL
    AND LTRIM(RTRIM(name)) <> ''
    AND LTRIM(RTRIM(email)) <> ''
    AND email LIKE '%@%.%'
    AND user_id IN (
        SELECT MIN(user_id)
        FROM bronze.users
        GROUP BY LOWER(LTRIM(RTRIM(email)))
    );