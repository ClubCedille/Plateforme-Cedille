FROM python:3.9-slim AS builder

WORKDIR /app

COPY wiki/ .

RUN pip install mkdocs mkdocs-material pymdown-extensions

RUN mkdocs build -f mkdocs-fr.yml -d site/fr

RUN mkdocs build -f mkdocs-en.yml -d site/en

FROM nginx:alpine

COPY --from=builder /app/site/ /usr/share/nginx/html/

COPY wiki/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/cache/nginx /var/run /var/log/nginx /tmp/client_temp /tmp/proxy_temp_path /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp && \
    touch /tmp/nginx.pid && \
    chown -R nginx:nginx /var/cache/nginx /var/run /var/log/nginx /tmp /etc/nginx/conf.d /tmp/nginx.pid && \
    chmod -R 755 /var/cache/nginx /var/run /var/log/nginx /tmp /etc/nginx/conf.d

USER nginx

EXPOSE 8000
