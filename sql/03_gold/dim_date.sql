DECLARE @start_date DATE = '2019-01-01';
DECLARE @end_date   DATE = '2026-12-31';

WHILE @start_date <= @end_date
BEGIN
    INSERT INTO dim_date (
        date_key,
        full_date,
        day,
        month,
        month_name,
        quarter,
        year,
        day_of_week,
        day_name,
        is_weekend
    )
    VALUES (
        CAST(FORMAT(@start_date, 'yyyyMMdd') AS INT),
        @start_date,
        DAY(@start_date),
        MONTH(@start_date),
        DATENAME(MONTH, @start_date),
        DATEPART(QUARTER, @start_date),
        YEAR(@start_date),
        DATEPART(WEEKDAY, @start_date),
        DATENAME(WEEKDAY, @start_date),
        CASE 
            WHEN DATENAME(WEEKDAY, @start_date) IN ('Saturday', 'Friday') THEN 1 
            ELSE 0 
        END
    );

    SET @start_date = DATEADD(DAY, 1, @start_date);
END;