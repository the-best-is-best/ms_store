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
    !isset($jsonData->titleEN) || !isset($jsonData->titleAR) || !isset($jsonData->telephone)
    || !isset($jsonData->facebookUrl)
) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->titleEN) ?  $response->addMessage("Title EN not supplied") : false);
    (!isset($jsonData->titleAR) ?  $response->addMessage("Title AR not supplied") : false);

    (!isset($jsonData->telephone) ?  $response->addMessage("Telephone  not supplied") : false);
    (!isset($jsonData->facebookUrl) ?  $response->addMessage("Facebook Url not supplied") : false);

    $response->send();
    exit;
}


$titleEN = trim($jsonData->titleEN);
$titleAR = trim($jsonData->titleAR);
$telephone = trim($jsonData->telephone);
$facebookUrl = trim($jsonData->facebookUrl);

$id = 1;

try {
    $query = $writeDB->prepare("UPDATE contact_us_" . DB::$AppName . " SET titleEN = :titleEN 
    , titleAR=:titleAR , telephone=:telephone , facebookUrl=:facebookUrl WHERE id=:id ");

    $query->bindParam(':titleEN', $titleEN, PDO::PARAM_STR);
    $query->bindParam(':titleAR', $titleAR, PDO::PARAM_STR);
    $query->bindParam(':telephone', $telephone, PDO::PARAM_STR);
    $query->bindParam(':facebookUrl', $facebookUrl, PDO::PARAM_STR);

    $query->bindParam(':id', $id, PDO::PARAM_STR);


    $query->execute();

    $rowCount = $query->rowCount();
    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue update Contacts Us data - please try again .');
        $response->send();
        exit;
    }



    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('Contact data updated');
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue update Contact Us - please try again' . $ex);
    $response->send();
    exit;
}
