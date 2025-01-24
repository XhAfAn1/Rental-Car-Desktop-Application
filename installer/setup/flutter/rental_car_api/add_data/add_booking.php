<?php
include '../db.php';
$data = json_decode(file_get_contents('php://input'), true);

//$booking_id = $data['booking_id'];
$status = $data['status'];
$pickup_date = $data['pickup_date'];
$drop_date = $data['drop_date'];
$car_id = $data['car_id'];
$point_id = $data['point_id'];
$person_id = $data['person_id'];
$driver_id = isset($data['driver_id']) ? $data['driver_id'] : NULL;

if(isset($data['driver_id'])){
    $sql = "INSERT INTO booking ( status, pickup_date, drop_date, car_id, point_id, person_id, driver_id) 
        VALUES ('$status', '$pickup_date', '$drop_date', '$car_id', '$point_id', '$person_id', '$driver_id')";
}
else{
    $sql = "INSERT INTO booking ( status, pickup_date, drop_date, car_id, point_id, person_id) 
        VALUES ('$status', '$pickup_date', '$drop_date', '$car_id', '$point_id', '$person_id')";
}




if ($conn->query($sql) === TRUE) {
     $booking_id = $conn->insert_id; // Get the last inserted booking ID
    echo json_encode(['success' => true, 'booking_id' => $booking_id]);
} else {
    echo json_encode(["success" => false, "error" => $conn->error]);
}
?>