-- 1. Create the database
CREATE DATABASE IF NOT EXISTS clinic_db;
USE clinic_db;

-- 2. Departments (Independent table)
CREATE TABLE department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- 3. Receptionists
CREATE TABLE receptionist (
    receptionist_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20)
) ENGINE=InnoDB;

-- 4. Doctors (Linked to department)
CREATE TABLE doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(department_id)
) ENGINE=InnoDB;

-- 5. Patients
CREATE TABLE patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE
) ENGINE=InnoDB;

-- 6. Appointments (Links patient, doctor, and receptionist)
CREATE TABLE appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    receptionist_id INT,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY (receptionist_id) REFERENCES receptionist(receptionist_id)
) ENGINE=InnoDB;

-- 7. Treatments (Linked to appointments)
CREATE TABLE treatment (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    description TEXT NOT NULL,
    cost DECIMAL(10, 2),
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id)
) ENGINE=InnoDB;

-- 8. Medications
CREATE TABLE medication (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
) ENGINE=InnoDB;

-- 9. Prescriptions (Issued to patients by doctors)
CREATE TABLE prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    issue_date DATE NOT NULL,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
) ENGINE=InnoDB;

-- 10. Prescription_Medication (Join table: many-to-many)
CREATE TABLE prescription_medication (
    prescription_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    frequency VARCHAR(100),
    duration_days INT,
    PRIMARY KEY (prescription_id, medication_id),
    FOREIGN KEY (prescription_id) REFERENCES prescription(prescription_id),
    FOREIGN KEY (medication_id) REFERENCES medication(medication_id)
) ENGINE=InnoDB;
