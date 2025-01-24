<?php
include 'db.php';

$sql = "SELECT * FROM review natural join has_review NATURAL join booking;";
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
