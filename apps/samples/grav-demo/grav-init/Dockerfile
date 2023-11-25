FROM alpine:3.9
# install the grav skeleton

RUN apk add --no-cache curl unzip rsync
# ensure www-data user exists
RUN set -x \
      && addgroup -g 82 -S www-data \
      && adduser -u 82 -D -S -G www-data www-data
# 82 is the standard uid/gid for "www-data" in Alpine

ARG GRAV_SKELETON_URL=https://github.com/getgrav/grav-skeleton-gateway-site/releases/download/1.0.1/grav-skeleton-gateway-site+admin-1.0.1.zip

RUN curl -sSL $GRAV_SKELETON_URL -o zip && \
    unzip -q zip && \
    rm zip && \
    mv grav-skeleton-gateway-site grav && \
    chown -R www-data:www-data grav

RUN ln -s /vault/secrets/grav /var/www/html/user/config/plugins/git-sync.yaml

