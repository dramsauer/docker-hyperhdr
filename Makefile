############################################################################
# Makefile for running hyperhdr with Docker Compose

.PHONY: up down restart logs build find-device find-arch

# Start the application
up:
	docker compose up -d

# Stop the application
down:
	docker compose down

# Restart the application
restart: down up

# View logs
logs:
	docker compose logs -f

# Build or rebuild services
build:
	docker compose build


############################################################################
# Debugging Commands
# These commands are for debugging purposes and should be used with caution.
# They may not work as expected and are not guaranteed to be safe.
# Use at your own risk.

# Finding correct device path
find-device:
	ls -l /dev/ | grep -E 'video|v4l|dri|fb|input|event'
	v4l2-ctl --list-devices

find-arch:
	@uname -m | awk '{ \
		if ($$1 == "armv7l") print "armhf"; \
		else if ($$1 == "aarch64") print "aarch64"; \
		else if ($$1 == "x86_64") print "amd64"; \
		else if ($$1 == "i386" || $$1 == "i686") print "i386"; \
		else print "unknown"; \
	}'

############################################################################