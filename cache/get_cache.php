<?php
require_once('../models/response.php');

if ($_SERVER['REQUEST_METHOD']  !== 'GET') {
    $response = new Response();
    $response->setHttpStatusCode(405);
    $response->setSuccess(false);
    $response->addMessage('Request method not allowed');
    $response->send();
    exit;
}

$json = json_decode(file_get_contents('cache.json'), TRUE);
$response = new Response();
$response->setHttpStatusCode(200);
$response->setSuccess(true);
$response->setData($json);
$response->addMessage('Get Cache key');
$response->send();
exit;
