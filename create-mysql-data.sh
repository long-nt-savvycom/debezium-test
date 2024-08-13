#!/bin/bash

# Define MySQL credentials
USER="root"
PASSWORD="root"
DATABASE="test_db"

# Define MySQL commands
COMMAND1="CREATE TABLE IF NOT EXISTS customers (id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(50) NOT NULL UNIQUE, email VARCHAR(100) NOT NULL UNIQUE, password_hash VARCHAR(255) NOT NULL, first_name VARCHAR(50), last_name VARCHAR(50), created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);"
COMMAND2="INSERT INTO customers (username, email, password_hash, first_name, last_name) VALUES ('jdoe', 'jdoe@example.com', 'hash_of_password_1', 'John', 'Doe');"
COMMAND3="SELECT * FROM customers;"

# Execute MySQL commands inside the Docker container
docker exec -i mysql-source mysql -u "$USER" -p"$PASSWORD" -D "$DATABASE" -e "$COMMAND1"
docker exec -i mysql-source mysql -u "$USER" -p"$PASSWORD" -D "$DATABASE" -e "$COMMAND2"
docker exec -i mysql-source mysql -u "$USER" -p"$PASSWORD" -D "$DATABASE" -e "$COMMAND3"
