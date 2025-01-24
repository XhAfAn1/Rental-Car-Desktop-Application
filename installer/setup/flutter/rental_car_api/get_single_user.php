<?php
// Include the database connection file
include 'db.php';


// Get the posted data
$data = json_decode(file_get_contents("php://input"), true);

$pId = $data['id'];

$sql = "SELECT * FROM person where personId=$pId";
$result = $conn->query($sql);


if ($result->num_rows > 0) {
    $person = $result->fetch_assoc();
    echo json_encode(  $person );
    
}

$conn->close();
?>
