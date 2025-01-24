<?php
// Include the database connection file
include 'db.php';


// Get the posted data
$data = json_decode(file_get_contents("php://input"), true);

$PersonID = $data['PersonID'];
//$CarType = 'SUV';

$sql = "SELECT * FROM review natural join has_review NATURAL join booking where person_id=$PersonID;";
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
