# ==================================================================================== #
# HELPERS																			   #
# ==================================================================================== #

## help: print this help message
.PHONY: help
help:
	@echo Usage: 
	@echo run/api            -  print this help message
	@echo run/api            -  run the api
	@echo db/psql            -  connect to the db using psql
	@echo db/migrations/new  -  create a new migration with the name passed as an argument
	@echo db/migrations/up   -  run the up migrations using confirm as prerequisite

## confirm: create the new confirm prompt from confirm.ps1.
## if on linux you can use https://stackoverflow.com/questions/47837071/making-make-clean-ask-for-confirmation
.PHONY: confirm
confirm:
	powershell -File confirm.ps1

# ==================================================================================== #
# DEVELOPMENT																		   #
# ==================================================================================== #

# run/api: run the api with the default DSN pruned from .env file,
# you can import the file directly or use ps script to load it before running
.PHONY: run/api
run/api:
	@go run ./cmd/api -db-dsn=${GROOVY_DB_DSN} 

# db/psql: connect to the db using psql
.PHONY: db/psql
db/psql:
	psql ${GROOVY_DB_DSN}

# db/migrations/new: create a new migration with the name passed as an argument
.PHONY: db/migrations/new
db/migrations/new:
	@echo Creating migration files for ${name}...
	migrate create -seq -ext .sql -dir=./migrations ${name}

# db/migrations/up: run the up migrations using confirm from confirm.p1 as prereq
.PHONY: db/migrations/up
db/migrations/up: confirm
	@echo Running up migrations...
	migrate -path=migrations -database=${GROOVY_DB_DSN} up

# ==================================================================================== #
# QUALITY Q/A																		   #
# ==================================================================================== #

## audit: tidy dependencies and format, vet and test all code
.PHONY: audit
audit:
	@echo 'Tidying and verifying module dependencies...'
	go mod tidy
	go mod verify
	@echo 'Formatting code...'
	go fmt ./...
	@echo 'Vetting code...'
	go vet ./...
	staticcheck ./...
	@echo 'Running tests...'
	go test -race -vet=off ./...
