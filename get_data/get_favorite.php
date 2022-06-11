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

if ($_SERVER['REQUEST_METHOD']  !== 'GET') {
    $response = new Response();
    $response->setHttpStatusCode(405);
    $response->setSuccess(false);
    $response->addMessage('Request method not allowed');
    $response->send();
    exit;
}
if (!isset($_GET['userId'])) {
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('Not allowed');
    $response->send();
    exit;
}
$userId = $_GET['userId'];


try {
    $query = $writeDB->prepare("SELECT * FROM favorite_" . DB::$AppName . " WHERE userId = '$userId' AND  status = '1' ");
    $query->execute();
    $rowFavorite = $query->fetchAll();
    if (empty($rowFavorite)) {

        $response = new Response();
        $response->setHttpStatusCode(201);
        $response->setSuccess(true);
        $response->addMessage('No Favorites');
        $response->send();
        exit;
    }
  
    $returnData = $rowFavorite;
    $response = new Response();
    $response->setHttpStatusCode(200);
    $response->setSuccess(true);
    $response->setData($returnData);
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue Get Category - please try again' . $ex);
    $response->send();
    exit;
}
