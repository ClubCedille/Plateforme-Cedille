FROM python:3.12-slim AS builder

WORKDIR /app

ARG WIKI_DIR="wiki/"
COPY ${WIKI_DIR} .

RUN pip3 install \
    mkdocs==1.6.1\
    mkdocs-material==9.5.44 \
    mkdocs-material-extensions==1.3.1 \
    mkdocs-mermaid2-plugin==1.2.1

RUN mkdocs build -f mkdocs-fr.yml -d site/fr
RUN mkdocs build -f mkdocs-en.yml -d site/en

FROM nginx:alpine

COPY --from=builder /app/site/fr /app/fr/
COPY --from=builder /app/site/en /app/en/

COPY --from=builder /app/nginx-server-block.conf /usr/share/nginx/conf/server_blocks/wiki_server_block.conf

EXPOSE 8080
