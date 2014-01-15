<?php

$mysqlnd=extension_loaded('mysqlnd');
$mysql=extension_loaded('mysql');
$mysqli=extension_loaded('mysqli');
if ($mysqlnd || $mysql || $mysqli) {
   echo "MYSQL extension is loaded [$mysqlnd, $mysql, $mysqli]";
}elseif (function_exists('mysql_connect')){
   echo 'MYSQL functions are available';
}else{
   echo "MySQL not loaded";
   exit;
}

$db_host="127.0.0.1";
$db_username="root";
$db_password="password";
echo "Testing $db_host ";
if(mysqli_connect($db_host,$db_username,$db_password, "joomla311")){
 echo "Success";
}else{
 echo "DB Connection failed";
}

