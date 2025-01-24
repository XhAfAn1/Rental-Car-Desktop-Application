<?php
include '../db.php';
$data = json_decode(file_get_contents('php://input'), true);

// Validate and sanitize input
$booking_id = isset($data['booking_id']) ? (int)$data['booking_id'] : 0;
$car_availability = isset($data['car_availability']) ? (int)$data['car_availability'] : 0;
$status = isset($data['status']) ? $conn->real_escape_string($data['status']) : '';

if ($booking_id > 0 && !empty($status) && $car_availability > 0) {
    $sql = "UPDATE booking 
            JOIN has_availability ON booking.car_id = has_availability.car_id 
            SET booking.status = '$status', 
                has_availability.availability_id = $car_availability 
            WHERE booking.booking_id = $booking_id";

    try {
        if ($conn->query($sql) === TRUE) {
            echo json_encode(['success' => true, 'message' => 'Booking and availability updated successfully.']);
        } else {
            echo json_encode(['success' => false, 'error' => $conn->error]);
        }
    } catch (mysqli_sql_exception $e) {
        echo json_encode(['success' => false, 'error' => $e->getMessage()]);
    }
} else {
    echo json_encode(['success' => false, 'error' => 'Invalid input data.']);
}

$conn->close();
?>
