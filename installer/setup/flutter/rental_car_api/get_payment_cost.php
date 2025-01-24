<?php
// Include the database connection file
include 'db.php';

// Set the header to return JSON
header('Content-Type: application/json');

// Get the posted data
$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['booking_id']) || !is_numeric($data['booking_id'])) {
    echo json_encode([
        'success' => false,
        'error' => 'Invalid or missing booking ID.'
    ]);
    exit;
}

$bookingId = intval($data['booking_id']);

try {
    // Prepare the SQL statement to prevent SQL injection
    $sql = "
        SELECT 
            (DATEDIFF(drop_date, pickup_date) * rentalcost.amount) AS total_cost
        FROM 
            booking 
        JOIN 
            has_model ON booking.car_id = has_model.car_id
        JOIN 
            carmodel ON has_model.model_id = carmodel.model_id
        JOIN 
            rentalcost ON carmodel.cost_id = rentalcost.cost_id
        WHERE 
            booking.booking_id = ?
    ";

    // Use prepared statements
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $bookingId);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $car = $result->fetch_assoc();
        echo json_encode([
            'success' => true,
            'total_cost' => $car['total_cost']
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'error' => 'No booking found with the given ID.'
        ]);
    }
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
} finally {
    // Close the database connection
    $conn->close();
}
?>
