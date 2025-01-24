<?php
// Include the database connection file
include 'db.php';

// Set the Content-Type to JSON
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

// Get the posted data
$data = json_decode(file_get_contents("php://input"), true);

if (!$data) {
    echo json_encode([
        'success' => false,
        'message' => 'No input data received.'
    ]);
    exit();
}

// Validate input
if (!isset($data['username']) || !isset($data['password'])) {
    echo json_encode([
        'success' => false,
        'message' => 'Username and password are required.'
    ]);
    exit();
}

$username = $data['username'];
$password = $data['password'];

// Prepare SQL query
$stmt = $conn->prepare("SELECT personid, username, password FROM person WHERE username = ?");
if (!$stmt) {
    echo json_encode([
        'success' => false,
        'message' => 'Database error: Failed to prepare statement.'
    ]);
    exit();
}

$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

// Check if a user exists
if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();

    if ($password== $user['password']) {
        echo json_encode([
            'success' => true,
            'message' => 'Login successful.',
            'data' => [
                'personid' => $user['personid'],
                'username' => $user['username']
            ]
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Invalid password.'
        ]);
    }
} else {
    echo json_encode([
        'success' => false,
        'message' => 'User not found.'
    ]);
}

$stmt->close();
$conn->close();
?>
