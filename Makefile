# Makefile for managing Rails Docker project

# Define the docker-compose service names
API_SERVICE=api
DB_SERVICE=db

# Define the database credentials and connection details
DB_USER=postgres
DB_PASSWORD=password
DB_NAME=development
DB_HOST=localhost
DB_PORT=5432

build:
	docker-compose build

start:
	docker-compose up api -d

stop:
	docker-compose down

destroy:
	docker-compose down -v

restart:
	docker-compose down
	docker-compose up --build

# Initial setup
setup:
	docker-compose build
	docker-compose up -d
	docker-compose exec api bash -c "rails db:create"
	docker-compose exec api bash -c "rails db:migrate"

# Run rails database migration
db-migrate:
	docker-compose exec api bash -c "rails db:migrate"

# Access the psql command line inside the db container
psql:
	docker-compose exec db psql -U $(DB_USER) -d $(DB_NAME)

# Access the psql command line for the development db
psql-dev:
	docker-compose exec db psql -U postgres -d development

rspec:
	docker-compose exec api bash -c "bundle exec rspec"
