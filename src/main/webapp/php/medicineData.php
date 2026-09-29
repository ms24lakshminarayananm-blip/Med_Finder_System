<?php
// Exercise 9B: PHP Backend Endpoint Returning Medicine Data / JSON
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

$sampleMedicines = [
    [
        "id" => 1,
        "name" => "Paracetamol 650mg",
        "category" => "Fever",
        "price" => 25.00,
        "availability" => "Available (PHP Demo Data)",
        "pharmacy" => "Apollo Pharmacy"
    ],
    [
        "id" => 2,
        "name" => "Amoxicillin 500mg",
        "category" => "Antibiotic",
        "price" => 120.00,
        "availability" => "Available (PHP Demo Data)",
        "pharmacy" => "Apollo Pharmacy"
    ],
    [
        "id" => 3,
        "name" => "Cetirizine 10mg",
        "category" => "Allergy",
        "price" => 35.00,
        "availability" => "Available (PHP Demo Data)",
        "pharmacy" => "MedPlus Healthcare"
    ]
];

echo json_encode($sampleMedicines);
?>
