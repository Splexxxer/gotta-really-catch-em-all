# Developer Guide

1. Use your preferred Python 3.12 environment for local tooling (tests, linting) when needed.
2. Install backend dependencies locally with `pip install -e "./backend[dev]"` for editor support.
3. Copy `.env.example` to `.env`, change every `POSTGRES_*` value, and keep the file local – Compose now refuses to boot if those secrets are missing so we never fall back to `examapp` / `examapp`.
4. Start the stack: `docker compose up --build`.
5. Use the provided Makefile shortcuts (all run from the repo root):
   - `make up` – builds the Docker images and brings the full stack (Traefik, backend, frontend, db) online. The Postgres service stays internal to the Compose network, so you cannot connect to it directly from the host.
   - `make up-dev` – same stack but uses the `dev` profile which exposes the database port and runs the services in the background (`-d`) so you can connect with local tooling.
   - `make down` – stops and removes the Compose stack, networks, and containers.
   - `make logs` – follows the aggregated logs from every container (last 200 lines to start) which is handy for debugging.
   - `make backend-test` – runs the backend Pytest suite inside your local environment (`python -m pytest -q`).
   - `make backend-lint` – runs Ruff linting plus a formatting check to ensure the backend matches repo standards.
   - `make db-nuke` – tears down the dev profile stack and named volumes, then recreates everything to give you a clean database when seeding or migrations get messy.
