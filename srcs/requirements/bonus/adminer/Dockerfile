FROM debian:bullseye

RUN apt-get update && apt-get install -y --no-install-recommends \
    apache2 \
    php \
    php-mysql \
    libapache2-mod-php \
    wget \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*


RUN mkdir -p /var/www/html && \
    rm -f /var/www/html/index.html && \
    wget -q -O /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php && \
    chown -R www-data:www-data /var/www/html && \
    chmod 755 /var/www/html && \
    chmod 644 /var/www/html/index.php


RUN sed -i 's/Listen 80/Listen 8082/' /etc/apache2/ports.conf && \
    sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8082>/' /etc/apache2/sites-available/000-default.conf


EXPOSE 8082

CMD ["apachectl", "-D", "FOREGROUND"]