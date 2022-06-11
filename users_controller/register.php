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

$userName = trim($jsonData->userName);
$password = trim($jsonData->password);
$email = trim($jsonData->email);

$passwordHash = password_hash($password, PASSWORD_DEFAULT);

try {

    $query = $writeDB->prepare("SELECT id FROM users_" . DB::$AppName . " WHERE email = :email AND loginBySocial=0");
    $query->bindParam(':email', $email, PDO::PARAM_STR);
    $query->execute();

    $rowCount = $query->rowCount();
    if ($rowCount !== 0) {
        $response = new Response();
        $response->setHttpStatusCode(409);
        $response->setSuccess(false);
        $response->addMessage('Email already exists');
        $response->send();
        exit;
    }
    $num = rand(10000, 99999);
    $msg = "
    <html>
     <head>
       <title> TBIB Store  </title>
     </head>
        <body>
            <h3> This is an automated email - do'nt replay </h3>
            <h4> Please follow this Link to active your account </h4>
            <h4> Code Number : $num </h4>
        </body> 
    </html>";
    $num = "r" . $num;

    $headers = "MIME-Version: 1.0" . "\r\n";
    $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
    $headers .= "From: meshoraouf500@gmail.com";
    if (mail($jsonData->email, "TBIB Store - Please Active Your Email", $msg, $headers)) {
        $query = $writeDB->prepare("INSERT into users_" . DB::$AppName . "(userName , password  , email , code)
        VALUES (:userName , :password  , :email , :code)");

        $query->bindParam(':userName', $userName, PDO::PARAM_STR);
        $query->bindParam(':password', $passwordHash, PDO::PARAM_STR);
        $query->bindParam(':email', $email, PDO::PARAM_STR);
        $query->bindParam(':code', $num, PDO::PARAM_STR);

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

        $response = new Response();
        $response->setHttpStatusCode(201);
        $response->setSuccess(true);
        $response->addMessage('Users Created');
        $response->send();

        exit;
    } else {
        $response = new Response();
        $response->setHttpStatusCode(409);
        $response->setSuccess(false);
        $response->addMessage('Server issue');
        $response->send();
        exit;
    }
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('There was an issue creating Users - please try again' . $ex);
    $response->send();
    exit;
}
