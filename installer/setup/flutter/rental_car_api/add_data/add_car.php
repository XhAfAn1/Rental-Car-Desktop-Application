<?php
include '../db.php';

// Get the JSON input from the request
$input = file_get_contents("php://input");
$data = json_decode($input, true);

// Extract data from JSON
$registrationNumber = $data['registrationNumber'];
$carType = $data['carType'];
$modelName = $data['modelName'];
$manufacturer = $data['manufacturer'];
$year = $data['year'];
$availableStatus = $data['availableStatus']; // Assuming this maps to a predefined availability ID
$availableDate = $data['availableDate'];
$amount = $data['amount']; // Assuming cost details come from another table

try {
    // Start a transaction
    $conn->begin_transaction();

    // Step 1: Insert into `carmodel`
    $stmt = $conn->prepare("INSERT INTO carmodel (model_name, manufacturer, year,cost_id) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $modelName, $manufacturer, $year,$amount);
    $stmt->execute();
    $model_id = $conn->insert_id; // Get the generated `model_id`
    $stmt->close();

    // Step 2: Insert into `cars`
    $stmt = $conn->prepare("INSERT INTO cars (reg_no, car_type) VALUES (?, ?)");
    $stmt->bind_param("ss", $registrationNumber, $carType);
    $stmt->execute();
    $car_id = $conn->insert_id; // Get the generated `car_id`
    $stmt->close();

    // Step 3: Link `cars` to `carmodel`
    $stmt = $conn->prepare("INSERT INTO has_model (car_id, model_id) VALUES (?, ?)");
    $stmt->bind_param("ii", $car_id, $model_id);
    $stmt->execute();
    $stmt->close();

    // Step 4: Link `cars` to `caravailability`
    // Assuming `availableStatus` corresponds to an existing availability ID
    $stmt = $conn->prepare("INSERT INTO has_availability (car_id, availability_id) VALUES (?, ?)");
    $stmt->bind_param("ii", $car_id, $availableStatus);
    $stmt->execute();
    $stmt->close();

    // Commit the transaction
    $conn->commit();

    // Respond with success
    http_response_code(200);
    echo json_encode(["message" => "Car details added successfully"]);

} catch (Exception $e) {
    // Roll back the transaction in case of error
    $conn->rollback();
    http_response_code(500);
    echo json_encode(["message" => "Failed to add car details", "error" => $e->getMessage()]);
}

// Close the connection
$conn->close();
?>
