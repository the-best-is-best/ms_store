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

if (!isset($jsonData->email)) {

    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);


    $response->addMessage("Not allowed");

    $response->send();
    exit;
}


$query = $writeDB->prepare("SELECT * FROM users_" . DB::$AppName . " WHERE email = :email AND email_active=1 AND loginBySocial=0");
$query->bindParam(':email', $jsonData->email, PDO::PARAM_STR);

$query->execute();
$row = $query->fetch();
if (empty($row)) {

    $response = new Response();
    $response->setHttpStatusCode(409);
    $response->setSuccess(false);

    $response->addMessage('Email Not Found');
    $response->send();
    exit;
}
$num = rand(10000, 99999);
$msg = "
<html>
 <head>
   <title> MS Store  </title>
 </head>
    <body>
        <h3> This is an automated email - do'nt replay </h3>
        <h4> Please follow this Link to active your account </h4>
        <h4> Code Number : $num </h4>
    </body> 
</html>";
$num = "l" . $num;

$headers = "MIME-Version: 1.0" . "\r\n";
$headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
$headers .= "From: meshoraouf500@gmail.com";
if (mail($jsonData->email, "MS Store - Please Active Your Email", $msg, $headers)) {
    $query = $writeDB->prepare("UPDATE users_" . DB::$AppName . "  SET code = :code WHERE email = :email AND loginBySocial=0");
    $query->bindParam(':email', $jsonData->email, PDO::PARAM_STR);

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
    $response->addMessage('Code Generated');
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
