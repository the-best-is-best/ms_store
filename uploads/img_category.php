<?php
require_once('../models/response.php');
if ($_SERVER['REQUEST_METHOD']  !== 'POST') {
    $response = new Response();
    $response->setHttpStatusCode(405);
    $response->setSuccess(false);
    $response->addMessage('Request method not allowed');
    $response->send();
    exit;
}
$response = new Response();
$upload_dir = 'storage/category/img/';

if ($_FILES['cat_img']) {
    $fileName = basename($_FILES["cat_img"]["name"]);

    $targetFilePath = $upload_dir . $fileName;

    $cat_img_name = $_FILES["cat_img"]["name"];
    $cat_img_tmp_name = $_FILES["cat_img"]["tmp_name"];
    $cat_img_size = $_FILES["cat_img"]["size"];
    $error = $_FILES["cat_img"]["error"];
    $type = $_FILES["cat_img"]["type"];

    if ($error > 0) {
        $response->setHttpStatusCode(500);
        $response->setSuccess(false);
        $response->addMessage('Error uploading the file!' . $ex);
        $response->send();
        exit;
    } else {
        $fileExt = explode('.', $cat_img_name);
        $fileActualExt = strtolower(end($fileExt));
        $allowTypes = array('png', 'jpg', 'jpeg');

        if (in_array($fileActualExt, $allowTypes)) {
            if ($cat_img_size < 5000000) {

                $fileNameNew = uniqid('', true) . "." . $fileActualExt;
                $fileDestination = $upload_dir . $fileNameNew;
                try {
                    move_uploaded_file($cat_img_tmp_name, "../" . $fileDestination);
                    $pathImage = ["path_image" => $fileDestination];
                    $response->setHttpStatusCode(200);
                    $response->setSuccess(true);
                    $response->setData($pathImage);
                    $response->addMessage('img uploaded');
                    $response->send();
                    exit;
                } catch (Exception $ex) {
                    $response->setHttpStatusCode(500);
                    $response->setSuccess(false);
                    $response->addMessage('error img not uploaded');
                    $response->send();
                    exit;
                }
            } else {
                $response->setHttpStatusCode(500);
                $response->setSuccess(false);
                $response->addMessage('image is big only support max size is 5 mb ');
                $response->send();
                exit;
            }
        } else {
            $response->setHttpStatusCode(500);
            $response->setSuccess(false);
            $response->addMessage('Support only png , jpg jpeg');
            $response->send();
            exit;
        }
    }
} else {
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage('No file was sent!');
    $response->send();
    exit;
}
