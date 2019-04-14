ARG DEBIAN_VERSION=stable
FROM debian:${DEBIAN_VERSION}

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
RUN sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list  \
 && apt-get update -y --no-install-recommends \
 && apt-get upgrade -y --no-install-recommends \
 && apt-get install -y --no-install-recommends \
     apt-utils \
     apt-transport-https \
     ca-certificates \
     software-properties-common \
     curl \
     vim-tiny \
     tar \
     procps \
 && apt-get dist-upgrade -y --no-install-recommends -o Dpkg::Options::="--force-confold" \
 && curl -s -L "https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-amd64.tar.gz" | tar xz -C / \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/init"]
