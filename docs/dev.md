# Developer Guide

1. Use your preferred Python 3.12 environment for local tooling (tests, linting) when needed.
2. Install backend dependencies locally with `pip install -e "./backend[dev]"` for editor support.
3. Start the stack: `docker compose up --build`.
4. Use the provided Makefile shortcuts (all run from the repo root):
   - `make up` – builds the Docker images and brings the full stack (Traefik, backend, frontend, db) online.
   - `make down` – stops and removes the Compose stack, networks, and containers.
   - `make logs` – follows the aggregated logs from every container (last 200 lines to start) which is handy for debugging.
   - `make backend-test` – runs the backend Pytest suite inside your local environment (`python -m pytest -q`).
   - `make backend-lint` – runs Ruff linting plus a formatting check to ensure the backend matches repo standards.
