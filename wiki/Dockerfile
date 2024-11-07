FROM python:3.9-slim AS builder

WORKDIR /app

ARG WIKI_DIR="wiki/"
COPY ${WIKI_DIR} .

RUN pip install mkdocs mkdocs-material pymdown-extensions
RUN mkdocs build -f mkdocs-fr.yml -d site/fr
RUN mkdocs build -f mkdocs-en.yml -d site/en

RUN mkdir -p /app/site/fr/.well-known/acme-challenge

FROM ghcr.io/nginxinc/nginx-unprivileged:stable-bookworm-perl

COPY --from=builder /app/site/fr /usr/share/nginx/html/
COPY --from=builder /app/site/en /usr/share/nginx/html/en/

COPY --from=builder /app/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /tmp/client_temp /tmp/proxy_temp /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp

EXPOSE 8080
