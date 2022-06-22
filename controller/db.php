<?php

class DB
{
    public static $urlSite = "http://192.168.1.5/tbib_store_2022/large_store/";
    public static $AppName = "tbib_store";
    private static $DBConnection;
    private static $DBHost = "localhost";
    private static $DBName = "tbib_store";
    private static $DBUser = "root";
    private static $DBPass = "";




    public static function connectionDB()
    {
        if (self::$DBConnection === null) {
            self::$DBConnection = new PDO('mysql:host=' . self::$DBHost . ';dbname=' . self::$DBName . '; charset=utf8', self::$DBUser, self::$DBPass);
            self::$DBConnection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            self::$DBConnection->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
        }

        return self::$DBConnection;
    }
}
