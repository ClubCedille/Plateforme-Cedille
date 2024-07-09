FROM python:3.9-slim AS builder

WORKDIR /app

COPY wiki/ .

RUN pip install mkdocs mkdocs-material pymdown-extensions

RUN mkdocs build -f mkdocs-fr.yml -d site/fr

RUN mkdocs build -f mkdocs-en.yml -d site/en

FROM nginx:alpine

COPY --from=builder /app/site/ /usr/share/nginx/html/

COPY wiki/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/cache/nginx /var/run && \
    chown -R nginx:nginx /var/cache/nginx /var/run

USER nginx

EXPOSE 8000
