-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 22, 2025 at 10:52 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rentalcar`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `all_car_booking_details`
-- (See below for the actual view)
--
CREATE TABLE `all_car_booking_details` (
`booking_id` int(11)
,`status` varchar(50)
,`pickup_date` date
,`drop_date` date
,`car_id` int(11)
,`point_id` int(11)
,`person_id` int(11)
,`driver_id` int(11)
,`FirstName` varchar(50)
,`LastName` varchar(50)
,`Name` varchar(100)
,`DOB` date
,`Age` int(11)
,`PhoneNumber` varchar(15)
,`Email` varchar(100)
,`Street` varchar(100)
,`City` varchar(50)
,`State` varchar(50)
,`Zip` varchar(10)
,`CustomerID` int(11)
,`DriverID` int(11)
,`DrivingLicenseNumber` varchar(50)
,`StaffID` int(11)
,`StaffRole` varchar(50)
,`Salary` decimal(10,2)
,`username` text
,`password` text
,`reg_no` varchar(50)
,`car_type` varchar(50)
,`model_id` int(11)
,`photo` varchar(100)
,`model_name` varchar(50)
,`manufacturer` varchar(50)
,`year` varchar(10)
,`cost_id` int(11)
,`amount` double
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `all_car_data`
-- (See below for the actual view)
--
CREATE TABLE `all_car_data` (
`CarID` int(11)
,`RegistrationNumber` varchar(50)
,`CarType` varchar(50)
,`Photo` varchar(100)
,`ModelName` varchar(50)
,`Manufacturer` varchar(50)
,`Year` varchar(10)
,`AvailabilityStatus` varchar(20)
,`CostPerDay` double
);

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `pickup_date` date NOT NULL,
  `drop_date` date NOT NULL,
  `car_id` int(11) NOT NULL,
  `point_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `driver_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `status`, `pickup_date`, `drop_date`, `car_id`, `point_id`, `person_id`, `driver_id`) VALUES
(1, 'completed', '2025-01-02', '2025-01-21', 1, 1, 1, NULL),
(2, 'completed', '2025-01-02', '2025-01-23', 4, 1, 4, NULL),
(3, 'completed', '2025-01-02', '2025-01-20', 5, 2, 7, NULL),
(4, 'completed', '2025-01-03', '2025-01-24', 10, 3, 10, 5),
(5, 'completed', '2025-01-08', '2025-01-25', 16, 1, 11, NULL),
(6, 'completed', '2025-01-14', '2025-01-23', 3, 2, 14, NULL),
(7, 'completed', '2025-01-17', '2025-01-26', 15, 3, 1, NULL),
(8, 'completed', '2025-01-14', '2025-01-28', 19, 2, 18, NULL),
(43, 'onGoing', '2025-01-23', '2025-01-25', 5, 1, 1, NULL),
(44, 'cancelled', '2025-01-23', '2025-01-26', 9, 1, 1, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `booking_by_user`
-- (See below for the actual view)
--
CREATE TABLE `booking_by_user` (
`PersonID` int(11)
,`Name` varchar(100)
,`Total_booking` bigint(21)
,`Total_payment` double
);

-- --------------------------------------------------------

--
-- Table structure for table `caravailability`
--

CREATE TABLE `caravailability` (
  `availability_id` int(11) NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `caravailability`
--

INSERT INTO `caravailability` (`availability_id`, `status`) VALUES
(1, 'Available'),
(2, 'Unavailable'),
(3, 'In Maintenance');

-- --------------------------------------------------------

--
-- Stand-in structure for view `cardetails`
-- (See below for the actual view)
--
CREATE TABLE `cardetails` (
`CarID` int(11)
,`RegistrationNumber` varchar(50)
,`CarType` varchar(50)
,`ModelName` varchar(50)
,`Manufacturer` varchar(50)
,`Year` varchar(10)
);

-- --------------------------------------------------------

--
-- Table structure for table `carmodel`
--

CREATE TABLE `carmodel` (
  `model_id` int(11) NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `model_name` varchar(50) NOT NULL,
  `manufacturer` varchar(50) NOT NULL,
  `year` varchar(10) NOT NULL,
  `cost_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carmodel`
--

INSERT INTO `carmodel` (`model_id`, `photo`, `model_name`, `manufacturer`, `year`, `cost_id`) VALUES
(1, 'https://drive.google.com/uc?export=view&id=18Wfq5AFZmqr6gcalTPck8To3Y9LXqY48', 'Civic', 'Honda', '2000', 2),
(2, 'https://drive.google.com/uc?export=view&id=19DR-KeUBrZaGb-0aYNTH7jKn2YsMn1hK', 'Corolla', 'Toyota', '2021', 2),
(3, 'https://drive.google.com/uc?export=view&id=1Hmk81r61SO7uqOVfJkZD2O2z2KmWyrlB', 'Model S', 'Tesla', '2023', 3),
(4, 'https://drive.google.com/uc?export=view&id=1_ojsUygxK-0b79t1gJoNg3kS29nMJjTs', 'Mustang', 'Ford', '2020', 4),
(5, 'https://drive.google.com/uc?export=view&id=13DI3YSpdj_zRxkRJAm4MqWP34ESXsV4T', 'Camry', 'Toyota', '2019', 1),
(6, 'https://drive.google.com/uc?export=view&id=1Y4jseIvQNyQPGTWqYjG5NFIk4xdQXpZD', 'CR-V', 'Honda', '2023', 2),
(8, 'https://drive.google.com/uc?export=view&id=1uhK6hGdAQ7AdVy_wl3viAhx_xYSB2Q2z', 'Model S', 'Tesla', '2023', 3),
(9, 'https://drive.google.com/uc?export=view&id=1YrJEY4EOhyPCQl_Oz5rOcE4S8pXAhx7j', 'Corolla', 'Toyota', '2023', 2),
(10, 'https://drive.google.com/uc?export=view&id=1XvZTYV16xnTlPXfmjIWG2kycmfSRMMX8', 'Camry', 'Toyota', '2022', 2),
(11, 'https://drive.google.com/uc?export=view&id=1XvZTYV16xnTlPXfmjIWG2kycmfSRMMX8', 'F-150', 'Ford', '2023', 4),
(12, 'https://drive.google.com/uc?export=view&id=1XvZTYV16xnTlPXfmjIWG2kycmfSRMMX8', 'Explorer', 'Ford', '2022', 4),
(15, 'https://drive.google.com/uc?export=view&id=19DR-KeUBrZaGb-0aYNTH7jKn2YsMn1hK', 'Wrangler', 'Jeep', '2022', 2),
(16, 'https://drive.google.com/uc?export=view&id=1Hmk81r61SO7uqOVfJkZD2O2z2KmWyrlB', 'Altima', 'Nissan', '2023', 4),
(17, 'https://drive.google.com/uc?export=view&id=1_ojsUygxK-0b79t1gJoNg3kS29nMJjTs', 'Sentra', 'Nissan', '2022', 3),
(18, 'https://drive.google.com/uc?export=view&id=13DI3YSpdj_zRxkRJAm4MqWP34ESXsV4T', 'Accord', 'Honda', '2023', 3),
(19, 'https://drive.google.com/uc?export=view&id=1Y4jseIvQNyQPGTWqYjG5NFIk4xdQXpZD', 'CX-5', 'Mazda', '2023', 3),
(20, 'https://drive.google.com/uc?export=view&id=1uhK6hGdAQ7AdVy_wl3viAhx_xYSB2Q2z', 'Outback', 'Subaru', '2023', 3);

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `car_id` int(11) NOT NULL,
  `reg_no` varchar(50) NOT NULL,
  `car_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`car_id`, `reg_no`, `car_type`) VALUES
(1, 'ABC123', 'Sedan'),
(2, 'DEF456', 'SUV'),
(3, 'GHI789', 'Electric'),
(4, 'JKL012', 'Coupe'),
(5, 'MNO345', 'Sedan'),
(6, 'REG201', 'SUV'),
(7, 'REG202', 'Sedan'),
(8, 'REG203', 'Electric'),
(9, 'REG204', 'Sedan'),
(10, 'REG205', 'Sedan'),
(11, 'REG206', 'Pickup'),
(12, 'REG207', 'SUV'),
(13, 'REG208', 'Sports Car'),
(14, 'REG209', 'SUV'),
(15, 'REG210', 'Off-Road'),
(16, 'REG211', 'Sedan'),
(17, 'REG212', 'Compact'),
(18, 'REG213', 'Sedan'),
(19, 'REG214', 'Crossover'),
(20, 'REG215', 'Station Wagon');

-- --------------------------------------------------------

--
-- Stand-in structure for view `car_payment_details`
-- (See below for the actual view)
--
CREATE TABLE `car_payment_details` (
`person_id` int(11)
,`car_id` int(11)
,`payment_type` varchar(100)
,`pay_amount` double
,`model_name` varchar(50)
,`payment_date` date
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `car_ratings_detail`
-- (See below for the actual view)
--
CREATE TABLE `car_ratings_detail` (
`person_id` int(11)
,`Name` varchar(100)
,`ratings` int(11)
,`comment` varchar(500)
,`review_date` date
,`model_id` int(11)
,`model_name` varchar(50)
,`manufacturer` varchar(50)
,`year` varchar(10)
,`photo` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `has_availability`
--

CREATE TABLE `has_availability` (
  `car_id` int(11) NOT NULL,
  `availability_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `has_availability`
--

INSERT INTO `has_availability` (`car_id`, `availability_id`) VALUES
(1, 1),
(2, 1),
(3, 3),
(4, 1),
(5, 2),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 3),
(12, 3),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 3);

-- --------------------------------------------------------

--
-- Table structure for table `has_model`
--

CREATE TABLE `has_model` (
  `car_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `has_model`
--

INSERT INTO `has_model` (`car_id`, `model_id`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(9, 1),
(10, 2),
(11, 3),
(12, 4),
(13, 5),
(14, 6),
(16, 8),
(17, 9),
(18, 10),
(19, 11),
(20, 12);

-- --------------------------------------------------------

--
-- Table structure for table `has_review`
--

CREATE TABLE `has_review` (
  `review_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `has_review`
--

INSERT INTO `has_review` (`review_id`, `booking_id`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8);

-- --------------------------------------------------------

--
-- Stand-in structure for view `high_ratedcars`
-- (See below for the actual view)
--
CREATE TABLE `high_ratedcars` (
`CarID` int(11)
,`ModelName` varchar(50)
,`OverAll_ratings` decimal(14,4)
);

-- --------------------------------------------------------

--
-- Table structure for table `hirepoint`
--

CREATE TABLE `hirepoint` (
  `point_id` int(11) NOT NULL,
  `point_name` varchar(100) NOT NULL,
  `street` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `zip` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hirepoint`
--

INSERT INTO `hirepoint` (`point_id`, `point_name`, `street`, `state`, `city`, `zip`) VALUES
(1, 'Bus stand-2', '1234 sunset', 'California', 'Los Angeles', '9999'),
(2, 'Gas Station', '333/A', 'Austin', 'Texas', '9979'),
(3, 'New Rail Station', '8/11 Street', 'New York ', 'New York City', '9980');

-- --------------------------------------------------------

--
-- Table structure for table `maintenance`
--

CREATE TABLE `maintenance` (
  `maintenance_id` int(11) NOT NULL,
  `maintenance_type` varchar(100) NOT NULL,
  `comments` varchar(100) NOT NULL,
  `maintenance_date` date NOT NULL,
  `maintenance_cost` double NOT NULL,
  `car_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `maintenance`
--

INSERT INTO `maintenance` (`maintenance_id`, `maintenance_type`, `comments`, `maintenance_date`, `maintenance_cost`, `car_id`) VALUES
(1, 'Scheduled Maintenance', 'Routine check-ups like oil changes, tire rotations, and brake inspections based on the vehicle\'s mil', '2025-01-02', 1500, 3),
(2, 'Emergency Repairs', 'engine repair and battery replacement.', '2025-01-03', 50000, 11),
(3, 'Cleaning and Detailing', 'Regular cleaning, vacuuming, and detailing of vehicles to maintain a professional appearance.', '2025-01-10', 5000, 12),
(4, 'Part Replacement', 'Replacing worn-out parts like tires, brake pads, and windshield wipers.', '2025-01-10', 12000, 19),
(5, 'Inspection and Certification', 'Periodic vehicle inspections to ensure compliance with legal and safety standards.', '2025-01-20', 3000, 20);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `pay_amount` double NOT NULL,
  `payment_date` date NOT NULL,
  `payment_type` varchar(100) NOT NULL,
  `booking_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `pay_amount`, `payment_date`, `payment_type`, `booking_id`) VALUES
(1, 80000, '2025-01-02', 'Cash', 1),
(2, 176000, '2025-01-02', 'Card', 2),
(3, 38000, '2025-01-02', 'Cash', 3),
(4, 88000, '2025-01-03', 'Cash', 4),
(5, 108000, '2025-01-08', 'Card', 5),
(6, 40000, '2025-01-14', 'Online', 6),
(7, 100000, '2025-01-17', 'Cash', 7),
(8, 60000, '2025-01-14', 'Online', 8),
(23, 4000, '2025-01-23', 'Cash', 43);

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE `person` (
  `PersonID` int(11) NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Street` varchar(100) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `Zip` varchar(10) DEFAULT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `DriverID` int(11) DEFAULT NULL,
  `DrivingLicenseNumber` varchar(50) DEFAULT NULL,
  `StaffID` int(11) DEFAULT NULL,
  `StaffRole` varchar(50) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL DEFAULT '1234'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`PersonID`, `FirstName`, `LastName`, `Name`, `DOB`, `Age`, `PhoneNumber`, `Email`, `Street`, `City`, `State`, `Zip`, `CustomerID`, `DriverID`, `DrivingLicenseNumber`, `StaffID`, `StaffRole`, `Salary`, `username`, `password`) VALUES
(1, 'John', 'Doe', 'John Doe', '1985-06-15', 39, '123-456-7890', 'john.doe@example.com', '123 Elm St', 'Springfield', 'IL', '62701', 1, NULL, NULL, NULL, NULL, NULL, 'john', '1234'),
(2, 'Jane', 'Smith', 'Jane Smith', '1992-09-20', 32, '987-654-3210', 'jane.smith@example.com', '456 Oak Ave', 'Greenfield', 'WI', '53220', NULL, 1, 'DL12345', NULL, NULL, NULL, 'jane', '1234'),
(3, 'Michael', 'Johnson', 'Michael Johnson', '1980-02-11', 45, '555-123-4567', 'michael.j@example.com', '789 Pine Rd', 'Centerville', 'OH', '45459', NULL, NULL, NULL, 1, 'Admin', 85000.00, 'michael', '1234'),
(4, 'Emily', 'Davis', 'Emily Davis', '1995-07-04', 29, '444-555-6666', 'emily.davis@example.com', '321 Maple St', 'Fairfield', 'CA', '94533', 2, NULL, NULL, NULL, NULL, NULL, 'emily', '1234'),
(5, 'David', 'Brown', 'David Brown', '1988-11-12', 36, '111-222-3333', 'david.brown@example.com', '987 Cedar Ln', 'Bridgeport', 'CT', '06604', NULL, 2, 'DL67890', NULL, NULL, NULL, 'david', '1234'),
(6, 'Sarah', 'Wilson', 'Sarah Wilson', '1990-03-08', 34, '222-333-4444', 'sarah.wilson@example.com', '654 Birch Blvd', 'Riverview', 'FL', '33578', NULL, NULL, NULL, 2, 'Admin', 50000.00, 'sarah', '1234'),
(7, 'James', 'Anderson', 'James Anderson', '1983-12-22', 41, '333-444-5555', 'james.anderson@example.com', '432 Walnut Ct', 'Hometown', 'PA', '15146', 3, NULL, NULL, NULL, NULL, NULL, 'james', '1234'),
(8, 'Laura', 'Martinez', 'Laura Martinez', '1978-05-14', 46, '444-555-6667', 'laura.martinez@example.com', '876 Chestnut St', 'Pleasantville', 'NY', '10570', NULL, 3, 'DL54321', NULL, NULL, NULL, 'laura', '1234'),
(9, 'Robert', 'Taylor', 'Robert Taylor', '1997-08-19', 27, '555-666-7778', 'robert.taylor@example.com', '123 Spruce St', 'Lakeside', 'TX', '76108', NULL, NULL, NULL, 3, 'Admin', 45000.00, 'robert', '1234'),
(10, 'Olivia', 'Moore', 'Olivia Moore', '1986-01-30', 38, '666-777-8889', 'olivia.moore@example.com', '987 Hickory Dr', 'Summit', 'NJ', '07901', 4, NULL, NULL, NULL, NULL, NULL, 'olivia', '1234'),
(11, 'Israt', 'Jahan', 'Israt Jahan', '1985-06-15', 39, '123-456-7890', 'Israt.doe@example.com', '123 Elm St', 'Springfield', 'IL', '62701', 5, NULL, NULL, NULL, NULL, NULL, 'Israt', '1234'),
(12, 'Sumaia', 'Islam', 'Sumaia Islam', '1992-09-20', 32, '987-654-3210', 'Sumaia.smith@example.com', '456 Oak Ave', 'Greenfield', 'WI', '53220', NULL, 4, 'DL12325', NULL, NULL, NULL, 'Sumaia', '1234'),
(13, 'Mehedi', 'Hasan', 'Mehedi Hasan', '1980-02-11', 45, '555-123-4567', 'Mehedi.j@example.com', '789 Pine Rd', 'Centerville', 'OH', '45459', NULL, NULL, NULL, 4, 'Admin', 85000.00, 'Mehedi', '1234'),
(14, 'Sanaya', 'Amin', 'Sanaya Amin', '1995-07-04', 29, '444-555-6666', 'Sanaya.davis@example.com', '321 Maple St', 'Fairfield', 'CA', '94533', 6, NULL, NULL, NULL, NULL, NULL, 'Sanaya', '1234'),
(15, 'Sana', 'Rahman', 'Sana Rahman', '1988-11-12', 36, '111-222-3333', 'Sana.brown@example.com', '987 Cedar Ln', 'Bridgeport', 'CT', '06604', NULL, 5, 'DL63440', NULL, NULL, NULL, 'Sana', '1234'),
(16, 'Saif', 'Islam', 'Saif Islam', '2001-01-29', 23, '222-333-4444', 'saif@example.com', '654 Birch Blvd', 'Riverview', 'FL', '33578', NULL, NULL, NULL, 0, '', 0.00, 'xhafan', '1234'),
(17, 'Mubasshir', 'Chowdhury', 'Mubasshir Chowdhury', '1983-12-22', 41, '333-444-5555', 'Mubasshir.anderson@example.com', '432 Walnut Ct', 'Hometown', 'PA', '15146', 7, NULL, NULL, NULL, NULL, NULL, 'Mubasshir', '1234'),
(18, 'Nayna', 'Sarker', 'Nayna Sarker', '1978-05-14', 46, '444-555-6667', 'Nayna.martinez@example.com', '876 Chestnut St', 'Pleasantville', 'NY', '10570', 8, 0, '', NULL, NULL, NULL, 'Nayna', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `rentalcost`
--

CREATE TABLE `rentalcost` (
  `cost_id` int(11) NOT NULL,
  `amount` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rentalcost`
--

INSERT INTO `rentalcost` (`cost_id`, `amount`) VALUES
(1, 2000),
(2, 4000),
(3, 6000),
(4, 8000),
(5, 2000);

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `report_id` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  `report_date` date NOT NULL,
  `status` varchar(100) NOT NULL,
  `booking_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `report`
--

INSERT INTO `report` (`report_id`, `description`, `report_date`, `status`, `booking_id`) VALUES
(1, 'The rented vehicle was in poor condition upon pickup. The car had visible dents and scratches,  the ', '2025-01-24', 'Completed', 4),
(2, 'Vehicle did not work properly , stopped several times in the road ', '2025-01-25', 'In Progress', 5),
(3, 'the vehicle got in to a accident on the last day , no body injured , but the break didnot work prope', '2025-01-26', 'Pending', 7);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `review_id` int(11) NOT NULL,
  `ratings` int(11) NOT NULL,
  `comment` varchar(500) NOT NULL,
  `review_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`review_id`, `ratings`, `comment`, `review_date`) VALUES
(1, 5, 'Very good , best car', '2025-01-21'),
(2, 4, 'Nice , enjoyed the ride', '2025-01-23'),
(3, 5, 'excellent , i will book again from this car', '2025-01-20'),
(4, 1, 'Very bad !! i will complain ', '2025-01-24'),
(5, 1, 'Our vehicle got malfunctioned ', '2025-01-25'),
(6, 3, 'so so , check car carefully before renting ', '2025-01-23'),
(7, 2, 'Occurred accident ', '2025-01-26'),
(8, 3, 'Good ', '2025-01-28');

-- --------------------------------------------------------

--
-- Structure for view `all_car_booking_details`
--
DROP TABLE IF EXISTS `all_car_booking_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all_car_booking_details`  AS SELECT `booking`.`booking_id` AS `booking_id`, `booking`.`status` AS `status`, `booking`.`pickup_date` AS `pickup_date`, `booking`.`drop_date` AS `drop_date`, `booking`.`car_id` AS `car_id`, `booking`.`point_id` AS `point_id`, `booking`.`person_id` AS `person_id`, `booking`.`driver_id` AS `driver_id`, `person`.`FirstName` AS `FirstName`, `person`.`LastName` AS `LastName`, `person`.`Name` AS `Name`, `person`.`DOB` AS `DOB`, `person`.`Age` AS `Age`, `person`.`PhoneNumber` AS `PhoneNumber`, `person`.`Email` AS `Email`, `person`.`Street` AS `Street`, `person`.`City` AS `City`, `person`.`State` AS `State`, `person`.`Zip` AS `Zip`, `person`.`CustomerID` AS `CustomerID`, `person`.`DriverID` AS `DriverID`, `person`.`DrivingLicenseNumber` AS `DrivingLicenseNumber`, `person`.`StaffID` AS `StaffID`, `person`.`StaffRole` AS `StaffRole`, `person`.`Salary` AS `Salary`, `person`.`username` AS `username`, `person`.`password` AS `password`, `cars`.`reg_no` AS `reg_no`, `cars`.`car_type` AS `car_type`, `carmodel`.`model_id` AS `model_id`, `carmodel`.`photo` AS `photo`, `carmodel`.`model_name` AS `model_name`, `carmodel`.`manufacturer` AS `manufacturer`, `carmodel`.`year` AS `year`, `rentalcost`.`cost_id` AS `cost_id`, `rentalcost`.`amount` AS `amount` FROM (((((`booking` join `person` on(`booking`.`person_id` = `person`.`PersonID`)) join `cars` on(`booking`.`car_id` = `cars`.`car_id`)) join `has_model` on(`has_model`.`car_id` = `booking`.`car_id`)) join `carmodel` on(`carmodel`.`model_id` = `has_model`.`model_id`)) join `rentalcost` on(`rentalcost`.`cost_id` = `carmodel`.`cost_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `all_car_data`
--
DROP TABLE IF EXISTS `all_car_data`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all_car_data`  AS SELECT `cars`.`car_id` AS `CarID`, `cars`.`reg_no` AS `RegistrationNumber`, `cars`.`car_type` AS `CarType`, `carmodel`.`photo` AS `Photo`, `carmodel`.`model_name` AS `ModelName`, `carmodel`.`manufacturer` AS `Manufacturer`, `carmodel`.`year` AS `Year`, `caravailability`.`status` AS `AvailabilityStatus`, `rentalcost`.`amount` AS `CostPerDay` FROM (((((`cars` join `has_model` on(`cars`.`car_id` = `has_model`.`car_id`)) join `carmodel` on(`has_model`.`model_id` = `carmodel`.`model_id`)) join `has_availability` on(`cars`.`car_id` = `has_availability`.`car_id`)) join `caravailability` on(`has_availability`.`availability_id` = `caravailability`.`availability_id`)) join `rentalcost` on(`carmodel`.`cost_id` = `rentalcost`.`cost_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `booking_by_user`
--
DROP TABLE IF EXISTS `booking_by_user`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `booking_by_user`  AS SELECT `booking`.`person_id` AS `PersonID`, `person`.`Name` AS `Name`, count(0) AS `Total_booking`, sum(`payment`.`pay_amount`) AS `Total_payment` FROM ((`booking` join `payment` on(`booking`.`booking_id` = `payment`.`booking_id`)) join `person` on(`person`.`PersonID` = `booking`.`person_id`)) GROUP BY `booking`.`person_id` ;

-- --------------------------------------------------------

--
-- Structure for view `cardetails`
--
DROP TABLE IF EXISTS `cardetails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cardetails`  AS SELECT `cars`.`car_id` AS `CarID`, `cars`.`reg_no` AS `RegistrationNumber`, `cars`.`car_type` AS `CarType`, `carmodel`.`model_name` AS `ModelName`, `carmodel`.`manufacturer` AS `Manufacturer`, `carmodel`.`year` AS `Year` FROM ((`cars` join `has_model` on(`cars`.`car_id` = `has_model`.`car_id`)) join `carmodel` on(`has_model`.`model_id` = `carmodel`.`model_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `car_payment_details`
--
DROP TABLE IF EXISTS `car_payment_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `car_payment_details`  AS SELECT `booking`.`person_id` AS `person_id`, `booking`.`car_id` AS `car_id`, `payment`.`payment_type` AS `payment_type`, `payment`.`pay_amount` AS `pay_amount`, `carmodel`.`model_name` AS `model_name`, `payment`.`payment_date` AS `payment_date` FROM (((`booking` join `payment` on(`booking`.`booking_id` = `payment`.`booking_id`)) join `has_model` on(`has_model`.`car_id` = `booking`.`car_id`)) join `carmodel` on(`has_model`.`model_id` = `carmodel`.`model_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `car_ratings_detail`
--
DROP TABLE IF EXISTS `car_ratings_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `car_ratings_detail`  AS SELECT `booking`.`person_id` AS `person_id`, `person`.`Name` AS `Name`, `review`.`ratings` AS `ratings`, `review`.`comment` AS `comment`, `review`.`review_date` AS `review_date`, `carmodel`.`model_id` AS `model_id`, `carmodel`.`model_name` AS `model_name`, `carmodel`.`manufacturer` AS `manufacturer`, `carmodel`.`year` AS `year`, `carmodel`.`photo` AS `photo` FROM (((((`booking` join `person` on(`booking`.`person_id` = `person`.`PersonID`)) join `has_review` on(`booking`.`booking_id` = `has_review`.`booking_id`)) join `review` on(`has_review`.`review_id` = `review`.`review_id`)) join `has_model` on(`has_model`.`car_id` = `booking`.`car_id`)) join `carmodel` on(`carmodel`.`model_id` = `has_model`.`model_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `high_ratedcars`
--
DROP TABLE IF EXISTS `high_ratedcars`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `high_ratedcars`  AS SELECT `booking`.`car_id` AS `CarID`, `carmodel`.`model_name` AS `ModelName`, avg(`review`.`ratings`) AS `OverAll_ratings` FROM ((((`booking` join `has_review` on(`booking`.`booking_id` = `has_review`.`booking_id`)) join `review` on(`has_review`.`review_id` = `review`.`review_id`)) join `has_model` on(`has_model`.`car_id` = `booking`.`car_id`)) join `carmodel` on(`has_model`.`model_id` = `carmodel`.`model_id`)) GROUP BY `booking`.`car_id` ORDER BY avg(`review`.`ratings`) DESC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `carfk` (`car_id`),
  ADD KEY `personfk` (`person_id`),
  ADD KEY `driveridfk` (`driver_id`),
  ADD KEY `pointfk` (`point_id`);

--
-- Indexes for table `caravailability`
--
ALTER TABLE `caravailability`
  ADD PRIMARY KEY (`availability_id`);

--
-- Indexes for table `carmodel`
--
ALTER TABLE `carmodel`
  ADD PRIMARY KEY (`model_id`),
  ADD KEY ` costidfk` (`cost_id`);

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`car_id`);

--
-- Indexes for table `has_availability`
--
ALTER TABLE `has_availability`
  ADD PRIMARY KEY (`car_id`,`availability_id`),
  ADD KEY `avlfk` (`availability_id`);

--
-- Indexes for table `has_model`
--
ALTER TABLE `has_model`
  ADD PRIMARY KEY (`car_id`,`model_id`),
  ADD KEY `mdelidfk` (`model_id`);

--
-- Indexes for table `has_review`
--
ALTER TABLE `has_review`
  ADD PRIMARY KEY (`review_id`,`booking_id`),
  ADD KEY `reviewbookingidfk` (`booking_id`);

--
-- Indexes for table `hirepoint`
--
ALTER TABLE `hirepoint`
  ADD PRIMARY KEY (`point_id`);

--
-- Indexes for table `maintenance`
--
ALTER TABLE `maintenance`
  ADD PRIMARY KEY (`maintenance_id`),
  ADD KEY `caridmaintainfk` (`car_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `bookingpayidfk` (`booking_id`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`PersonID`);

--
-- Indexes for table `rentalcost`
--
ALTER TABLE `rentalcost`
  ADD PRIMARY KEY (`cost_id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `bkidfk` (`booking_id`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`review_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `caravailability`
--
ALTER TABLE `caravailability`
  MODIFY `availability_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `carmodel`
--
ALTER TABLE `carmodel`
  MODIFY `model_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `car_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `hirepoint`
--
ALTER TABLE `hirepoint`
  MODIFY `point_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `maintenance`
--
ALTER TABLE `maintenance`
  MODIFY `maintenance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `person`
--
ALTER TABLE `person`
  MODIFY `PersonID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `rentalcost`
--
ALTER TABLE `rentalcost`
  MODIFY `cost_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `carbkfk` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `driveridfk` FOREIGN KEY (`driver_id`) REFERENCES `person` (`PersonID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `persdbkfk` FOREIGN KEY (`person_id`) REFERENCES `person` (`PersonID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pointfk` FOREIGN KEY (`point_id`) REFERENCES `hirepoint` (`point_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `carmodel`
--
ALTER TABLE `carmodel`
  ADD CONSTRAINT ` costidfk` FOREIGN KEY (`cost_id`) REFERENCES `rentalcost` (`cost_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `has_availability`
--
ALTER TABLE `has_availability`
  ADD CONSTRAINT `avlfk` FOREIGN KEY (`availability_id`) REFERENCES `caravailability` (`Availability_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `caravlidfk` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `has_model`
--
ALTER TABLE `has_model`
  ADD CONSTRAINT `caridfk` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mdelidfk` FOREIGN KEY (`model_id`) REFERENCES `carmodel` (`model_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `has_review`
--
ALTER TABLE `has_review`
  ADD CONSTRAINT `reviewbookingidfk` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reviewidfk` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `maintenance`
--
ALTER TABLE `maintenance`
  ADD CONSTRAINT `caridmaintainfk` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `bookingpayidfk` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `bkidfk` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
