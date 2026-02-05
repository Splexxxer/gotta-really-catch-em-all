# ---- base ----
FROM python:3.12-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Create non-root user
RUN useradd -m appuser

WORKDIR /app

# ---- deps ----
FROM base AS deps
RUN pip install --no-cache-dir --upgrade pip
COPY pyproject.toml /app/pyproject.toml
RUN pip install --no-cache-dir ".[dev]"

# ---- runtime ----
FROM base AS runtime
COPY --from=deps /usr/local /usr/local
COPY app /app/app

USER appuser

EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
