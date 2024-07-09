FROM python:3.9-slim AS builder

WORKDIR /app

COPY . .

RUN pip install mkdocs mkdocs-material pymdown-extensions

RUN mkdocs build -f mkdocs-fr.yml -d site/fr

RUN mkdocs build -f mkdocs-en.yml -d site/en

FROM nginx:alpine

COPY --from=builder /app/site/ /usr/share/nginx/html/

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8000
