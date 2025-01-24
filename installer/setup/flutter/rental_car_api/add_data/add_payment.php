<?php
include '../db.php';
$data = json_decode(file_get_contents('php://input'), true);

// Retrieve input values from the request payload
$booking_id = $data['booking_id'];
$payment_type = $data['payment_type'];
$payment_date = $data['payment_date'];
$payment_amount = $data['payment_amount'];

// Prepare the SQL query with placeholders for prepared statements
$sql = "INSERT INTO payment (pay_amount, payment_date, payment_type, booking_id) 
        VALUES (?, ?, ?, ?)";

// Use a prepared statement to prevent SQL injection
$stmt = $conn->prepare($sql);
$stmt->bind_param('dssi', $payment_amount, $payment_date, $payment_type, $booking_id);

if ($stmt->execute()) {
    $payment_id = $conn->insert_id; // Get the last inserted payment ID
    echo json_encode(['success' => true, 'payment_id' => $payment_id]);
} else {
    echo json_encode(["success" => false, "error" => $stmt->error]);
}

// Close the statement and connection
$stmt->close();
$conn->close();
?>
