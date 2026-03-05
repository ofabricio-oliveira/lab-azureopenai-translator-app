.PHONY: install run test lint

install:
	pip install -r requirements.txt

run:
	uvicorn app.main:app --reload

test:
	pytest tests/

lint:
	flake8 app/
