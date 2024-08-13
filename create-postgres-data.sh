#!/bin/bash

# Define PostgreSQL credentials
USER="postgres"
PASSWORD="postgres"
DATABASE="postgres"

# Define PostgreSQL commands
COMMAND1="CREATE TABLE IF NOT EXISTS public.users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);"
COMMAND2="INSERT INTO public.users (username, email, password_hash, first_name, last_name) VALUES 
    ('jdoe', 'jdoe@example.com', 'hash_of_password_1', 'John', 'Doe'),
    ('asmith', 'asmith@example.com', 'hash_of_password_2', 'Alice', 'Smith'),
    ('mbrown', 'mbrown@example.com', 'hash_of_password_3', 'Michael', 'Brown');"
COMMAND3="SELECT * FROM public.users;"

# Execute PostgreSQL commands inside the Docker container
docker exec -i postgres psql -U "$USER" -d "$DATABASE" -c "$COMMAND1"
docker exec -i postgres psql -U "$USER" -d "$DATABASE" -c "$COMMAND2"
docker exec -i postgres psql -U "$USER" -d "$DATABASE" -c "$COMMAND3"
