<?php
header('Content-type: text/plain');  //for /n
//Connection to Redis Server on localhost
$redis = new Redis();
$redis->connect('172.19.0.2', 6379);
echo "Connection to server sucessfully\n";

// echo "Set string in redis:\n" .$redis->set('tutorial-name','Redis Tutorial');
echo "Set string in redis\n";
$redis->set('tutorial-name',"Redis Tutorial");
echo "Get string in redis:" .$redis->get("tutorial-name");

?>