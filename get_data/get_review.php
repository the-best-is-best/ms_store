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

try {
    if (!isset($_GET['productId'])) {
        $response = new Response();
        $response->setHttpStatusCode(400);
        $response->setSuccess(false);
        $response->addMessage("Not allowed");
        $response->send();
        exit;
    }
    $productId = $_GET['productId'];
    $query = $writeDB->prepare("SELECT * FROM  rating_" . DB::$AppName . " WHERE productId = '$productId'");
    $query->execute();
    $row = $query->fetchAll();
    $count = $query->rowCount();

    if (empty($row)) {

        $response = new Response();
        $response->setHttpStatusCode(201);
        $response->setSuccess(true);
        $response->addMessage('No Review');
        $response->send();
        exit;
    }
    $total_rating = 0;
    foreach ($row as $rowData) {
        $total_rating += $rowData['rating'];
    }
    $product_rating =  $total_rating / $count;
    $dataRow['productRating'] = $product_rating;
    $dataRow['dataReview'] = [];
    for ($i = 0; $i < count($row); $i++) {
        $query = $writeDB->prepare('SELECT userName FROM users_' .  DB::$AppName . ' WHERE id =' . $row[$i]['userId']);

        $query->execute();
        $rowUsers = $query->fetch();

        if ($row[$i]['status'] == true) {
            $dataRow['dataReview'][$i] = $row[$i];
            $dataRow['dataReview'][$i]['userName'] = $rowUsers['userName'];
        }
    }
    $response = new Response();
    $response->setHttpStatusCode(200);
    $response->setSuccess(true);
    $response->setData($dataRow);
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
