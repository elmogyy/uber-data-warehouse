CREATE TABLE
    silver.users (
        user_id INTEGER PRIMARY KEY,
        name VARCHAR(100),
        email_clean VARCHAR(150), 
        phone_clean VARCHAR(20),
        city VARCHAR(80),
        date_joined DATE,
        is_driver BIT DEFAULT 0, 
        loaded_at DATETIME2 DEFAULT GETDATE ()
    );

CREATE TABLE
    silver.drivers (
        driver_id INT PRIMARY KEY,
        user_id INT NOT NULL,
        vehicle_make VARCHAR(50),
        vehicle_model VARCHAR(50),
        vehicle_year INT,
        license_plate VARCHAR(20),
        rating DECIMAL(3, 2),
        join_date DATE,
        is_active BIT
    );

CREATE TABLE
    silver.locations (
        location_id INT PRIMARY KEY,
        zone_name VARCHAR(100) NOT NULL,
        city VARCHAR(80) NOT NULL,
        latitude DECIMAL(9, 6),
        longitude DECIMAL(9, 6),
        zone_type VARCHAR(50),
    );

CREATE TABLE
    silver.riders (
        rider_id INT PRIMARY KEY,
        user_id INT NOT NULL,
        rating DECIMAL(3, 2) NULL,
        total_trips INT NOT NULL,
        created_at DATETIME2
    );

CREATE TABLE
    silver.trips (
        trip_id INT PRIMARY KEY,
        rider_id INT NOT NULL,
        driver_id INT NOT NULL,
        pickup_location_id INT NOT NULL,
        dropoff_location_id INT NOT NULL,
        requested_at DATETIME2,
        started_at DATETIME2,
        completed_at DATETIME2,
        status VARCHAR(20),
        distance_km DECIMAL(10, 2),
        duration_mins INT,
        base_fare DECIMAL(10, 2),
        surge_multiplier DECIMAL(5, 2),
        total_fare DECIMAL(10, 2),
        payment_method VARCHAR(20),
        -- Derived columns
        trip_date DATE,
        trip_hour INT
    );

CREATE TABLE
    silver.users (
        user_id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(150) NOT NULL UNIQUE,
        phone VARCHAR(20),
        city VARCHAR(80),
        date_joined DATE,
        is_driver BIT NOT NULL DEFAULT 0, 
        -- Audit columns added in Silver
        silver_loaded_at DATETIME2 DEFAULT SYSDATETIME (),
    );