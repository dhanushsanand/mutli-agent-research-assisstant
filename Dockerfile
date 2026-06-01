FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    REFLEX_TELEMETRY_ENABLED=false \
    PORT=7860

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl git unzip \
    && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml uv.lock ./
RUN pip install --no-cache-dir --upgrade pip uv \
    && uv pip install --system -e .

COPY . .

EXPOSE 7860

CMD ["reflex", "run", "--env", "prod", "--single-port", "--frontend-port", "7860", "--backend-host", "0.0.0.0"]