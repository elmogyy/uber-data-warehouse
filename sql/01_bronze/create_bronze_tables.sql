CREATE TABLE
    bronze.users (
        user_id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(150) NOT NULL UNIQUE,
        phone VARCHAR(20),
        city VARCHAR(80),
        date_joined DATE,
        is_driver INTEGER NOT NULL DEFAULT 0 
    );

CREATE TABLE
    bronze.drivers (
        driver_id INTEGER PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES bronze.users (user_id),
        vehicle_make VARCHAR(50),
        vehicle_model VARCHAR(50),
        vehicle_year INTEGER,
        license_plate VARCHAR(20) UNIQUE,
        rating REAL,
        join_date DATE,
        is_active INTEGER NOT NULL DEFAULT 1
    );

CREATE TABLE
    bronze.riders (
        rider_id INTEGER PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES bronze.users (user_id),
        rating REAL,
        total_trips INTEGER NOT NULL DEFAULT 0,
        created_at DATETIME
    );

CREATE TABLE
    bronze.locations (
        location_id INTEGER PRIMARY KEY,
        zone_name VARCHAR(100),
        city VARCHAR(80),
        latitude REAL,
        longitude REAL,
        zone_type VARCHAR(50)
    );

CREATE TABLE
    bronze.trips (
        trip_id INTEGER PRIMARY KEY,
        rider_id INTEGER NOT NULL REFERENCES bronze.riders (rider_id),
        driver_id INTEGER NOT NULL REFERENCES bronze.drivers (driver_id),
        pickup_location_id INTEGER NOT NULL REFERENCES bronze.locations (location_id),
        dropoff_location_id INTEGER NOT NULL REFERENCES bronze.locations (location_id),
        requested_at DATETIME,
        started_at DATETIME,
        completed_at DATETIME NULL,
        status VARCHAR(20),
        distance_km REAL,
        duration_mins INTEGER,
        base_fare REAL,
        surge_multiplier REAL,
        total_fare REAL,
        payment_method VARCHAR(20)
    );