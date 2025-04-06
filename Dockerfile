FROM lsiobase/ubuntu:jammy

ARG DEBIAN_FRONTEND="noninteractive"
ARG HYPERHDR_URL="https://github.com/awawa-dev/HyperHDR/releases/download"
ARG HYPERHDR_VERSION=
ARG ARCH=
ARG FILENAME="HyperHDR-${HYPERHDR_VERSION}-Linux-${ARCH}.deb"
ARG DOWNLOAD_LINK="${HYPERHDR_URL}/v${HYPERHDR_VERSION}/${FILENAME}"

# Update package lists
RUN apt-get update

# Install required packages
RUN apt-get install -y --no-install-recommends wget

# Download HyperHDR
RUN echo "**** downloading HyperHDR from ${DOWNLOAD_LINK} ****" && \
    wget -qP /tmp ${DOWNLOAD_LINK}

# Install HyperHDR
RUN apt install -y /tmp/${FILENAME}

# Cleanup to reduce image size
RUN rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8090 8092 19400 19444 19445
RUN chmod +x /etc/services.d/*/run
VOLUME /config
