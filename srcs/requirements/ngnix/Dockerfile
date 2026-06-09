FROM    debian:bullseye

RUN     apt-get update && apt-get install -y nginx openssl

COPY    nginx.conf /etc/nginx/nginx.conf

RUN     

EXPOSE  433

CMD     ["nginx" , "-g" , "daemo off;"]