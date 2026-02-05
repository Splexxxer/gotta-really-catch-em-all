# Tech Stack & Engineering Plan (exam-ready)

## Target Vision
Multi-user web application in a microservice-style setup with clearly separated services,
reproducible deployments (Infrastructure as Code), and a strong DevOps focus.

The system is deployed as multiple containers communicating exclusively via the network stack.
A reverse proxy acts as the single entry point.

---

## Architecture (Containers & Networking)

### Services (Docker Compose)
- **reverse-proxy (Traefik)**
  - Single entry point (Ingress) for frontend and backend
  - Local TLS termination (development certificates)
  - Path-based routing:
    - `/api/*` → backend
    - `/` → frontend
- **frontend**
  - React Single Page Application
- **backend**
  - FastAPI-based REST API
- **db**
  - PostgreSQL database

### Networking Principles
- Only the reverse proxy is exposed to the outside world
- Backend and database are **not publicly reachable**
- The database is accessible **only** from the backend container
- All inter-service communication happens via Docker networks

### Rationale for the Reverse Proxy
While not strictly required for the exam, a reverse proxy is deliberately included:
- Establishes a single entry point and reduces the attack surface
- Keeps the database strictly internal
- Centralizes TLS termination, routing, and security headers
- Results in a more realistic and professional deployment blueprint for a multi-user web application

---

## Frontend

### Technology
- **React**
- **Vite**
- **TypeScript**
- **Tailwind CSS**

### API Integration (mandatory requirement)
- **OpenAPI-based client generation** (no handwritten API clients)
- Tooling: **openapi-generator**
- Generated TypeScript client is committed and located at:
```

frontend/src/api/generated/

```

### Quality & Tooling
- ESLint (optionally with Prettier)
- Vitest for unit/component tests
- Optional: Playwright for end-to-end tests (time permitting)

---

## Backend

### Technology
- **Python 3.11 / 3.12**
- **FastAPI** (REST API with OpenAPI specification out of the box)
- **SQLModel / SQLAlchemy** (ORM)
- **PostgreSQL**

### Code Quality
- **Ruff** for linting and formatting
- `ruff check .`
- `ruff format --check .`

### Testing
- **Pytest**
- At least **5 unit tests** (exam requirement)

### Authentication
- **JWT-based authentication**
- Optional role/claim support (e.g. `user`, `admin`) if relevant for the application

---

## Database (PostgreSQL)

### Technology
- **PostgreSQL 16** (or 15 if required)
- Persistent storage via Docker volumes

### Access & Security
- Dedicated `db` container
- No external port mapping
- Access restricted to the backend service only

### Configuration & Secrets
- No secrets stored in the repository
- Configuration via environment variables and `.env.example`
- `POSTGRES_DB`
- `POSTGRES_USER`
- `POSTGRES_PASSWORD`
- `DATABASE_URL` (used by the backend)

### Schema & Migrations
- ORM: SQLModel / SQLAlchemy
- Database migrations via **Alembic**
- Versioned migrations stored in `backend/migrations`
- Workflow:
  - `alembic revision --autogenerate`
  - `alembic upgrade head`

### Development & Administration (optional)
- Optional admin UI (pgAdmin/Adminer) via Docker Compose profile
- Enabled only for local development, never in production

### Backup & Restore (documented, lightweight)
- Backups via `pg_dump`
- Restore via `psql` / `pg_restore`
- Documented in `docs/admin.md`

---

## API Design (Proper REST)
- Resource-oriented endpoints (e.g. `/users`, `/items`, `/invites`)
- Standard HTTP methods: GET, POST, PUT, PATCH, DELETE
- Correct use of HTTP status codes
- Consistent error responses
- Minimum **5 API endpoints**, covering:
- read
- write
- delete
- Endpoints must be actively used by the frontend

---

## Infrastructure as Code

### Docker
- **Docker Compose** as the single source of truth for deployment
- Multi-stage builds to minimize image size
- `.dockerignore` files are mandatory
- Backend containers run as **non-root users**

### Reverse Proxy
- Traefik handles routing and TLS
- Backend is reachable only through `/api`
- Frontend served through the same ingress

---

## CI/CD (DevOps Lifecycle)

### Goals
- Automated linting, testing, image builds, and registry pushes
- Reproducible OCI images
- Clear and auditable pipeline stages

### Container Registry & Tagging Strategy
- Registry: **GitHub Container Registry (GHCR)**
- Image names:
```

ghcr.io/<org>/<repo>-frontend
ghcr.io/<org>/<repo>-backend

```
- Tagging:
- Always: commit SHA (`sha-<commit>`)
- Branch tag: `main`
- Release tags: Semantic Versioning (`v1.0.0`, `v1.1.0`, …)
- `latest` is not relied upon for reproducibility

### GitHub Actions (planned)
Minimal pipeline jobs:
1. **backend-lint-test**
 - Ruff checks
 - Pytest
2. **frontend-lint-test**
 - ESLint
 - Vitest
3. **generate-openapi-client**
 - Generate and validate OpenAPI client
4. **build-images**
 - Docker Buildx (multi-stage)
5. **push-images**
 - Push images to GHCR
6. **security**
 - SBOM generation via **syft**
 - Optional image scanning via Trivy

---

## Git Workflow & Quality Gates

### Signed Commits
- **SSH-based commit signing is mandatory**
- Branch protection enforces signed commits
- Documented setup instructions in developer documentation

### Branching & Reviews
- `main` branch is protected
- All changes via pull requests
- At least one reviewer required
- CI checks must pass before merge
- Squash or linear history enforced

### Local Tooling
- Optional pre-commit hooks
- Makefile or task runner for common workflows:
- lint
- test
- generate client
- start/stop stack

---

## Security Concepts (visible and exam-relevant)
- JWT authentication
- Restrictive CORS configuration
- Internal-only database
- No secrets in version control
- Least-privilege database user
- SBOM generation and optional image scanning

---

## Documentation
Separate Markdown documentation:
- **User documentation** – features and usage overview
- **Developer documentation** – setup, tooling, workflows, signing
- **Admin documentation** – deployment, configuration, registry usage

---

## Repository Structure (high-level)
- `/frontend`
- `/backend`
- `/infra` (proxy config, compose overrides)
- `/docs`
- `user.md`
- `dev.md`
- `admin.md`
- `docker-compose.yml`
- `.github/workflows/`

---

## Evaluation Drivers
- Microservice-style deployment using containers and networking
- OpenAPI client generation (mandatory)
- CI/CD with OCI image push (mandatory)
- Signed commits, reviews, and clean history
- Visible security practices and tooling

