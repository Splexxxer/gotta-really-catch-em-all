# Admin Guide

Use the Traefik dashboard at http://localhost:8080 (dev only) to verify routing. Database data persists inside the `pgdata` volume; remove it with `docker volume rm gotta-really-catch-em-all_pgdata` when you need a clean slate.

Before starting any stack (locally or in CI), copy `.env.example` to `.env`, replace every `POSTGRES_*` credential with unique values, and store the file securely—Traefik/Compose now refuse to boot if those secrets are absent so we never ship containers that accept the default `examapp` password. Rotate the credentials and recreate the `pgdata` volume immediately if a secret leaks.
