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

# Default target to build the containers
build:
	docker-compose build

# Run rails server
server:
	docker-compose up api

# Run database setup or migration in the api container
db-setup:
	docker-compose exec api bash -c "rails db:setup"

# RUn rails database migration
db-migrate:
	docker-compose exec api bash -c "rails db:migrate"

# Access the psql command line inside the db container
psql:
	docker-compose exec db psql -U $(DB_USER) -d $(DB_NAME)

# Access the psql command line for the development db
psql-dev:
	docker-compose exec db psql -U postgres -d development

# Run the api container and bash into it
bash:
	docker-compose exec $(API_SERVICE) bash

# Run all services (api + db)
up:
	docker-compose up

# Stop all services
down:
	docker-compose down

# Logs for the API service
logs:
	docker-compose logs -f $(API_SERVICE)

# Rebuild the containers and start them
restart:
	docker-compose down
	docker-compose up --build
