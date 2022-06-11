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
    !isset($jsonData->userId) ||  !isset($jsonData->productId)
) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (!isset($jsonData->userId) ?  $response->addMessage("User Id  not supplied") : false);
    (!isset($jsonData->productId) ?  $response->addMessage("Product Id  not supplied") : false);

    $response->send();
    exit;
}


$productId = trim($jsonData->productId);
$userId = trim($jsonData->userId);


try {
    $query = $writeDB->prepare("SELECT * FROM favorite_" . DB::$AppName . " WHERE userId = '$userId' AND productId = '$productId '");
    $query->execute();
    $row = $query->fetch();
    if (empty($row)) {

        $query = $writeDB->prepare("INSERT into favorite_" . DB::$AppName .  " (userId , productId  )
        VALUES (:userId , :productId )");

        $query->bindParam(':userId', $userId, PDO::PARAM_STR);
        $query->bindParam(':productId', $productId, PDO::PARAM_STR);
        $query->execute();
        $rowCount = $query->rowCount();

        if ($rowCount === 0) {
            $response = new Response();
            $response->setHttpStatusCode(500);
            $response->setSuccess(false);
            $response->addMessage('There was an issue creating Favorite - please try again');
            $response->send();
            exit;
        }


        $response = new Response();
        $response->setHttpStatusCode(201);
        $response->setSuccess(true);
        $response->addMessage('Add to Favorite');
        $response->send();


        exit;
    } else {
        if ($row['status']) {
            $query = $writeDB->prepare("UPDATE favorite_" . DB::$AppName . " SET status = :status WHERE productId=:productId AND userId =:userId");
            $status = 0;
            $query->bindParam(':status', $status, PDO::PARAM_STR);
            $query->bindParam(':productId', $productId, PDO::PARAM_STR);
            $query->bindParam(':userId', $userId, PDO::PARAM_STR);


            $query->execute();

            $rowCount = $query->rowCount();
            if ($rowCount === 0) {
                $response = new Response();
                $response->setHttpStatusCode(500);
                $response->setSuccess(false);
                $response->addMessage('There was an issue add to Favorite - please try again .');
                $response->send();
                exit;
            }



            $response = new Response();
            $response->setHttpStatusCode(201);
            $response->setSuccess(true);
            $response->addMessage('Remove from Favorite');
            $response->send();
            exit;
        }else{
            $query = $writeDB->prepare("UPDATE favorite_" . DB::$AppName . " SET status = :status WHERE productId=:productId AND userId =:userId");
            $status = 1;
            $query->bindParam(':status', $status, PDO::PARAM_STR);
            $query->bindParam(':productId', $productId, PDO::PARAM_STR);
            $query->bindParam(':userId', $userId, PDO::PARAM_STR);


            $query->execute();

            $rowCount = $query->rowCount();
            if ($rowCount === 0) {
                $response = new Response();
                $response->setHttpStatusCode(500);
                $response->setSuccess(false);
                $response->addMessage('There was an issue add to Favorite - please try again .');
                $response->send();
                exit;
            }



            $response = new Response();
            $response->setHttpStatusCode(201);
            $response->setSuccess(true);
            $response->addMessage('Add to Favorite');
            $response->send();
            exit;
        }
    }
} catch (Exception $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue  Favorite - please try again' . $ex);
    $response->send();
    exit;
}
