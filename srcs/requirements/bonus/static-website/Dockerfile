FROM alpine:3.18


# Install Nginx
RUN apk add --no-cache nginx

# Create necessary dir and user
RUN mkdir -p /var/www/static /var/run/nginx && \
	addgroup -S nginx 2>/dev/null || true && \
	adduser -S -G nginx nginx 2>/dev/null || true

# Copy Nginx configuration
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Copy static website files
COPY www/ /var/www/static/

# Set permissions
RUN chown -R nginx:nginx /var/www/static && \
	chmod -R 755 /var/www/static && \
	chown -R nginx:nginx /var/run/nginx

# Expose port
EXPOSE 8081

# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]