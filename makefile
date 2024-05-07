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
	@echo vendor             -  tidy and vendor dependencies
	@echo build/api          -  build the cmd/api application

## confirm: create the new confirm target.
.PHONY: confirm
confirm:
	powershell -File confirm.ps1

# ==================================================================================== #
# DEVELOPMENT																		   #
# ==================================================================================== #

# run/api: run the api
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

# db/migrations/up: run the up migrations using confirm as prerequisite
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
	@echo 'Formatting code...'
	go fmt ./...
	@echo 'Vetting code...'
	go vet ./...
	staticcheck ./...
	@echo 'Running tests...'
	go test -race -vet=off ./...

## vendor: tidy and vendor dependencies
.PHONY: vendor
vendor:
	@echo 'Tidying and verifying module dependencies...'
	go mod tidy
	go mod verify
	@echo 'Vendoring dependencies...'
	go mod vendor

# ==================================================================================== #
# BUILD
# ==================================================================================== #

## build/api: build the cmd/api application
.PHONY: build/api
build/api:
	@echo 'Building cmd/api...'
	go build -ldflags '-s' -o ./bin/api.exe ./cmd/api
## For linux: GOOS=linux GOARCH=amd64 go build -ldflags='-s' -o bin/linux_amd64_api ./cmd/api
