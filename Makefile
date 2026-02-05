up:
	docker compose up --build

down:
	docker compose down

logs:
	docker compose logs -f --tail=200

backend-test:
	cd backend && python -m pytest -q

backend-lint:
	cd backend && ruff check . && ruff format --check .
