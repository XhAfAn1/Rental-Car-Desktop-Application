<?php
include 'db.php';
$data = json_decode(file_get_contents("php://input"), true);



$id = $data['ID'];
$name = $data['Name'];
$photo = $data['Photo'];
$email = $data['Email'];
$phone = $data['Phone'];
$address = $data['Address'];
$dob = $data['DOB'];
$role = $data['role'];
$userActivated = $data['user_activated'];
$password =$data['Password'];

$sql = "INSERT INTO InventoryUser (id, name, photo, email, phone, address, dob, role, user_activated, password)
VALUES ('$id', '$name', '$photo','$email', '$phone', '$address', '$dob', '$role', '$userActivated', '$password')";

//$conn->query($sql);

if ($conn->query($sql) === TRUE) {
    echo ("User added successfully");
} else {
    http_response_code(500);
    echo("Error: " . $conn->error);
}


/*
// Check if the data is not empty
if (!empty($data)) {
    // Retrieve data from the JSON body
    $id = $conn->real_escape_string($data['ID']);
    $name = $conn->real_escape_string($data['Name']);
    $email = $conn->real_escape_string($data['Email']);
    $phone = $conn->real_escape_string($data['Phone']);
    $address = $conn->real_escape_string($data['Address']);
    $dob = $conn->real_escape_string($data['DOB']);
    $role = $conn->real_escape_string($data['role']);
    $userActivated = $conn->real_escape_string($data['user_activated']);
    $password = $conn->real_escape_string($data['Password']);

    // SQL query to insert data
    $sql = "INSERT INTO InventoryUser (id, name, email, phone, address, dob, role, user_activated, password)
            VALUES ('$id', '$name', '$email', '$phone', '$address', '$dob', '$role', '$userActivated', '$password')";

    // Execute the query
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "User added successfully"]);
    } else {
        http_response_code(500);
        echo json_encode(["error" => "Error: " . $conn->error]);
    }
} else {
    http_response_code(400);
    echo json_encode(["error" => "Invalid input data"]);
}
*/
// Close the database connection
$conn->close();
?>