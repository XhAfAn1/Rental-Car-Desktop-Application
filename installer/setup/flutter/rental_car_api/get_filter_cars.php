<?php
// Include the database connection file
include 'db.php';


// Get the posted data
$data = json_decode(file_get_contents("php://input"), true);

$CarType = $data['type'];
//$CarType = 'SUV';

$sql = "SELECT * FROM all_car_data where CarType ='$CarType' and AvailabilityStatus='Available';";
$result = $conn->query($sql);

$cars = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $cars[] = $row;
    }
}

echo json_encode($cars);

$conn->close();
?>
