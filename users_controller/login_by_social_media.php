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

$tokenSocial = trim($jsonData->tokenSocial);
$loginBySocial = $jsonData->loginBySocial;

$query = $writeDB->prepare("SELECT * FROM users_" . DB::$AppName . " WHERE tokenSocial = $tokenSocial AND loginBySocial=$loginBySocial");

$query->execute();
$row = $query->fetch();
if (empty($row)) {



    $userName = trim($jsonData->userName);
    $email = trim($jsonData->email);
    require_once '../controller/generate_key.php';

    $password = trim(randomKey());

    $passwordHash = password_hash($password, PASSWORD_DEFAULT);
    $email_active = 1;

    try {
        // $query = $writeDB->prepare("SELECT id FROM users_" . DB::$AppName . " WHERE email = :email AND loginBySocial=$loginBySocial");
        // $query->bindParam(':email', $email, PDO::PARAM_STR);
        // $query->execute();

        // $rowCount = $query->rowCount();
        // if ($rowCount !== 0) {
        //     $response = new Response();
        //     $response->setHttpStatusCode(409);
        //     $response->setSuccess(false);
        //     $response->addMessage('Email already exists');
        //     $response->send();
        //     exit;
        // }


        $query = $writeDB->prepare("INSERT into users_" . DB::$AppName . "(userName , password , email , email_active , loginBySocial , tokenSocial)
        VALUES (:userName , :password  , :email , :email_active , :loginBySocial , :tokenSocial)");

        $query->bindParam(':userName', $userName, PDO::PARAM_STR);
        $query->bindParam(':password', $passwordHash, PDO::PARAM_STR);
        $query->bindParam(':email', $email, PDO::PARAM_STR);
        $query->bindParam(':email_active', $email_active, PDO::PARAM_STR);
        $query->bindParam(':loginBySocial', $loginBySocial, PDO::PARAM_STR);
        $query->bindParam(':tokenSocial', $tokenSocial, PDO::PARAM_STR);




        $query->execute();
        $rowCount = $query->rowCount();

        if ($rowCount === 0) {
            $response = new Response();
            $response->setHttpStatusCode(500);
            $response->setSuccess(false);
            $response->addMessage('There was an issue creating Users - please try again');
            $response->send();
            exit;
        }


        $query = $writeDB->prepare("SELECT * FROM users_" . DB::$AppName . " WHERE tokenSocial = :tokenSocial AND loginBySocial=$loginBySocial");
        $query->bindParam(':tokenSocial', $tokenSocial, PDO::PARAM_STR);

        $query->execute();
        $row = $query->fetch();


        $response = new Response();
        $response->setHttpStatusCode(200);
        $response->setSuccess(true);
        $response->setData($row);
        $response->addMessage('Users Created By Social Login');
        $response->send();

        exit;
    } catch (PDOException $ex) {
        error_log("Database query error: " . $ex, 0);
        $response = new Response();
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('There was an issue creating Users - please try again' . $ex);
        $response->send();
        exit;
    }
} else {
    $returnData = $row;
    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->setData($returnData);
    $response->send();
    exit;
}
