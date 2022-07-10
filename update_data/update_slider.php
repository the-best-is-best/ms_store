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
    !isset($jsonData->sliderId)
) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->sliderId) ?  $response->addMessage("Slider id not supplied") : false);

    $response->send();
    exit;
}

if (
    strlen($jsonData->imageEN) < 1 || strlen($jsonData->imageEN) > 255 ||
    strlen($jsonData->imageAR) < 1 || strlen($jsonData->imageAR) > 255

) {
    $response = new Response();

    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (strlen($jsonData->imageEN) < 1 ?  $response->addMessage("Name EN cannot be black") : false);
    (strlen($jsonData->imageEN) > 255 ?  $response->addMessage("Name EN cannot be greater than 255 characters") : false);

    (strlen($jsonData->imageAR) < 1 ?  $response->addMessage("Name AR cannot be black") : false);
    (strlen($jsonData->imageAR) > 255 ?  $response->addMessage("Name AR cannot be greater than 255 characters") : false);

    $response->send();
    exit;
}

if (is_null($jsonData->open_category_id) && is_null($jsonData->open_product_id)) {
    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);
    $response->addMessage('Select Category or Product ');
    $response->send();
    exit;
}

if (!empty($jsonData->open_category_id) && !empty($jsonData->open_product_id)) {
    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);
    $response->addMessage('Select Category or Product - you selected category and product');
    $response->send();
    exit;
}
$imageEN = $jsonData->imageEN;
$imageAR = $jsonData->imageAR;
$open_category_id = $jsonData->open_category_id != null ? trim($jsonData->open_category_id) : null;
$open_product_id  = $jsonData->open_product_id != null ? trim($jsonData->open_product_id) : null;



try {
    $query = $writeDB->prepare("SELECT image FROM slider_" . DB::$AppName . " WHERE id = :id ");
    $query->bindParam(':id', $productId, PDO::PARAM_STR);
    $query->execute();

    $imageOld = $query->fetch();
    if (empty($jsonData->imageEN)) {
        $jsonData->imageEN = $imageOld['imageEN'];
        $imageEN =  $imageOld['imageEN'];
    }
    if (empty($jsonData->imageAR)) {
        $jsonData->imageAR = $imageOld['imageAR'];
        $imageAR =  $imageOld['imageAR'];
    }


    
    $query = $writeDB->prepare("UPDATE slider_" . DB::$AppName . " SET imageEN = :imageEN
    , imageAR=:imageAR , open_category_id=:open_category_id , open_product_id =:open_product_id
       WHERE id=:id");

    $query->bindParam(':imageEN', $imageEN, PDO::PARAM_STR);
    $query->bindParam(':imageAR', $imageAR, PDO::PARAM_STR);

    $query->bindParam(':open_category_id', $open_category_id, PDO::PARAM_STR);
    $query->bindParam(':open_product_id', $open_product_id, PDO::PARAM_STR);

    $query->bindParam(':id', $sliderId, PDO::PARAM_STR);

    $query->execute();
    $rowCount = $query->rowCount();

    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue creating Slider - please try again');
        $response->send();
        exit;
    }

    if (!empty($imageEN) && !empty($imageOld['imageEN']) && $imageOld['imageEN'] != $imageEN) {

        $removeImage = str_replace(DB::$urlSite, "", $imageOld['imageEN']);
        unlink("../" . $removeImage);
    }    
    if (!empty($imageAR) && !empty($imageOld['imageAR']) && $imageOld['imageAR'] != $imageAR) {

        $removeImage = str_replace(DB::$urlSite, "", $imageOld['imageAR']);
        unlink("../" . $removeImage);
    }
    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('Slider Created');
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue creating Slider - please try again' . $ex);
    $response->send();
    exit;
}