FROM alpine:3.18

ENV type edge
ENV listenport 61099
ENV devicename edge0
ENV interfaceaddress 10.9.9.1
ENV communityname n2n-net
ENV Encryptionkey mypass
ENV supernodenet 192.168.3.108:61099
ENV OPTIONS ""

RUN buildDeps=" \
        build-base \
        cmake \
        curl \
        linux-headers \
        openssl-dev \
        unzip \
        "; \
        set -x \
        && apk add --update openssl \
        && apk add $buildDeps \
        && mkdir -p /usr/src \
        && cd /usr/src \
        && curl https://codeload.github.com/ntop/n2n/zip/refs/heads/3.0-stable -o n2n.zip \
        && unzip n2n.zip \
        && cd n2n-3.0-stable \ 
        && cmake . \
        && make install\
        && cd / \
        && rm -fr /usr/src/n2n-3.0-stable \
        && apk del $buildDeps \
        && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
