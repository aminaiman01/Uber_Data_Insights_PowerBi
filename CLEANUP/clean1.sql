-- change booking_id and customer_id remove " "
-- change status in cancelled_by_customer and cancelled_by_driver to true and false
-- change incomplete_rides to true and false


-- 1) Booking ID cleanup
ALTER TABLE uber_data
ADD COLUMN booking_id_clean TEXT;

UPDATE uber_data
SET booking_id_clean = REPLACE(REPLACE(booking_id, '"', ''), '''', '');

ALTER TABLE uber_data
DROP COLUMN booking_id;

ALTER TABLE uber_data
RENAME COLUMN booking_id_clean TO booking_id;


-- 2) Customer ID cleanup
ALTER TABLE uber_data
ADD COLUMN customer_id_clean TEXT;

UPDATE uber_data
SET customer_id_clean = REPLACE(REPLACE(customer_id, '"', ''), '''', '');

ALTER TABLE uber_data
DROP COLUMN customer_id;

ALTER TABLE uber_data
RENAME COLUMN customer_id_clean TO customer_id;


-- 3) Cancelled by customer → boolean
ALTER TABLE uber_data
ADD COLUMN cancelled_by_customer_clean BOOLEAN;

UPDATE uber_data
SET cancelled_by_customer_clean = 
    CASE WHEN cancelled_by_customer IS NULL THEN FALSE ELSE TRUE END;

ALTER TABLE uber_data
DROP COLUMN cancelled_by_customer;

ALTER TABLE uber_data
RENAME COLUMN cancelled_by_customer_clean TO cancelled_by_customer;


-- 4) Cancelled by driver → boolean
ALTER TABLE uber_data
ADD COLUMN cancelled_by_driver_clean BOOLEAN;

UPDATE uber_data
SET cancelled_by_driver_clean = 
    CASE WHEN cancelled_by_driver IS NULL THEN FALSE ELSE TRUE END;

ALTER TABLE uber_data
DROP COLUMN cancelled_by_driver;

ALTER TABLE uber_data
RENAME COLUMN cancelled_by_driver_clean TO cancelled_by_driver;


-- 5) Incomplete rides → boolean
ALTER TABLE uber_data
ADD COLUMN incomplete_rides_clean BOOLEAN;

UPDATE uber_data
SET incomplete_rides_clean = 
    CASE WHEN incomplete_rides IS NULL THEN FALSE ELSE TRUE END;

ALTER TABLE uber_data
DROP COLUMN incomplete_rides;

ALTER TABLE uber_data
RENAME COLUMN incomplete_rides_clean TO incomplete_rides;


-- 6) Numeric columns cleanup (empty string → NULL)
UPDATE uber_data
SET 
    avg_vtat = NULLIF(avg_vtat, '')::DECIMAL(10,2),
    avg_ctat = NULLIF(avg_ctat, '')::DECIMAL(10,2),
    booking_value = NULLIF(booking_value, '')::DECIMAL(10,2),
    ride_distance = NULLIF(ride_distance, '')::DECIMAL(10,2),
    driver_rating = NULLIF(driver_rating, '')::DECIMAL(3,2),
    customer_rating = NULLIF(customer_rating, '')::DECIMAL(3,2);
