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
    $row['category'] = array();
    $query = $writeDB->prepare("SELECT * FROM category_" . DB::$AppName .  ' WHERE parent=0');
    $query->execute();
    $rowMainCat = $query->fetchAll();
    if (empty($rowMainCat)) {

        $response = new Response();
        $response->setHttpStatusCode(201);
        $response->setSuccess(true);
        $response->addMessage('No Category');
        $response->send();
        exit;
    }

    $row = $rowMainCat;
    $query = $writeDB->prepare("SELECT * FROM category_" . DB::$AppName . ' WHERE parent!=0');
    $query->execute();
    $rowCat = $query->fetchAll();
    for ($i = 0; $i < count($rowMainCat); $i++) {
        $row[$i]['childCat'] = array();
        for ($j = 0; $j < count($rowCat); $j++) {
            if ($rowCat[$j]['parent'] ==  $rowMainCat[$i]['id']) {
                $rowCat[$j]['image'] = DB::$urlSite .  $rowCat[$j]['image'];
                array_push($row[$i]['childCat'], $rowCat[$j]);
            }
        }
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
    $response->addMessage('There was an issue Get Category - please try again' . $ex);
    $response->send();
    exit;
}
