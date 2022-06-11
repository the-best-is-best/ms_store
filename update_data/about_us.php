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

if (
    !isset($jsonData->textEN) || !isset($jsonData->textAR)
) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->textEN) ?  $response->addMessage("Text EN not supplied") : false);
    (!isset($jsonData->textAR) ?  $response->addMessage("Text AR not supplied") : false);

    $response->send();
    exit;
}


$textEN = trim($jsonData->textEN);
$textAR = trim($jsonData->textAR);
$id =1;

try {
    $query = $writeDB->prepare("UPDATE about_us_" . DB::$AppName . " SET textEN = :textEN , textAR=:textAR WHERE id=:id ");

    $query->bindParam(':textEN', $textEN, PDO::PARAM_STR);
    $query->bindParam(':textAR', $textAR, PDO::PARAM_STR);
    $query->bindParam(':id', $id, PDO::PARAM_STR);
    

    $query->execute();

    $rowCount = $query->rowCount();
    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue update About Us data - please try again .');
        $response->send();
        exit;
    }



    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('About data updated');
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue update About Us - please try again' . $ex);
    $response->send();
    exit;
}