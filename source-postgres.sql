CREATE TABLE public.user (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Insert example records
INSERT INTO public.user (username, email, password_hash, first_name, last_name)
VALUES
    ('jdoe', 'jdoe@example.com', 'hash_of_password_1', 'John', 'Doe'),
    ('asmith', 'asmith@example.com', 'hash_of_password_2', 'Alice', 'Smith'),
    ('mbrown', 'mbrown@example.com', 'hash_of_password_3', 'Michael', 'Brown');
