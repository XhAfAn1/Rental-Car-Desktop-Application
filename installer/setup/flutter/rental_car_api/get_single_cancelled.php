<?php
// Include the database connection file
include 'db.php';

// Retrieve the posted data
$data = json_decode(file_get_contents("php://input"), true);

// Validate input
if (!isset($data['PersonID'])) {
    echo json_encode(["error" => "PersonID is required."]);
    exit;
}

$PersonID = $conn->real_escape_string($data['PersonID']); // Sanitize input to prevent SQL injection

// Prepare the SQL query
$sql = "SELECT * FROM all_car_booking_details WHERE person_id = ? AND status = 'cancelled'";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $PersonID);

// Execute the query
$stmt->execute();
$result = $stmt->get_result();

// Fetch results
$cars = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $cars[] = $row;
    }
}

// Return the results as JSON
echo json_encode($cars);

// Close connections
$stmt->close();
$conn->close();
?>
