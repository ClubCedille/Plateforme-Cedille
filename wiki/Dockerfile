FROM python:3.9-slim AS builder

WORKDIR /app

COPY wiki/ .

RUN pip install mkdocs mkdocs-material pymdown-extensions

RUN mkdocs build -f mkdocs-fr.yml -d site/fr

RUN mkdocs build -f mkdocs-en.yml -d site/en

FROM ghcr.io/nginxinc/nginx-unprivileged:stable-alpine

COPY --from=builder /app/site/ /usr/share/nginx/html/

COPY --from=builder /app/docs/assets/* /usr/share/nginx/html/fr/assets/
COPY --from=builder /app/docs/assets/* /usr/share/nginx/html/en/assets/
COPY --from=builder /app/docs/stylesheets/* /usr/share/nginx/html/en/stylesheets/

COPY wiki/nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080
