FROM ubuntu:14.04 
# A simplified version of tutum/lamp

# Install packages
ENV DEBIAN_FRONTEND noninteractive
ENV Mysql_user0 admin
ENV Mysql_pass0 admin_pass

RUN apt-get update && \
  apt-get -y install nano wget apache2 libapache2-mod-php5 mysql-server php5-mysql php5-mcrypt && \
  echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Add image configuration and scripts
ADD start-apache2.sh /start-apache2.sh
# ADD start-mysqld.sh /start-mysqld.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf

# ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
# ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Remove pre-installed database
# RUN rm -rf /var/lib/mysql/*
# will cause error "Access denied for user debian-sys-maint at localhost"


# Add MySQL utils
ADD create_user0.sh /create_user0.sh
RUN chmod 755 /*.sh

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite


#Enviornment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M


EXPOSE 80 3306
CMD ["/run.sh"]
