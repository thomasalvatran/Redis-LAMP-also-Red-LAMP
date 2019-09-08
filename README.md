# Redis-LAMP (Red LAMP)
As we know LAMP (Linux Apache MySQL and PHP) and Redis is a key/value database and a NoSQL database and completely different from MySQL. This is the way to add Redis into LAMP stack.
It has been useful if the design is stored key/value pair we can pass this value to LAMP to display on the website. In order to that we need to install PHP extension to support Redis. See Ref. for details.
This option is build-in Dockerfile which will have Apache and PHP. When running phpinfo() in /src/index2.php and if everything works should see PHP has Redis supported see below. <strong><em>Please note if runs behind a corporate proxy we need to disable proxy during docker build.</em></strong>
![PHP support Redis](https://github.com/thomasalvatran/Redis-LAMP/blob/master/src/img/2019-09-07%2010_53_36-Greenshot.png)

### Dockerfile:	
<pre>
#FROM php:7.3.2-fpm-stretch
FROM php:7.2.2-apache
# CMD echo "ServerName localhost" >> /etc/apache2/apache2.conf
# CMD ["/usr/sbin/apache2ctl", "-D", "DFOREGROUND"]
ENV EXT_REDIS_VERSION=4.3.0 EXT_IGBINARY_VERSION=3.0.1
#FROM php:7.2.2-apache
COPY src/ /var/www/html
EXPOSE 80
#ADD php.ini /usr/local/etc/php
ADD redis.ini /etc/php/7.2/apache2/conf.d/redis.ini
#ADD redis.ini /etc/php5/conf.d/redis.ini
#volumes:
# - ./web:/var/www
# - ./config/custom.php.ini:/etc/php5/apache2/conf.d/custom.php.ini
#RUN pecl install redis && docker-php-ext-enable redis
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
&& docker-php-source extract \
# igbinary
&& mkdir -p /usr/src/php/ext/igbinary \
&& curl -fsSL https://github.com/igbinary/igbinary/archive/$EXT_IGBINARY_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/igbinary --strip 1 \
&& docker-php-ext-install igbinary \
# redis
&& mkdir -p /usr/src/php/ext/redis \
&& curl -fsSL https://github.com/phpredis/phpredis/archive/$EXT_REDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
&& docker-php-ext-configure redis --enable-redis-igbinary \
&& docker-php-ext-install redis \
# cleanup
&& docker-php-source delete
2019-09-07 10_53_36-Greenshot
</pre>
### Build:
<pre>
tovantran@ubuntu:~/Downloads$ ls
git clone https://github.com/thomasalvatran/Redis-LAMP.git
cd Redis-LAMP
docker build –t lamp .
Go to redis hub.docker.com/_/redis

docker pull redis
docker images (docker image ls)  to see if 2 images lanp and redis existing then run them as the same network called multiple so they can communicate to each other.
</pre>
### Run:
<pre>
sudo docker run --net multiple --name mylamp2 -p 127.0.0.1:80:80 -v $(pwd)/src:/var/www/html/ -t lamp
sudo docker run --net multiple --name myredis -t redis
</pre>
### Checking:
<pre>
tovantran@ubuntu:~/Downloads/lamp-stack-video$ sudo docker ps
CONTAINER ID     IMAGE       COMMAND	                   	CREATED		STATUS		PORTS				NAMES
2ece59836815     lamp        "docker-php-entrypoi…"		33 minutes ago	Up 33 minutes	80/tcp				mylamp2
b4d6f37bc56e     redis       "docker-entrypoint.s…"		40 minutes ago	Up 40 minutes	6379/tcp			myredis
</pre>

### Testing:

Coding from Ref.[2] called index2.php then execute the code in a browser typing http://localhost/index2.php and resulting echo on the screen as we see it.
<pre>
Connection to server successfully
Set string in redis
Get string in redis:Redis Tutorial
index2.php (testing connection between LAMP and Redis server)	   
<?php
header('Content-type: text/plain');  //for /n
//Connection to Redis Server on localhost
$redis = new Redis();
$redis--->connect('172.19.0.2', 6379);
echo "Connection to server sucessfully\n";
 
// echo "Set string in redis:\n" .$redis-&gt;set('tutorial-name','Redis Tutorial');
echo "Set string in redis\n";
$redis-&gt;set('tutorial-name',"Redis Tutorial");
echo "Get string in redis:" .$redis-&gt;get("tutorial-name");
 
?>
</pre>

### Verifying containers for lamp:
<pre>
sudo docker exec -it 2ece59836815 bash
root@2ece59836815:/var/www/html# cat /etc/hosts
127.0.0.1 localhost
::1 localhost ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
172.19.0.3 2ece59836815  (IP of lamp container)
root@2ece59836815:/var/www/html#

#apt-get update
#apt-get install net-tools (for netstat)

root@2ece59836815:/var/www/html# netstat -tulnap | grep -i 80
tcp 0 0 0.0.0.0:80 0.0.0.0:* LISTEN 1/apache2

</pre>
