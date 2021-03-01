FROM ubuntu:14.04

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y build-essential libxml2-dev apache2 apache2-dev gzip
RUN echo "export PATH=/usr/local/bin:/usr/local/sbin:$PATH" >> ~/.bashrc
RUN apt-get install -y libapache2-mod-php5 --no-install-recommends

RUN apt-get install -y wget && cd /tmp && wget http://php.net/distributions/php-5.3.29.tar.bz2

RUN tar -xvf /tmp/php-5.3.29.tar.bz2 && cd php-5.3.29 && ./configure --with-apxs2=/usr/bin/apxs2

RUN cd php-5.3.29 && make && make install

EXPOSE 80

COPY docker/httpd-foreground /usr/local/bin/
RUN chmod 777 /usr/local/bin/httpd-foreground
CMD ["httpd-foreground"]
#ENTRYPOINT ["service apache2 restart"]