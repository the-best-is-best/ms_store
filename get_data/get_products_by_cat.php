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
    if (!isset($_GET['catId'])) {
        $response = new Response();
        $response->setHttpStatusCode(400);
        $response->setSuccess(false);

        (!isset($_GET['catId']) ?  $response->addMessage("Category id not supplied") : false);
        $response->send();
        exit;
    }
    $catId = $_GET['catId'];
    $rowsperpage = 30;
    $query = $writeDB->prepare("SELECT id FROM products_" . DB::$AppName . " WHERE categoryId = '$catId' ORDER BY id DESC");
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
    $query = $writeDB->prepare("SELECT * FROM products_" . DB::$AppName . " WHERE categoryId = '$catId' ORDER BY id DESC LIMIT $offset, $rowsperpage");
    $query->execute();
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
    $row['totalpages'] = $totalpages;
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
    $response->addMessage('There was an issue Get Products - please try again' . $ex);
    $response->send();
    exit;
}
