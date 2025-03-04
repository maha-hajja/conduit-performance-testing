-- Create the database (if not exists)
CREATE DATABASE IF NOT EXISTS testdb;

-- Use the database
USE testdb;

-- Drop the table if it already exists
DROP TABLE IF EXISTS users;

-- Create the users table
CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(50) NOT NULL,
                       email VARCHAR(100) UNIQUE NOT NULL,
                       first_name VARCHAR(50),
                       last_name VARCHAR(50),
                       phone VARCHAR(20),
                       street VARCHAR(100),
                       city VARCHAR(50),
                       state VARCHAR(50),
                       zip_code VARCHAR(10),
                       country VARCHAR(50),
                       status ENUM('active', 'inactive', 'pending'),
                       subscription_type ENUM('free', 'basic', 'premium', 'enterprise'),
                       last_login DATETIME,
                       created_at DATETIME NOT NULL,
                       age INT,
                       notifications BOOLEAN,
                       newsletter BOOLEAN,
                       theme ENUM('light', 'dark', 'auto'),
                       last_updated DATETIME,
                       device_type ENUM('mobile', 'desktop', 'tablet'),
                       browser ENUM('Chrome', 'Firefox', 'Safari', 'Edge')
);

-- -- Insert sample records into the users table
-- INSERT INTO users
-- (username, email, first_name, last_name, phone, street, city, state, zip_code, country,
--  status, subscription_type, last_login, created_at, age, notifications, newsletter,
--  theme, last_updated, device_type, browser)
-- VALUES
--     ('user1', 'user1@example.com', 'John', 'Doe', '+11234567890', '123 Main St',
--      'New York', 'NY', '10001', 'USA',
--      'active', 'premium', '2024-02-25 12:30:00', '2024-01-15 10:15:00', 30,
--      true, false, 'dark', '2024-02-25 14:00:00', 'desktop', 'Chrome');
--
--
-- -- Display all records in the users table
-- SELECT * FROM users;
