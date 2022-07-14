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
    $rowsPerPage = 6;
    $query = $writeDB->prepare("SELECT id FROM products_" . DB::$AppName . " WHERE categoryId = '$catId' ORDER BY id DESC");
    $query->execute();
    $count = $query->rowCount();
    $numrows = $count;
    $totalPages = ceil($numrows / $rowsPerPage);

    if (isset($_GET['currentPage']) && is_numeric($_GET['currentPage'])) {
        $currentPage = (int) $_GET['currentPage'];
    } else {
        $currentPage = 1;  // default page number
    }
    // if current page is greater than total pages
    if ($currentPage > $totalPages) {
        // set current page to last page
        $currentPage = $totalPages;
    }
    // if current page is less than first page
    if ($currentPage < 1) {
        // set current page to first page
        $currentPage = 1;
    }
    // the offset of the list, based on current page
    $offset = ($currentPage - 1) * $rowsPerPage;
    $query = $writeDB->prepare("SELECT * FROM products_" . DB::$AppName . " WHERE categoryId = '$catId' ORDER BY id DESC LIMIT $offset, $rowsPerPage");
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
    $returnData['totalPages'] = $totalPages;
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
