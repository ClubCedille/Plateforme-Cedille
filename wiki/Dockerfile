FROM python:3.9-slim

ARG CONFIG_FILE=mkdocs.yml

WORKDIR /app

COPY . .

RUN pip install mkdocs mkdocs-material pymdown-extensions

ENV CONFIG_FILE=${CONFIG_FILE}

CMD ["sh", "-c", "mkdocs serve -f ${CONFIG_FILE} --dev-addr=0.0.0.0:8000"]
