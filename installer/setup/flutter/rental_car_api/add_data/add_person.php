<?php
include '../db.php';

// Get the JSON input from the request
$input = file_get_contents("php://input");
$data = json_decode($input, true);

$firstName =$data['FirstName'];
$lastName = $data['LastName'];
$name = $data['Name'] ;
$dob = $data['DOB'];
$age = $data['Age'];
$phoneNumber =$data['PhoneNumber'];
$email = $data['Email'];
$street = $data['Street'];
$city =  $data['City'];
$state = $data['State'];
$zip =  $data['Zip'];
$username= $data['username'];
$password= $data['password'];

try {
    // Start a transaction
    $conn->begin_transaction();

    // Get the last CustomerID and increment it
    $customerIdQuery = "SELECT MAX(CustomerID) AS lastCustomerId FROM person";
    $result = $conn->query($customerIdQuery);
    if ($result) {
        $row = $result->fetch_assoc();
        $customerId = ($row['lastCustomerId'] ?? 0) + 1;
    } else {
        throw new Exception("Failed to retrieve last CustomerID: " . $conn->error);
    }

    // Prepare the SQL query
    $sql = "INSERT INTO person (
                FirstName, LastName, Name, DOB, Age, PhoneNumber, Email, 
                Street, City, State, Zip, username, password, CustomerID
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        throw new Exception("Failed to prepare statement: " . $conn->error);
    }

    // Bind parameters
    $stmt->bind_param(
        "ssssissssssssi",
        $firstName,
        $lastName,
        $name,
        $dob,
        $age,
        $phoneNumber,
        $email,
        $street,
        $city,
        $state,
        $zip,
        $username,
        $password,
        $customerId
    );

    // Execute the statement
    if ($stmt->execute()) {
        // Commit the transaction
        $conn->commit();
        http_response_code(201);
        echo json_encode(["message" => "Person added successfully.", "CustomerID" => $customerId]);
    } else {
        throw new Exception("Failed to execute statement: " . $stmt->error);
    }
} catch (Exception $e) {
    // Roll back the transaction in case of error
    $conn->rollback();
    http_response_code(500);
    echo json_encode(["message" => "Failed to add car details", "error" => $e->getMessage()]);
}

// Close the connection
$conn->close();
?>
