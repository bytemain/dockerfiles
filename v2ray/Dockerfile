FROM abiosoft/caddy:1.0.3
LABEL maintainer "artin lengthmin@gmail.com"

ARG TZ="Asia/Shanghai"
ARG ACME_AGREE="true"
ARG ENABLE_TELEMETRY="false"

ARG V2RAY_VERSION="v4.23.1" 
ARG V2RAY_LOG_DIR="/var/log/v2ray"
ARG V2RAY_CONFIG_DIR="/etc/v2ray/"
ENV V2RAY_DOWNLOAD_URL https://github.com/v2ray/v2ray-core/releases/download/${V2RAY_VERSION}/v2ray-linux-64.zip

RUN apk upgrade --update \
    && apk add \
    bash \
    tzdata \
    curl \
    && mkdir -p \ 
    ${V2RAY_LOG_DIR} \
    ${V2RAY_CONFIG_DIR} \
    /tmp/v2ray \
    && curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip ${V2RAY_DOWNLOAD_URL} \
    && pwd \
    && unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray/ \
    && mv /tmp/v2ray/v2ray /usr/bin \
    && mv /tmp/v2ray/v2ctl /usr/bin \
    && mv /tmp/v2ray/vpoint_vmess_freedom.json /etc/v2ray/config.json \
    && chmod +x /usr/bin/v2ray \
    && chmod +x /usr/bin/v2ctl \
    && apk del curl \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /tmp/v2ray /var/cache/apk/*

# node
RUN apk add --no-cache util-linux nodejs

WORKDIR /srv

COPY . /srv/

ADD entrypoint.sh /entrypoint.sh

RUN ["chmod", "+x", "/entrypoint.sh"]

VOLUME /srv

EXPOSE 443 80

ENTRYPOINT ["/entrypoint.sh"]
