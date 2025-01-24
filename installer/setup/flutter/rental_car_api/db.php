<?php
$servername = "localhost";
$username = "root"; // replace with your phpMyAdmin username
$password = ""; // replace with your phpMyAdmin password
$dbname = "rentalcar"; // replace with your database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
