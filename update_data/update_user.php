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


if ($_SERVER['REQUEST_METHOD']  !== 'PUT') {
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
if (
    !isset($jsonData->id)
) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->id) ?  $response->addMessage("User id not supplied") : false);

    $response->send();
    exit;
}

$userId = $jsonData->id;

$query = $writeDB->prepare("SELECT * FROM users_" . DB::$AppName  . " WHERE id = :id ");
$query->bindParam(':id', $userId, PDO::PARAM_STR);

$query->execute();
$row = $query->fetch();
if (empty($jsonData->userName)) {
    $jsonData->userName = $row['userName'];
}
$userName = trim($jsonData->userName);


if (empty($jsonData->phone)) {
    $jsonData->phone = $row['phone'];
}
$password = trim($jsonData->password);
$phone = $jsonData->phone??"";
if (!empty($jsonData->password)) {

    $password = password_hash($password, PASSWORD_DEFAULT);
}
if (
    strlen($userName) < 1 || strlen($userName) > 255 
) {
    $response = new Response();

    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (strlen($userName) < 1 ?  $response->addMessage("User Name cannot be black") : false);
    (strlen($userName) > 255 ?  $response->addMessage("User Name cannot be greater than 255 characters") : false);


   // (strlen($phone) < 10 ?  $response->addMessage("Phone cannot be black or less than 10") : false);
    //(strlen($phone) > 15 ?  $response->addMessage("Phone error") : false);

    $response->send();
    exit;
}
try {
    $query;
    if (!empty($jsonData->password)) {

        $query = $writeDB->prepare("UPDATE users_" . DB::$AppName . " SET userName = :userName , password=:password , phone=:phone WHERE id=:id ");

        $query->bindParam(':userName', $userName, PDO::PARAM_STR);
        $query->bindParam(':password', $password, PDO::PARAM_STR);
        $query->bindParam(':phone', $phone, PDO::PARAM_STR);
        $query->bindParam(':id', $userId, PDO::PARAM_STR);

        $query->execute();
    } else {
        $query = $writeDB->prepare("UPDATE users_" . DB::$AppName . " SET userName = :userName , phone=:phone WHERE id=:id ");

        $query->bindParam(':userName', $userName, PDO::PARAM_STR);
        $query->bindParam(':phone', $phone, PDO::PARAM_STR);
        $query->bindParam(':id', $userId, PDO::PARAM_STR);
        $query->execute();
    }

    $rowCount = $query->rowCount();
    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue update user data updated - please try again .');
        $response->send();
        exit;
    }



    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('user data updated');
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue update user data - please try again' . $ex);
    $response->send();
    exit;
}
