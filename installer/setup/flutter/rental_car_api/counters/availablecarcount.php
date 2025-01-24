<?php
include '../db.php';

$sql = "SELECT count(*) as count FROM all_car_data where AvailabilityStatus='Available';";
$result = $conn->query($sql);

$users = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $users[] = $row;
    }
}

echo json_encode($users);

$conn->close();
?>

