# Developer Guide

1. Use your preferred Python 3.12 environment for local tooling (tests, linting) when needed.
2. Install backend dependencies locally with `pip install -e "./backend[dev]"` for editor support.
3. Start the stack: `docker compose up --build`.
4. Run tests or linting locally via `make backend-test` and `make backend-lint`.
