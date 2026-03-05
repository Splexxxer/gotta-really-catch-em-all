up:
	docker compose up --build

up-dev:
	docker compose --profile dev up --build -d

down:
	docker compose --profile dev down --remove-orphans

logs:
	docker compose logs -f --tail=200

backend-test:
	cd backend && python -m pytest -q

backend-lint:
	cd backend && ruff check . && ruff format --check .

db-nuke:
	docker compose --profile dev down -v --remove-orphans
	docker compose --profile dev up -d --build