CREATE TABLE IF NOT EXISTS student (
    id SERIAL PRIMARY KEY,
    second_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    patronymic VARCHAR(50) NOT NULL,
    birthdate DATE,
    phone_number VARCHAR(20),
    email VARCHAR(50),
    telegram VARCHAR(50),
    git VARCHAR(100)
);