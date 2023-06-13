FROM python:3.10-alpine3.17

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

USER root

WORKDIR /app

COPY . .

# Lockdown file ownership and permissions
RUN addgroup -S appgroup && adduser -S appuser -G appgroup && \ 
    chown appuser:appgroup app.py && \
    chmod 774 app.py && \
    pip install -r requirements.txt

USER appuser

EXPOSE 5000

CMD ["flask", "run"]