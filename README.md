# Gotta really catch em all

Docker-first scaffold with FastAPI backend, placeholder frontend, PostgreSQL, and Traefik routing so the stack runs with a single `docker compose up --build`.

## Getting Started

1. Ensure you have a Python 3.12 environment available for local tooling when needed.
2. Copy `.env.example` to `.env` and adjust secrets if needed.
3. Build and run everything: `docker compose up --build`.
4. Visit:
   - Frontend placeholder: http://localhost/
   - Backend health check: http://localhost/api/health
   - Traefik dashboard (dev only): http://localhost:8080

## Local Tooling

- `make up` – rebuild and start the stack.
- `make down` – stop and remove the stack.
- `make logs` – follow the last 200 log lines.
- `make backend-test` – run FastAPI tests with pytest.
- `make backend-lint` – Ruff lint + format check.

## Next Steps

- Replace the frontend placeholder with Vite/React.
- Flesh out `scripts/gen-client.sh` to generate API clients from OpenAPI.
- Wire CI to run linting, tests, and compose builds.
