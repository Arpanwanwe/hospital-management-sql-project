CREATE DATABASE HospitalDB;
USE HospitalDB;

-- Doctor Table
CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100),
    phone VARCHAR(15)
);

-- Patient Table
CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15)
);

-- Appointment Table
CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    reason TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- Billing Table
CREATE TABLE Billing (
    bill_id INT PRIMARY KEY,
    appointment_id INT,
    amount DECIMAL(10,2),
    paid TINYINT(1) DEFAULT 0,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- Insert into Doctor
INSERT INTO Doctor VALUES (1, 'Dr. Asha Mehta', 'Cardiologist', '9876543210');
INSERT INTO Doctor VALUES (2, 'Dr. Rohan Kumar', 'Dermatologist', '9123456780');

-- Insert into Patient
INSERT INTO Patient VALUES (1, 'Raj Verma', 34, 'Male', '9871234560');
INSERT INTO Patient VALUES (2, 'Anita Sharma', 28, 'Female', '9812345670');

-- Insert into Appointment
INSERT INTO Appointment VALUES (1, 1, 1, '2025-06-15', 'Chest pain');
INSERT INTO Appointment VALUES (2, 2, 2, '2025-06-16', 'Skin allergy');

-- Insert into Billing
INSERT INTO Billing VALUES (1, 1, 1500.00, 1);
INSERT INTO Billing VALUES (2, 2, 1200.00, 0);

SELECT * FROM Appointment;

SELECT p.name, b.amount
FROM Billing b
JOIN Appointment a ON b.appointment_id = a.appointment_id
JOIN Patient p ON a.patient_id = p.patient_id
WHERE b.paid = 0;

SELECT d.name AS doctor, COUNT(a.appointment_id) AS total_appointments
FROM Appointment a
JOIN Doctor d ON a.doctor_id = d.doctor_id
GROUP BY d.name;

SELECT SUM(amount) AS total_revenue
FROM Billing
WHERE paid = 1;

DESCRIBE Doctor;
DESCRIBE Patient;
DESCRIBE Appointment;
DESCRIBE Billing;
