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
    strlen($jsonData->nameEN) < 1 || strlen($jsonData->nameEN) > 255 ||
    strlen($jsonData->nameAR) < 1 || strlen($jsonData->nameAR) > 255 ||


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



    (strlen($jsonData->descriptionEN) < 10 ?  $response->addMessage("Description EN cannot be black or less than 10") : false);

    (strlen($jsonData->descriptionAR) < 10 ?  $response->addMessage("Description AR cannot be black or less than 10") : false);


    $response->send();
    exit;
}
$price_after_dis  = $jsonData->price_after_dis ?? 0;
if ($price_after_dis > $jsonData->price) {
    $response = new Response();
    $response->setHttpStatusCode(409);
    $response->setSuccess(false);
    $response->addMessage('How price after discount > original price');
    $response->send();
    exit;
}
$productId = $jsonData->id;
$nameEN = trim($jsonData->nameEN);
$nameAR = trim($jsonData->nameAR);

$image = $jsonData->image;
$descriptionEN = trim($jsonData->descriptionEN);
$descriptionAR = trim($jsonData->descriptionAR);
$categoryId = trim($jsonData->categoryId);

$price = trim($jsonData->price);
$price_after_dis = trim($jsonData->price_after_dis ?? 0);
$offers = $jsonData->offers ?? 0;
$sale = $jsonData->sale ?? 0;

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
    $query = $writeDB->prepare("SELECT image FROM products_" . DB::$AppName . " WHERE id = :id ");
    $query->bindParam(':id', $productId, PDO::PARAM_STR);
    $query->execute();

    $imageOld = $query->fetch();
    if (empty($jsonData->image)) {
        $jsonData->image = $imageOld['image'];
        $image =  $imageOld['image'];
    }

    $query = $writeDB->prepare("UPDATE products_" . DB::$AppName . " SET nameEN = :nameEN
     , nameAR=:nameAR , image=:image , descriptionEN =:descriptionEN ,descriptionAR = :descriptionAR
      , price=:price , price_after_dis=:price_after_dis , categoryId=:categoryId , sale=:sale , offers=:offers  WHERE id=:id ");

    $query->bindParam(':nameEN', $nameEN, PDO::PARAM_STR);
    $query->bindParam(':nameAR', $nameAR, PDO::PARAM_STR);

    $query->bindParam(':image', $image, PDO::PARAM_STR);
    $query->bindParam(':descriptionEN', $descriptionEN, PDO::PARAM_STR);
    $query->bindParam(':descriptionAR', $descriptionAR, PDO::PARAM_STR);
    $query->bindParam(':categoryId', $categoryId, PDO::PARAM_STR);

    $query->bindParam(':price', $price, PDO::PARAM_STR);
    $query->bindParam(':price_after_dis', $price_after_dis, PDO::PARAM_STR);
    $query->bindParam(':offers', $offers, PDO::PARAM_STR);
    $query->bindParam(':sale', $sale, PDO::PARAM_STR);

    $query->bindParam(':id', $productId, PDO::PARAM_STR);


    $query->execute();

    $rowCount = $query->rowCount();
    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue update products data updated - please try again .');
        $response->send();
        exit;
    }
    if (!empty($image) && !empty($imageOld['image']) && $imageOld['image'] != $image) {

        $removeImage = str_replace(DB::$urlSite, "", $imageOld['image']);
        unlink("../" . $removeImage);
    }

    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('product data updated');
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue update product data - please try again' . $ex);
    $response->send();
    exit;
}
