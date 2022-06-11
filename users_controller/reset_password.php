<?php
require_once('../controller/db.php');
require_once('../models/response.php');

try {
    $writeDB = DB::connectionDB();
} catch (PDOException $ex) {
    error_log("connection Error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('Database connection error');
    $response->send();
    exit;
}


if ($_SERVER['REQUEST_METHOD']  !== 'POST') {
    $response = new Response();
    $response->setHttpStatusCode(405);
    $response->setSuccess(false);
    $response->addMessage('Request method not allowed');
    $response->send();
    exit;
}


if ($_SERVER['CONTENT_TYPE'] !== 'application/json') {
    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);
    $response->addMessage('Content Type header not json');
    $response->send();
    exit;
}

$rowPostData = file_get_contents('php://input');

if (!$jsonData = json_decode($rowPostData)) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);
    $response->addMessage('Request body is not valid json');
    $response->send();
    exit;
}
$jsonData->pin = "l" . $jsonData->pin;
if (!isset($jsonData->email) && !isset($jsonData->password) && !isset($jsonData->pin)) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);
    $response->addMessage("Not allowed");

    $response->send();
    exit;
}
$query = $writeDB->prepare("SELECT * FROM users_" . DB::$AppName . " WHERE email = :email AND code=:code ");
$query->bindParam(':email', $jsonData->email, PDO::PARAM_STR);
$query->bindParam(':code', $jsonData->pin, PDO::PARAM_STR);

$query->execute();
$row = $query->fetch();
if (empty($row)) {

    $response = new Response();
    $response->setHttpStatusCode(409);
    $response->setSuccess(false);

    $response->send();
    exit;
}
if ($row['code'] === 0) {
    $response = new Response();
    $response->setHttpStatusCode(409);
    $response->setSuccess(false);
    $response->send();
    exit;
}

$password = trim($jsonData->password);
$passwordHash = password_hash($password, PASSWORD_DEFAULT);

$query = $writeDB->prepare("UPDATE users_" . DB::$AppName . "  SET password = :password , code=0 WHERE email = :email  AND code=:code   ");
$query->bindParam(':email', $jsonData->email, PDO::PARAM_STR);
$query->bindParam(':password', $passwordHash, PDO::PARAM_STR);
$query->bindParam(':code', $jsonData->pin, PDO::PARAM_STR);

$query->execute();

$response = new Response();
$response->setHttpStatusCode(200);
$response->setSuccess(true);
$response->addMessage("Password Changed");
$response->send();
exit;
