FROM debian:bullseye

RUN apt-get update && apt-get install -y --no-install-recommends \
	vsftpd \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/vsftpd /var/run/vsftpd /var/log && \
	touch /var/log/vsftpd.log

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY tools/init.sh /tmp/init.sh
RUN chmod +x /tmp/init.sh

EXPOSE 21 21100-21110

ENTRYPOINT ["/tmp/init.sh"]
CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]