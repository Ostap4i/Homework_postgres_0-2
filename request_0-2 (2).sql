


---------- DROP TABLES ----------

DROP TABLE IF EXISTS doctors_examinations;
DROP TABLE IF EXISTS wards;
DROP TABLE IF EXISTS donations;

DROP TABLE IF EXISTS interns;
DROP TABLE IF EXISTS diseases;
DROP TABLE IF EXISTS professors;

DROP TABLE IF EXISTS sponsors;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS examinations;




-------CREATE TABLES-------

CREATE TABLE Departments (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) UNIQUE NOT NULL,
	building INT NOT NULL CHECK(building BETWEEN 1 AND 5),
	financing INT NOT NULL DEFAULT 0 CHECK (financing >= 0)
);

CREATE TABLE Doctors (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL CHECK(name <> ''),
	surname VARCHAR(1000) NOT NULL CHECK(surname <> ''),
	premium INT NOT NULL DEFAULT 0 CHECK(premium > -1),
    salary INT NOT NULL CHECK(salary > 0)
);

CREATE TABLE Examinations (
	id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE CHECK (name <> '')
);

CREATE TABLE sponsors (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE diseases (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE interns (
	id SERIAL PRIMARY KEY,
	doctor_id INT NOT NULL REFERENCES doctors(id) ON DELETE CASCADE
);

CREATE TABLE professors (
	id SERIAL PRIMARY KEY,
	doctor_id INT NOT NULL REFERENCES doctors(id) ON DELETE CASCADE
);



CREATE TABLE donations (
	id SERIAL PRIMARY KEY,
    amount INT NOT NULL CHECK (amount > 0),
    don_date DATE NOT NULL,
    department_id INT NOT NULL REFERENCES departments(id) ON DELETE CASCADE,
    sponsor_id INT NOT NULL REFERENCES sponsors(id) ON DELETE CASCADE
);

CREATE TABLE wards (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE CHECK (name <> ''),
    places INT NOT NULL CHECK (places > 0),
    department_id INT NOT NULL REFERENCES departments(id)
);

CREATE TABLE doctors_examinations (
	id SERIAL PRIMARY KEY,
    doctor_id INT NOT NULL REFERENCES doctors(id) ON DELETE CASCADE,
	
    start_time TIME NOT NULL CHECK (start_time >= '08:00' AND start_time <= '18:00'),
    end_time TIME NOT NULL CHECK (end_time > start_time),
	ex_date DATE NOT NULL CHECK (ex_date < NOW()),
	
	disease_id INT NOT NULL REFERENCES diseases(id),
    examination_id INT NOT NULL,
    ward_id INT NOT NULL REFERENCES wards(id)
);

---------- INSERT INTO TABLES ----------

-- Buildings
INSERT INTO departments (name, building, financing) VALUES
  ('Cardiology', 4, 10000.00),
  ('Gastroenterology', 2, 15000.00),
  ('General Surgery', 3, 20000.00),
  ('Microbiology', 1, 25000.00),
  ('Neurology', 5, 30000.00),
  ('Oncology', 3, 12000.00),
  ('Chemistry', 2, 18000.00);

-- Doctors
INSERT INTO doctors (name, surname, premium, salary) VALUES
  ('Anthony', 'Davis', 1300.00, 6000.00),
  ('Joshua', 'Bell', 1500.00, 6000.00),
  ('Michael', 'Johnson', 2000.00, 7000.00),
  ('Thomas', 'Gerada', 1200.00, 5500.00),
  ('John', 'Doe', 1800.00, 6500.00);

-- Examinations
INSERT INTO examinations (name) VALUES
  ('Blood Test'),
  ('X-ray'),
  ('MRI'),
  ('Ultrasound');

-- Sponsors
INSERT INTO sponsors (name) VALUES
  ('Sponsor 1'),
  ('Sponsor 2'),
  ('Sponsor 3');



-- Diseases
INSERT INTO diseases (name) VALUES 
  ('Flu'),
  ('Common Cold'),
  ('Pneumonia'),
  ('Astma');

-- Interns
INSERT INTO interns (doctor_id) VALUES 
  (1),
  (2);

-- Professors
INSERT INTO professors (doctor_id) VALUES 
  (3),
  (4);




-- Donations
INSERT INTO donations (amount, don_date, department_id, sponsor_id) VALUES
  (100, '2024-04-23', 1, 1),
  (200, '2024-04-22', 2, 1),
  (150, '2024-04-21', 4, 3),
  (350, '2024-04-21', 2, 2),
  (400, '2024-04-21', 3, 3),
  (50,  '2024-04-21', 4, 2),
  (300, '2024-04-20', 5, 3);

-- Wards
INSERT INTO wards (name, places, department_id) VALUES
  ('Ward A', 20, 1),
  ('Ward B', 5, 2),
  ('Ward C', 25, 3),
  ('Ward D', 8, 4),
  ('Ward E', 30, 5),
  ('Ward F', 13, 5);

-- Doctors' Examinations
INSERT INTO doctors_examinations (doctor_id, start_time, end_time, ex_date, examination_id, ward_id, disease_id) VALUES
  (1, '09:00', '14:00', '2024-04-26', 1, 1, 1),
  (1, '09:30', '14:00', '2024-03-22', 3, 3, 2),
  (1, '09:00', '14:00', '2024-04-19', 4, 5, 3),
  (2, '10:00', '15:00', '2024-04-24', 2, 3, 1),
  (2, '10:00', '15:00', '2024-03-21', 3, 2, 2),
  (2, '10:00', '15:00', '2024-04-22', 4, 4, 3),
  (3, '11:00', '16:00', '2024-04-11', 3, 5, 1),
  (3, '11:00', '16:00', '2024-03-15', 2, 4, 2),
  (3, '11:00', '16:00', '2024-04-17', 1, 1, 3),
  (4, '12:00', '17:00', '2024-04-18', 3, 3, 1),
  (4, '12:00', '17:00', '2024-04-19', 2, 2, 2),
  (4, '12:00', '17:00', '2024-03-20', 1, 5, 3);

