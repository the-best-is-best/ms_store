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
    $row['slider'] = [];

    $query = $writeDB->prepare("SELECT * FROM slider_" . DB::$AppName);
    $query->execute();
    $rowSlider = $query->fetchAll();
    for ($i = 0; $i < count($rowSlider); $i++) {
        $rowSlider[$i]['imageEN'] = DB::$urlSite .  $rowSlider[$i]['imageEN'];
        $rowSlider[$i]['imageAR'] = DB::$urlSite .  $rowSlider[$i]['imageAR'];

        array_push($row['slider'], $rowSlider[$i]);
    }

    $query = $writeDB->prepare("SELECT id,  nameEN , nameAR , parent FROM category_" . DB::$AppName);
    $query->execute();
    $rowCat = $query->fetchAll();

    $query = $writeDB->prepare("SELECT id, nameEN , nameAR FROM category_" . DB::$AppName . " WHERE displayInHome=1");
    $query->execute();
    $rowMainCat = $query->fetchAll();


    for ($i = 0; $i < count($rowMainCat); $i++) {
        $row['dataHome'][$i]['category'] = $rowMainCat[$i];

        $row['dataHome'][$i]['productsInCategory'] = [];
        for ($j = count($rowCat) - 1; $j >= 0; $j--) {
            if ($rowCat[$j]['parent'] ==  $rowMainCat[$i]['id']) {
                $query = $writeDB->prepare("SELECT * FROM products_" . DB::$AppName . " WHERE categoryId=" . $rowCat[$j]['id']   . " ORDER BY id DESC LIMIT 2");
                $query->execute();
                $rowProduct = $query->fetchAll();
                for ($p = 0; $p < count($rowProduct); $p++) {
                    $rowProduct[$p]['image'] = DB::$urlSite .  $rowProduct[$p]['image'];
                    array_push($row['dataHome'][$i]['productsInCategory'], $rowProduct[$p]);
                }
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
    $response->addMessage('There was an issue Get Slider - please try again' . $ex);
    $response->send();
    exit;
}
