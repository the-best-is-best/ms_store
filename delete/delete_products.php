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

if (!isset($jsonData->id)) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->id) ?  $response->addMessage("id not supplied") : false);

    $response->send();
    exit;
}
$productId = $jsonData->id;


try {
    $query = $writeDB->prepare("SELECT image FROM products_" . DB::$AppName . " WHERE id = :id ");
    $query->bindParam(':id', $productId, PDO::PARAM_STR);
    $query->execute();
   
    $image =$query->fetch();
    if (!is_null( $image['image']) && !empty($image['image'])) {
    $removeImage = str_replace( DB::$urlSite, "" , $image['image']);
    unlink("../".$removeImage);
    }
        $query = $writeDB->prepare("DELETE FROM products_" . DB::$AppName . " WHERE id = :id ");

        $query->bindParam(':id', $productId, PDO::PARAM_STR);

        $query->execute();

        $response = new Response();
        $response->setHttpStatusCode(201);
        $response->setSuccess(true);
        $response->addMessage('Deleted Product');

        $response->send();
        exit;
  
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue Delete Product - please try again' . $ex);
    $response->send();
    exit;
}
