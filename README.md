# Redis-LAMP
As we know LAMP (Linux Apache MySQL and PHP) and Redis is a key/value database and a NoSQL database and completely different from MySQL. This is the way to add Redis into LAMP stack.
It has been useful if the design is stored key/value pair we can pass this value to LAMP to display on the website. In order to that we need to install PHP extension to support Redis. See Ref. for details.
This option is build-in Dockerfile which will have Apache and PHP. When running phpinfo() in /src/index2.php and if everything works should see PHP has Redis supported see below.
![PHP support Redis](https://github.com/thomasalvatran/Redis-LAMP/blob/master/src/img/2019-09-07%2010_53_36-Greenshot.png)

