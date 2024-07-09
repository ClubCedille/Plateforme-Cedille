FROM python:3.9-slim AS builder

WORKDIR /app

COPY wiki/ .

RUN pip install mkdocs mkdocs-material pymdown-extensions

RUN mkdocs build -f mkdocs-fr.yml -d site/fr

RUN mkdocs build -f mkdocs-en.yml -d site/en

FROM ghcr.io/nginxinc/nginx-unprivileged:stable-bookworm-perl

COPY --from=builder /app/site/fr /usr/share/nginx/html/
COPY --from=builder /app/site/en /usr/share/nginx/html/en/

COPY --from=builder /app/docs/assets/* /usr/share/nginx/html/en/assets/
COPY --from=builder /app/docs/assets/* /usr/share/nginx/html/assets/
COPY --from=builder /app/docs/stylesheets/* /usr/share/nginx/html/en/stylesheets/
COPY --from=builder /app/docs/stylesheets/* /usr/share/nginx/html/stylesheets/

COPY wiki/nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080
