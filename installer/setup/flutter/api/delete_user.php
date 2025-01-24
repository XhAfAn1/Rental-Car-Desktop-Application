<?php
include 'db.php';
$data = json_decode(file_get_contents("php://input"), true);



$id = $data['ID'];
$name = $data['Name'];
$email = $data['Email'];
$phone = $data['Phone'];
$address = $data['Address'];
$dob = $data['DOB'];
$role = $data['role'];
$userActivated = $data['user_activated'];
$password =$data['Password'];

$sql = "DELETE FROM InventoryUser WHERE  id='$id'";

//$conn->query($sql);

if ($conn->query($sql) === TRUE) {
    echo ("User Deleted successfully");
} else {
    http_response_code(500);
    echo ("Error: " . $conn->error);
}

$conn->close();
?>