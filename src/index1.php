<?php 
//Cnnecgtion redis
  $redis = new Redis();
  $redis->connect('172.19.0.2', 6379);
  // $redis->connect('127.0.0.1:6379');
  echo "Connection server successfully\n ";
  //check whether server is running or not 
  echo "Server is running: ".$redis->ping();
?>
