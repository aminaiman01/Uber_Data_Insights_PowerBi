\copy uber_data FROM 'C:\Users\user\Downloads\UBER DATASET\ncr_ride_bookings.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy uber_data FROM 'C:\Users\user\Downloads\UBER DATASET\ncr_ride_bookings.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'null');
