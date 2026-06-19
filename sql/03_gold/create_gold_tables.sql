CREATE TABLE
    dim_driver (
        driver_key INT PRIMARY KEY IDENTITY (1, 1),
        driver_id INT,
        user_id INT,
        vehicle_make VARCHAR(50),
        vehicle_model VARCHAR(50),
        vehicle_year INT,
        license_plate VARCHAR(20),
        rating DECIMAL(3, 2),
        join_date DATE,
        is_active BIT,
        name VARCHAR(100),
        email VARCHAR(150),
        phone VARCHAR(20),
        city VARCHAR(80),
        date_joined DATE
    );

CREATE TABLE
    dim_rider (
        rider_key INT PRIMARY KEY IDENTITY (1, 1),
        rider_id INT,
        rating DECIMAL(3, 2),
        total_trips INT,
        created_at DATETIME2,
        user_id INT,
        name VARCHAR(100),
        email VARCHAR(150),
        phone VARCHAR(20),
        city VARCHAR(80),
        date_joined DATE
    );

CREATE TABLE
    dim_location (
        location_key INT PRIMARY KEY IDENTITY (1, 1),
        location_id INT,
        zone_name VARCHAR(100),
        city VARCHAR(80),
        latitude DECIMAL(9, 6),
        longitude DECIMAL(9, 6),
        zone_type VARCHAR(50),
    );

CREATE TABLE
    dim_status (
        status_key INT IDENTITY (1, 1) PRIMARY KEY,
        status_value VARCHAR(50) NOT NULL
    );

INSERT INTO
    dim_status (status_value)
VALUES
    ('Completed'),
    ('Canceled'),
    ('In Progress');

CREATE TABLE
    dim_time (
        time_key INT PRIMARY KEY, 
        hour_24 INT, 
        hour_12 INT, 
        am_pm VARCHAR(2) 
    );

CREATE TABLE
    dim_date (
        date_key INT PRIMARY KEY,
        full_date DATE,
        DAY INT,
        MONTH INT,
        month_name VARCHAR(20),
        quarter INT,
        YEAR INT,
        day_of_week INT,
        day_name VARCHAR(20),
        is_weekend BIT
    );

CREATE TABLE
    dim_payment_method (
        payment_method_key INT IDENTITY (1, 1) PRIMARY KEY,
        payment_method_value VARCHAR(50) NOT NULL
    );

INSERT INTO
    dim_payment_method (payment_method_value)
VALUES
    ('Card'),
    ('Cash'),
    ('Wallet');

CREATE TABLE
    fact_trip (
        trip_key INT PRIMARY KEY IDENTITY (1, 1),
        trip_id INT,
        rider_key INT,
        driver_key INT,
        pickup_location_key INT,
        dropoff_location_key INT,
        trip_date_key INT,
        trip_hour_key INT,
        status_key INT,
        payment_method_key INT,
        distance_km DECIMAL(10, 2),
        duration_mins INT,
        base_fare DECIMAL(10, 2),
        surge_multiplier DECIMAL(5, 2),
        total_fare DECIMAL(10, 2)
    );

