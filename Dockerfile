# Stage 1: Build
FROM python:3.11-slim as builder
WORKDIR /build
COPY requirements.txt .
# Install dependencies to a local folder
RUN pip install --user -r requirements.txt

# Stage 2: Runtime
FROM python:3.11-slim as runner
WORKDIR /app

COPY --from=builder /root/.local /home/appuser/.local
COPY ./app ./app

ENV PATH="/home/appuser/.local/bin:${PATH}"
ENV PYTHONPATH="/home/appuser/.local/lib/python3.11/site-packages"
EXPOSE 5000

# Run as non-root user for security
RUN useradd -m appuser
USER appuser

CMD ["python", "app/main.py"]
