SELECT r.driver_id,r.vehicle_make,r.vehicle_model,r.vehicle_year,r.license_plate,r.rating,r.join_date,r.is_active,u.[user_id],u.name,u.email,u.phone,u.city,u.date_joined from silver.drivers r
LEFT JOIN silver.users u on r.[user_id] = u.[user_id]
