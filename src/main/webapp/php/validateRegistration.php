<?php
// Exercise 9C: PHP Endpoint for Registration AJAX Validation
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

$name = isset($_GET['name']) ? trim($_GET['name']) : '';
$email = isset($_GET['email']) ? trim($_GET['email']) : '';
$password = isset($_GET['password']) ? trim($_GET['password']) : '';

$errors = [];

if (empty($name)) {
    $errors[] = "PHP Validation: Name cannot be empty.";
}

if (empty($email) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $errors[] = "PHP Validation: Enter a valid email format.";
}

if (empty($password) || strlen($password) < 6) {
    $errors[] = "PHP Validation: Password must be at least 6 characters.";
}

if (count($errors) === 0) {
    echo json_encode([
        "valid" => true,
        "message" => "All inputs validated successfully by PHP script!"
    ]);
} else {
    echo json_encode([
        "valid" => false,
        "errors" => $errors
    ]);
}
?>
