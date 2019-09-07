
<?php 
   //Connecting to Redis server on localhost 
   $redis = new Redis(); 
   //$redis->connect('127.0.0.1', 6379); 
   $redis->connect('172.19.0.2', 6379);  //docker network connect IP using docker inspect
   echo "Connection to server sucessfully<BR>";
   $redis->set("testing", "Test first 1");
   echo "Set the string testing = Test first 1<BR>";
   // Get the stored data and print it 
   echo "Get string in redis:: " .$redis->get("testing");
   //$redis→get["tutorial-name"];
?>
 