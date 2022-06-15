<?php
require_once('../controller/db.php');
require_once('../models/response.php');
require_once '../controller/generate_key.php';

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
    !isset($jsonData->nameEN) || !isset($jsonData->nameAR)
) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->nameEN) ?  $response->addMessage("Name EN not supplied") : false);
    (!isset($jsonData->nameAR) ?  $response->addMessage("Name AR not supplied") : false);

    $response->send();
    exit;
}


if (
    strlen($jsonData->nameEN) < 1 || strlen($jsonData->nameEN) > 255
    ||  strlen($jsonData->nameAR) < 1 || strlen($jsonData->nameAR) > 255
) {
    $response = new Response();

    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (strlen($jsonData->nameEN) < 1 ?  $response->addMessage("Name EN cannot be black") : false);
    (strlen($jsonData->nameEN) > 255 ?  $response->addMessage("Name EN cannot be greater than 255 characters") : false);


    (strlen($jsonData->nameAR) < 1 ?  $response->addMessage("Name AR cannot be black") : false);
    (strlen($jsonData->nameAR) > 255 ?  $response->addMessage("Name AR cannot be greater than 255 characters") : false);


    $response->send();
    exit;
}
$nameEN = trim($jsonData->nameEN);
$nameAR = trim($jsonData->nameAR);

$parent = trim($jsonData->parent ?? 0);
if ($parent != 0) {
    if (!isset($jsonData->image)) {
        $response = new Response();
        $response->setHttpStatusCode(400);
        $response->setSuccess(false);

        (!isset($jsonData->image) ?  $response->addMessage("image not supplied") : false);

        $response->send();
        exit;
    }
} else {
    $jsonData->image = "";
}
$image =  $jsonData->image;

try {

    $json['cacheKeyServer'] =  randomKey();

    file_put_contents('../cache/cache.json', json_encode($json));
} catch (Exception $ex) {
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('File save error' . $ex);
    $response->send();
    exit;
}
try {
    $query = $writeDB->prepare("SELECT nameEN FROM category_" . DB::$AppName . " WHERE nameEN= :nameEN");
    $query->bindParam(':nameEN', $nameEN, PDO::PARAM_STR);

    $query->execute();
    $rowCount = $query->rowCount();
    if ($rowCount !== 0) {
        $response = new Response();
        $response->setHttpStatusCode(409);
        $response->setSuccess(false);
        $response->addMessage('Name EN already exists');
        $response->send();
        exit;
    }


    $query = $writeDB->prepare("INSERT into category_" . DB::$AppName .  " (nameEN , nameAR , parent , image  )
                                VALUES (:nameEN , :nameAR , :parent , :image )");

    $query->bindParam(':nameEN', $nameEN, PDO::PARAM_STR);
    $query->bindParam(':nameAR', $nameAR, PDO::PARAM_STR);
    $query->bindParam(':parent', $parent, PDO::PARAM_STR);
    $query->bindParam(':image', $image, PDO::PARAM_STR);


    $query->execute();
    $rowCount = $query->rowCount();

    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue creating Category - please try again');
        $response->send();
        exit;
    }


    $response = new Response();
    $response->setHttpStatusCode(200);
    $response->setSuccess(true);
    $response->setData(["id" => $writeDB->lastInsertId()]);
    $response->addMessage('Category Created');
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue creating Category - please try again' . $ex);
    $response->send();
    exit;
}
