lamp:t1
======= 
LAMP image (Linux Apache MySQL PHP)
A simplified version of tutum/lamp

Usage
-----

To create the image `lamp:t1`, execute the following command on the folder where Dockerfile is located:

	$ docker build -t lamp:t1 .

if You want to push the image to dockerhub,
        $ docker tag lamp:t1 username/lamp:t1
	$ docker push username/lamp:t1


Running  image
------------------------------

Stop local apache/mysql to release port 80 and 3306 for the to-be-runned lamp container
Start image binding external ports 80 and 3306 to your container:

	$ docker run -d -p 80:80 -p 3306:3306 lamp:t1

Test your deployment:

	$ curl http://localhost/


ADD PHP application
-----------------------------------

to add a php app from github ex1.git
Create a new `Dockerfile` in an empty folder with the following contents:

	FROM lamp:t1
	RUN git clone https://github.com/username/ex1.git /app
	EXPOSE 80 3306
	CMD ["/run.sh"]

to build image containing app ex1

	$ docker build -t username/mylamp-ex1 .

And test it:

	$ docker run -d -p 80:80 -p 3306:3306 username/mylamp-ex1

Test your deployment:

	curl http://localhost/



Connecting to the MySQL server from within the container
----------------------------------------------------------------

The bundled MySQL server has a `root` user with no password for localhost connections.

	<?php
	$mysql = new mysqli("localhost", "root");
	echo "MySQL Server info: ".$mysql->host_info;
	?>


Connecting to the  MySQL server from outside the container
-----------------------------------------------------------------
env varss 
ENV Mysql_user0 admin
ENV Mysql_pass0 admin_pass

connet to mysqlserver by

 	$ mysql -uadmin -padmin_pass -h host_ip


Setting a specific password for the MySQL server admin account
--------------------------------------------------------------

set the env var `Mysql_pass0` to the password when running the container:

	docker run -d -p 80:80 -p 3306:3306 -e Mysqlp_pass0="mypass" lamp:t1

You can now test your new admin password:

	mysql -uadmin -p"mypass"



