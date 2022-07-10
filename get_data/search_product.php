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
    if (!isset($_GET['name']) && !isset($_GET['lang'])) {
        $response = new Response();
        $response->setHttpStatusCode(400);
        $response->setSuccess(false);

        (!isset($_GET['name']) ?  $response->addMessage("Name not supplied") : false);
        (!isset($_GET['lang']) ?  $response->addMessage("Language not supplied") : false);

        $response->send();
        exit;
    }
    $name = $_GET['name'];
    $lang = $_GET['lang'];
    $rowsperpage = 20;
    $searchByName = $lang == "en" ? "nameEN" : "nameAR";
    $query = $writeDB->prepare("SELECT * FROM products_" . DB::$AppName . " WHERE $searchByName LIKE '%$name%'");
    $query->execute();
    $count = $query->rowCount();
    $numrows = $count;
    $totalpages = ceil($numrows / $rowsperpage);

    if (isset($_GET['currentpage']) && is_numeric($_GET['currentpage'])) {
        $currentpage = (int) $_GET['currentpage'];
    } else {
        $currentpage = 1;  // default page number
    }
    // if current page is greater than total pages
    if ($currentpage > $totalpages) {
        // set current page to last page
        $currentpage = $totalpages;
    }
    // if current page is less than first page
    if ($currentpage < 1) {
        // set current page to first page
        $currentpage = 1;
    }
    // the offset of the list, based on current page
    $offset = ($currentpage - 1) * $rowsperpage;
    $row = $query->fetchAll();
    $returnData['products'] = [];

    for ($i = 0; $i < count($row); $i++) {
        $row[$i]['image'] = DB::$urlSite .  $row[$i]['image'];
        array_push($returnData['products'], $row[$i]);
    }
    if (empty($row)) {

        $response = new Response();
        $response->setHttpStatusCode(201);
        $response->setSuccess(true);
        $response->addMessage('No Products');
        $response->send();
        exit;
    }
    $returnData['totalPages'] = $totalpages;

    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->setData($returnData);
    $response->send();
    exit;
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue Get Products Search - please try again' . $ex);
    $response->send();
    exit;
}
