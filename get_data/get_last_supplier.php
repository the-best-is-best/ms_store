<?php
require_once('../controller/db.php');
require_once('../models/response.php');

try {
    $readDB = DB::connectionDB();
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
if (!isset($_GET['categoryId'])) {
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('Not allowed');
    $response->send();
    exit;
}
try {

    $categoryId =  $_GET["categoryId"];
    $query = $readDB->prepare('SELECT * FROM products_' .  DB::$AppName . ' WHERE categoryId =' . $categoryId . ' ORDER BY id DESC Limit 5 ');
    $query->execute();
    $row = $query->fetchAll();
    for ($i = 0; $i < count($row); $i++) {
        $row[$i]['image'] = DB::$urlSite .  $row[$i]['image'];
    }
    $returnData = $row;
    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->setData($returnData);
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue creating Project - please try again' . $ex);
    $response->send();
    exit;
}
