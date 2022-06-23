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
    !isset($jsonData->status) || !isset($jsonData->productId) || !isset($jsonData->userId)
    || !isset($jsonData->comment) || !isset($jsonData->rating)
) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);
    (!isset($jsonData->userId) ?  $response->addMessage("User Id  not supplied") : false);

    (!isset($jsonData->status) ?  $response->addMessage("Status  not supplied") : false);
    (!isset($jsonData->productId) ?  $response->addMessage("Product Id  not supplied") : false);
    (!isset($jsonData->comment) ?  $response->addMessage("Comment  not supplied") : false);
    (!isset($jsonData->rating) ?  $response->addMessage("Rating  not supplied") : false);


    $response->send();
    exit;
}

$status = trim($jsonData->status);
$productId = trim($jsonData->productId);
$userId = trim($jsonData->userId);
$comment = trim($jsonData->comment);
$rating = $jsonData->rating;

if ($rating > 5) {
    $response = new Response();
    $response->setHttpStatusCode(200);
    $response->setSuccess(true);
    $response->addMessage('Add Review');
    $response->send();
    exit;
}

try {
    $query = $writeDB->prepare("SELECT id FROM rating_" . DB::$AppName . " WHERE productId= :productId AND userId =:userId");
    $query->bindParam(':productId', $productId, PDO::PARAM_STR);
    $query->bindParam(':userId', $userId, PDO::PARAM_STR);

    $query->execute();
    $rowCount = $query->rowCount();
    if ($rowCount !== 0) {
        $query = $writeDB->prepare("UPDATE rating_" . DB::$AppName . " SET status = :status , comment=:comment , rating=:rating WHERE productId=:productId AND userId=:userId ");

        $query->bindParam(':status', $status, PDO::PARAM_STR);
        $query->bindParam(':productId', $productId, PDO::PARAM_STR);
        $query->bindParam(':userId', $userId, PDO::PARAM_STR);
        $query->bindParam(':comment', $comment, PDO::PARAM_STR);
        $query->bindParam(':rating', $rating, PDO::PARAM_STR);

        $query->execute();

        $response = new Response();
        $response->setHttpStatusCode(200);
        $response->setSuccess(true);
        $response->addMessage('Add Review');
        $response->send();
        exit;
    }


    $query = $writeDB->prepare("INSERT into rating_" . DB::$AppName .  " (status , rating, productId , userId , comment)
                                VALUES (:status ,:rating, :productId , :userId , :comment)");

    $query->bindParam(':status', $status, PDO::PARAM_STR);
    $query->bindParam(':productId', $productId, PDO::PARAM_STR);
    $query->bindParam(':userId', $userId, PDO::PARAM_STR);
    $query->bindParam(':comment', $comment, PDO::PARAM_STR);
    $query->bindParam(':rating', $rating, PDO::PARAM_STR);


    $query->execute();
    $rowCount = $query->rowCount();

    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue add to Review - please try again');
        $response->send();
        exit;
    }


    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('Add Review');
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue add to Review - please try again' . $ex);
    $response->send();
    exit;
}
