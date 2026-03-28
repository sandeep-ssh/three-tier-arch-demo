FROM --platform=linux/arm64 python:3.13-slim

EXPOSE 8080

ENV INSTANA_SERVICE_NAME=payment

WORKDIR /app

COPY requirements.txt /app/

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libc6-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && apt-get purge -y gcc libc6-dev \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY *.py /app/
COPY payment.ini /app/

CMD ["uwsgi", "--ini", "payment.ini"]