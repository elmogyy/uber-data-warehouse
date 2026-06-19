WITH
    Hours AS (
        SELECT
            0 AS h
        UNION ALL
        SELECT
            h + 1
        FROM
            Hours
        WHERE
            h < 23
    )
INSERT INTO
    dim_time (time_key, hour_24, hour_12, am_pm)
SELECT
    h AS time_key,
    h AS hour_24,
    CASE
        WHEN h = 0 THEN 12
        WHEN h <= 12 THEN h
        ELSE h - 12
    END AS hour_12,
    CASE
        WHEN h < 12 THEN 'AM'
        ELSE 'PM'
    END AS am_pm
FROM
    Hours OPTION (MAXRECURSION 24);

SELECT
    *
FROM
    dim_time
DROP TABLE dim_time