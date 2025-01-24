<?php
// Include the database connection file
include 'db.php';


// Get the posted data
$data = json_decode(file_get_contents("php://input"), true);

$PersonID = $data['PersonID'];
//$CarType = 'SUV';

$sql = "SELECT 
    report.report_id,
    report.description,
    report.report_date,
    report.status,
    report.booking_id,
    booking.person_id
FROM 
    report
JOIN 
    booking 
    ON report.booking_id = booking.booking_id
WHERE 
    booking.person_id = $PersonID;";
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
