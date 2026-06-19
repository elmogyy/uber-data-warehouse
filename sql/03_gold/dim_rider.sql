SELECT r.rider_id,r.rating,r.total_trips,r.created_at,u.[user_id],u.name,u.email,u.phone,u.city,u.date_joined from silver.riders r
LEFT JOIN silver.users u on r.[user_id] = u.[user_id]
