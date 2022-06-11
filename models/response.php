<?php

class Response
{

    private $_success;
    private $_httpStatusCode;
    private $_messages = array();
    private $_data;
    private $_toCash = false;
    private $_responseData = array();

    public function setSuccess($success)
    {
        $this->_success = $success;
    }

    public function setHttpStatusCode($htttpStatusCode)
    {
        $this->_httpStatusCode = $htttpStatusCode;
    }

    public function addMessage($message)
    {
        $this->_messages[] = $message;
    }

    public function setData($data)
    {
        $this->_data = $data;
    }

    public function toCush($toCash)
    {
        $this->_toCash = $toCash;
    }

    public function send()
    {
        header('Content-type: application/json;charset=utf-8');

        if ($this->_toCash == true) {
            header('Cache-control: max-age=60');
        } else {
            header('Cache-control: no-chach , no-store');
        }

        if (($this->_success !== false && $this->_success !== true) || !is_numeric($this->_httpStatusCode)) {
            http_response_code(500);

            $this->_responseData['data']['statusCode'] = 500;
            $this->_responseData['data']['success'] = false;
            $this->addMessage("Response creation error");
            $this->_responseData['data']['messages'] = $this->_messages;
        } else {
            $this->_responseData['data'] = $this->_data;

            http_response_code($this->_httpStatusCode);
            $this->_responseData['statusCode'] = $this->_httpStatusCode;
            $this->_responseData['success'] = $this->_success;
            $this->_responseData['messages'] = $this->_messages;
        }
        echo json_encode($this->_responseData);
    }
}
