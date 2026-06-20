FROM alpine:3.18

RUN apk add --no-cache redis && \
	addgroup -S redis 2>/dev/null || true && \
	adduser -S -G redis redis 2>/dev/null || true


RUN mkdir -p /etc/redis /var/lib/redis /data && \
	chown -R redis:redis /var/lib/redis /data


EXPOSE 6379


COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

USER redis

ENTRYPOINT ["/init.sh"]