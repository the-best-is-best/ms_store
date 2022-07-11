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
    !isset($jsonData->id) ||  !isset($jsonData->nameEN) || !isset($jsonData->nameAR)
) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->id) ?  $response->addMessage("Category id not supplied") : false);
    (!isset($jsonData->nameEN) ?  $response->addMessage("Name EN not supplied") : false);
    (!isset($jsonData->nameAR) ?  $response->addMessage("Name AR not supplied") : false);

    $response->send();
    exit;
}

$categoryId = $jsonData->id;
$nameEN = trim($jsonData->nameEN);
$nameAR = trim($jsonData->nameAR);
$parent = $jsonData->parent;

$image =  $jsonData->image;
$displayInHome = $jsonData->displayInHome;
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
    $query = $writeDB->prepare("SELECT image FROM category_" . DB::$AppName . " WHERE id = :id ");
    $query->bindParam(':id', $categoryId, PDO::PARAM_STR);
    $query->execute();

    $imageOld = $query->fetch();

    if (empty($jsonData->image)) {
        $jsonData->image = $imageOld['image'];
        $image =  $imageOld['image'];
    }
    $query = $writeDB->prepare("UPDATE category_" . DB::$AppName . " SET nameEN = :nameEN , nameAR=:nameAR , image=:image , displayInHome=:displayInHome WHERE id=:id ");

    $query->bindParam(':nameEN', $nameEN, PDO::PARAM_STR);
    $query->bindParam(':nameAR', $nameAR, PDO::PARAM_STR);
    $query->bindParam(':image', $image, PDO::PARAM_STR);
    $query->bindParam(':displayInHome', $displayInHome, PDO::PARAM_STR);

    $query->bindParam(':id', $categoryId, PDO::PARAM_STR);


    $query->execute();

    $rowCount = $query->rowCount();
    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue update Category data updated - please try again .');
        $response->send();
        exit;
    }



    if (!empty($imageOld['image']) &&  !empty($image) &&  $imageOld['image'] != $image) {
        $removeImage = str_replace(DB::$urlSite, "", $imageOld['image']);

        unlink("../" . $removeImage);
    }

    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('Category data updated');
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue update Category data - please try again' . $ex);
    $response->send();
    exit;
}
