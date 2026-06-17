#!/bin/sh

# Redis startup script with environment variable support
exec redis-server \
	--dir /data \
	--bind 0.0.0.0 \
	--port 6379 \
	--requirepass "${REDIS_PASSWORD}" \
	--save 900 1 \
	--save 300 10 \
	--save 60 10000 \
	--appendonly yes \
	--appendfsync everysec \
	--maxmemory 256mb \
	--maxmemory-policy allkeys-lru \
	--loglevel notice