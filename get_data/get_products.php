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
$customQuery = $_GET['customQuery'] ?? "";

try {
    $query = $writeDB->prepare("SELECT * FROM products_" . DB::$AppName . " $customQuery ORDER BY id DESC");
   $query->execute();
    $row =$query->fetchAll();
    for($i=0; $i < count($row); $i++ ){
        $row[$i]['image']= DB::$urlSite .  $row[$i]['image'];
    }
    if(empty($row)){
       
        $response = new Response();
        $response->setHttpStatusCode(201);
        $response->setSuccess(true);
        $response->addMessage('No Products');
        $response->send();
    exit;
    }
       $returnData = $row;
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
    $response->addMessage('There was an issue Get Products - please try again' . $ex);
    $response->send();
    exit;
}