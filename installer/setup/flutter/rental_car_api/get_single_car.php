<?php
// Include the database connection file
include 'db.php';


// Get the posted data
$data = json_decode(file_get_contents("php://input"), true);

$carId = $data['carId'];

$sql = "SELECT * FROM all_car_data where carId=$carId";
$result = $conn->query($sql);


if ($result->num_rows > 0) {
    $car = $result->fetch_assoc();
    echo json_encode($car);
    
}

$conn->close();
?>