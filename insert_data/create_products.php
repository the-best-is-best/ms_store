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
    !isset($jsonData->nameEN) ||  !isset($jsonData->nameAR) || !isset($jsonData->image)
    || !isset($jsonData->price) || !isset($jsonData->descriptionEN) ||
    !isset($jsonData->descriptionAR) || !isset($jsonData->categoryId)
) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->nameEN) ?  $response->addMessage("Name EN not supplied") : false);
    (!isset($jsonData->nameAR) ?  $response->addMessage("Name AR not supplied") : false);

    (!isset($jsonData->image) ?  $response->addMessage("Image not supplied") : false);
    (!isset($jsonData->price) ?  $response->addMessage("Price not supplied") : false);
    (!isset($jsonData->descriptionEN) ?  $response->addMessage("Description EN not supplied") : false);
    (!isset($jsonData->descriptionAR) ?  $response->addMessage("Description AR not supplied") : false);

    (!isset($jsonData->categoryId) ?  $response->addMessage("Category Id not supplied") : false);

    $response->send();
    exit;
}


if (
    strlen($jsonData->nameEN) < 1 || strlen($jsonData->nameEN) > 255 ||
    strlen($jsonData->nameAR) < 1 || strlen($jsonData->nameAR) > 255 ||

    strlen($jsonData->image) < 1 || strlen($jsonData->image) > 255 ||
    strlen($jsonData->descriptionEN) < 10 ||
    strlen($jsonData->descriptionAR) < 10

) {
    $response = new Response();

    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (strlen($jsonData->nameEN) < 1 ?  $response->addMessage("Name EN cannot be black") : false);
    (strlen($jsonData->nameEN) > 255 ?  $response->addMessage("Name EN cannot be greater than 255 characters") : false);

    (strlen($jsonData->nameAR) < 1 ?  $response->addMessage("Name AR cannot be black") : false);
    (strlen($jsonData->nameAR) > 255 ?  $response->addMessage("Name AR cannot be greater than 255 characters") : false);

    (strlen($jsonData->image) < 1 ?  $response->addMessage("image cannot be black") : false);
    (strlen($jsonData->image) > 255 ?  $response->addMessage("image cannot be greater than 255 characters") : false);

    (strlen($jsonData->descriptionEN) < 10 ?  $response->addMessage("Description EN cannot be black or less than 10") : false);

    (strlen($jsonData->descriptionAR) < 10 ?  $response->addMessage("Description AR cannot be black or less than 10") : false);


    $response->send();
    exit;
}
$price_after_dis  = $jsonData->price_after_dis ?? 0;
if ($price_after_dis > $jsonData->price) {
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('How price after descount > original price');
    $response->send();
    exit;
}
$nameEN = trim($jsonData->nameEN);
$nameAR = trim($jsonData->nameAR);

$image = trim($jsonData->image);
$descriptionEN = trim($jsonData->descriptionEN);
$descriptionAR = trim($jsonData->descriptionAR);

$price = trim($jsonData->price);
$price_after_dis = trim($price_after_dis);
$categoryId = trim($jsonData->categoryId);
$sale = $jsonData->sale ?? 0;
$offers =$jsonData->offers ?? 0;
try {
    $query = $writeDB->prepare("INSERT into products_" . DB::$AppName .  " (nameEN , nameAR , image 
    , descriptionEN , descriptionAR , price , price_after_dis , categoryId , offers , sale )
VALUES (:nameEN , :nameAR , :image , :descriptionEN , :descriptionAR,  :price , :price_after_dis 
, :categoryId , :offers , :sale)");

    $query->bindParam(':nameEN', $nameEN, PDO::PARAM_STR);
    $query->bindParam(':nameAR', $nameAR, PDO::PARAM_STR);

    $query->bindParam(':image', $image, PDO::PARAM_STR);
    $query->bindParam(':descriptionEN', $descriptionEN, PDO::PARAM_STR);
    $query->bindParam(':descriptionAR', $descriptionAR, PDO::PARAM_STR);

    $query->bindParam(':price', $price, PDO::PARAM_STR);
    $query->bindParam(':price_after_dis', $price_after_dis, PDO::PARAM_STR);
    $query->bindParam(':categoryId', $categoryId, PDO::PARAM_STR);
    
    $query->bindParam(':offers', $offers, PDO::PARAM_STR);

    $query->bindParam(':sale', $sale, PDO::PARAM_STR);

    $query->execute();
    $rowCount = $query->rowCount();

    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue creating Products - please try again');
        $response->send();
        exit;
    }


    $response = new Response();
    $response->setHttpStatusCode(200);
    $response->setSuccess(true);
    $response->setData(["id" => $writeDB->lastInsertId()]);
    $response->addMessage('Products Created');
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue creating Product - please try again' . $ex);
    $response->send();
    exit;
}
