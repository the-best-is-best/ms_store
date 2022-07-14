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
    $response->setHttpStatusCode(405);;
    $response->setSuccess(false);
    $response->addMessage('Request method not allowed');
    $response->send();
    exit;
}


try {
    if (!isset($_GET['email']) || !isset($_GET['password'])) {
        $response = new Response();
        $response->setHttpStatusCode(405);

        $response->setSuccess(false);
        $response->addMessage('Not allowed');
        $response->send();
        exit;
    }



    $query = $writeDB->prepare("SELECT * FROM users_" . DB::$AppName . " WHERE email = :email AND loginBySocial=0");
    $query->bindParam(':email', $_GET['email'], PDO::PARAM_STR);

    $query->execute();
    $row = $query->fetch();
    if (empty($row)) {
        $response = new Response();
        $response->setHttpStatusCode(409);
        $response->setSuccess(false);
        $response->addMessage('Check your email or password');
        $response->send();
        exit;
    }

    if (password_verify($_GET['password'], $row['password'])) {
        if ($row['email_active'] == 0) {
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
            $num = "r" . $num;

            $headers = "MIME-Version: 1.0" . "\r\n";
            $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
            $headers .= "From: meshoraouf500@gmail.com";
            if (mail($_GET['email'], "MS Store - Please Active Your Email", $msg, $headers)) {
                $query = $writeDB->prepare("UPDATE users_" . DB::$AppName . " SET  code = :code where  email = :email  ");
                $query->bindParam(':code', $num, PDO::PARAM_STR);
                $query->bindParam(':email', $_GET['email'], PDO::PARAM_STR);

                $query->execute();
                $returnData = $row;
                $response = new Response();
                $response->setHttpStatusCode(200);
                $response->setSuccess(true);
                $response->setData($returnData);
                $response->addMessage('Active Email');

                $response->send();
                exit;
            }
        } else {
            $returnData = $row;
            $response = new Response();
            $response->setHttpStatusCode(200);
            $response->setSuccess(true);
            $response->setData($returnData);

            $response->send();
            exit;
        }
    } else {
        $response = new Response();
        $response->setHttpStatusCode(409);
        $response->setSuccess(false);
        $response->addMessage('Check your email or password');
        $response->send();
        exit;
    }
} catch (PDOException $ex) {
    error_log("Database query error: " . $ex, 0);
    $response = new Response();
    $response->setHttpStatusCode(500);

    $response->setSuccess(false);
    $response->addMessage('There was an issue Get Users - please try again' . $ex);
    $response->send();
    exit;
}
