<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="https://i.ibb.co/0DTCJps/favicon.png" alt="Project logo"></a>
</p>

<h3 align="center">Groovy API</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/Blue-Davinci/groovy.svg)](https://github.com/Blue-Davinci/groovy/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/kylelobo/The-Documentation-Compendium.svg)](https://github.com/Blue-Davinci/groovy/pulls)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

<p align="center"> A GOLANG BACK END CODE FOR THE GROOVY API.
    <br> 
</p>

## 📝 Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Deployment](#deployment)
- [Usage](#usage)
- [Built Using](#built_using)
- [API Endpoints](#endpoints)
- [TODO](./TODO.md)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

## 🧐 About <a name = "about"></a>

- Groovy is a full fledged API written in Golang. It's aimed as a project to show the creation of a robust back-end equipped
  with a myriad of features including authentication, authorization, permisions, CORS and email capabilities.
- The database at the heart of the application is POSTGRESQL and involves CRUD features for the entry, updating,
  deleting and reading of stored movie information which includes pagination, advanced searches and filtering.
- Introducing the sister project for this, the [Groovy-Fronted](https://github.com/Blue-Davinci/Groovy-Frontend), fully powered by Svelte.

## 🏁 Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See [deployment](#deployment) for notes on how to deploy the project on a live system.

### Prerequisites

Before you can run or contribute to this project, you'll need to have the following software installed:

- [Go](https://golang.org/dl/): The project is written in Go, so you'll need to have Go installed to run or modify the code.
- [PostgreSQL](https://www.postgresql.org/download/): The project uses a PostgreSQL database, so you'll need to have PostgreSQL installed and know how to create a database.
- A Go IDE or text editor: While not strictly necessary, a Go IDE or a text editor with Go support can make it easier to work with the code. I use vscode.
- [Git](https://git-scm.com/downloads): You'll need Git to clone the repo.

### Installing

1. **Clone the repository:** Start by cloning the repository to your local machine. Open a terminal, navigate to the directory where you want to clone the repository, and run the following command:

    ```bash
    git clone https://github.com/blue-davinci/groovy.git
    ```

2. **Navigate to the project directory:** Use the `cd` command to navigate to the project directory:

    ```bash
    cd groovy
    ```

3. **Install the Go dependencies:** The Go tools will automatically download and install the dependencies listed in the `go.mod` file when you build or run the project. To download the dependencies without building or running the project, you can use the `go mod download` command:

    ```bash
    go mod download
    ```

4. **Set up the database:** The project uses a PostgreSQL database. You'll need to create a new database and update the connection string in your configuration file or environment variables. The exact steps to do this depend on your PostgreSQL setup and can also be done via Migration files included in this repo via:
```
migrate -path=migrations -database=postgres://your_username:your_password@localhost/groovy?sslmode=disable up
```

5. **Build the project:** You can build the project using the `go build` command:

    ```bash
    go build
    ```
    This will create an executable file in the current directory.

6. **Run the project:** You can run the project using the `go run` after navigating to `cmd\api\` directory:

    ```bash
    go run .
    ```

7. **Run the project:** Instead of using `go run`, you can use the `make` command with the `run/api` target to run the project:

    ```bash
    make run/api
    ```
8. For additional supported commands run `make help`:

  ```bash
  make help
  ```

### Description

The application accepts command-line flags for configuration, establishes a connection pool to a database, and publishes variables for monitoring the application. The published variables include the application version, the number of active goroutines, database connection pool statistics, and the current Unix timestamp.
    This will start the application. You should be able to access it at `http://localhost:4000`.

## Optional Parameters <a name = "optpars"></a>

You can view the **parameters** by utilizing the `-help` command. Here is a rundown of 
the available commands for a quick lookup.
- **smtp-sender:** Sets the sender for SMTP (email) communications. Default: "Groovy <no-reply@groovy.com>".
- **cors-trusted-origins:** Sets the trusted origins for Cross-Origin Resource Sharing (CORS). Provide a space-separated list of origins.
- **cors-trusted-origins [value]:** Trusted CORS origins (space separated)
- **db-dsn [string]:** PostgreSQL DSN (default "{Path to your .env holding your DSN}")
- **db-max-idle-conns [int]:** PostgreSQL max idle connections (default 25)
- **db-max-idle-time [string]:** PostgreSQL max connection idle time (default "15m")
- **db-max-open-conns [int]:** PostgreSQL max open connections (default 25)
- **env [string]:** Environment (development|staging|production) (default "development")
- **limiter-burst [int]:** Rate limiter maximum burst (default 4)
- **limiter-enabled [bool]:** Enable rate limiter (default true)
- **limiter-rps [float]:** Rate limiter maximum requests per second (default 2)
- **port [int]:** API server port (default 4000)
- **smtp-host [string]:** SMTP host (default "sandbox.smtp.mailtrap.io"- I use mailtrap for tests)
- **smtp-password [string]:** SMTP password (default "xxxxx")
- **smtp-port [int]:** SMTP port (default 25)
- **smtp-sender [string]:** SMTP sender (default "Groovy <no-reply@groovy.com>")
- **smtp-username [string]:** SMTP username (default "skunkhunt42")

Using `make run`, will run the API with a default connection string: `-db-dsn=${GROOVY_DB_DSN}` located 
in `cmd\api\.env`. If you're using powershell, you need to load the values otherwise you will get
a `cannot load env file` error. Use the PS code below to load it or change the env variable:
```powershell
$env:GROOVY_DB_DSN=(Get-Content -Path .\cmd\api\.env | Where-Object { $_ -match "GROOVY_DB_DSN" } | ForEach-Object { $($_.Split("=", 2)[1]) })
```
Alternatively, in unix systems you can make a .envrc file and load it directly in the makefile by importing like so:
```makefile
include .envrc
```
A succesful run will output:
```
{"level":"INFO","time":"0000-00-00T16:50:52Z","message":"database connection pool established"}
{"level":"INFO","time":"0000-00-00T16:50:52Z","message":"starting server","properties":{"addr":":4000","env":"development"}}
{"level":"INFO","time":"0000-00-00T16:51:01Z","message":"shutting down server","properties":{"signal":"interrupt"}}
{"level":"INFO","time":"0000-00-00T16:51:01Z","message":"completing background tasks","properties":{"addr":":4000"}}
{"level":"INFO","time":"0000-00-00T16:51:01Z","message":"stopped server","properties":{"addr":":4000"}}
```

### API Endpoints <a name = "endpoints"></a>
Below are all the end points for the API and a high level description of what they do.
- **GET /v1/healthcheck:** Checks the health of the application. Returns a 200 OK status code if the application is running correctly.

- **GET /v1/movies:** Lists all movies. Requires "movies:read" permission.

- **POST /v1/movies:** Creates a new movie. Requires "movies:write" permission.

- **GET /v1/movies/:id:** Shows details of a specific movie. Requires "movies:read" permission.

- **PATCH /v1/movies/:id:** Updates a specific movie. Requires "movies:write" permission.

- **DELETE /v1/movies/:id:** Deletes a specific movie. Requires "movies:write" permission.

- **POST /v1/users:** Registers a new user.

- **PUT /v1/users/activated:** Activates a user.

- **POST /v1/tokens/authentication:** Creates an authentication token.

- **GET /debug/vars:** Provides debug variables from the `expvar` package.


## 🔧 Running the tests <a name = "tests"></a>

The rate limiter test

### Break down into limit tests
Essentially checks whether rate limiting works, You need to run/start the API with
the `limiter-burst` set to whatever you want and then can configure the number
of requests to check how many responses return with 200 vs 429 (too manu requests)

Sample output:
```
=== RUN   TestRateLimit
    groovy\cmd\api\middleware_test.go:45: handler returned wrong status code: got 200 want 429
--- FAIL: TestRateLimit (0.00s)
FAIL
FAIL    groovy/cmd/api  0.398s
```

## 🎈 Usage <a name="usage"></a>

Simply run using the app/main.go using any number of flags you desire like below:
```
make build/api
./bin/api.exe -smtp-username=pigbearman -smtp-password=algor

Direct Run: 
go run main.go
```

## 🚀 Deployment <a name = "deployment"></a>

This application can be deployed using Docker and Docker Compose. Here are the steps to do so:

1. **Build the Docker image**: Run `docker build -t groovy .` while in the root directory .

2. **Run the Docker Compose services**: Run `docker-compose up` while in the root dir.

If you want to run the services in the background, you can use the `-d` option: `docker-compose up -d`.
Please remember you can use flags, mentioned [here](#optpars) while running the api by setting them in
the `Dockerfile` like so:
```
CMD ["./bin/api.exe", "-smtp-username", "smtp username", "-port", "your_port", "-smtp-password", "your_smtp_pass"]
```

Remember to replace `groovy` with the name you want to give to your Docker image. If you're pushing to Docker Hub, the image name should be in the format `username/repository:tag`, where `username` is your Docker Hub username, `repository` is the name you want to give to your Docker repository, and `tag` is the tag you want to give to this version of the image. If you don't specify a tag, Docker will use `latest` by default.

Please note that you need to have Docker and Docker Compose installed on your machine to deploy the application this way. You can download Docker [here](https://www.docker.com/products/docker-desktop) and find installation instructions for Docker Compose [here](https://docs.docker.com/compose/install/).

## ⛏️ Built Using <a name = "built_using"></a>

- [PostgreSQL](https://www.postgresql.org/) - Database
- [Go](https://golang.org/) - Backend
- [HTML](https://developer.mozilla.org/en-US/docs/Web/HTML) - Email Template
- [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript) - Frontend behavior

## ✍️ Authors <a name = "authors"></a>

- [@blue-davinci](https://github.com/blue-davinci) - The Groovy API


## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- Hat tip to anyone whose framework was used
- Inspiration: This project was inspired by the desire to create a robust and scalable API using Go. The goal was to leverage Go's efficiency and performance, along with PostgreSQL's reliability and feature set, to build an application that can handle high loads and complex operations. The frontend examples were built with HTML, Bootstrap and jQuery, as a start in providing a user-friendly interface to interact with the API.

## 📚 References <a name = "references"></a>

- [Go Documentation](https://golang.org/doc/): Official Go documentation and tutorials.
- [PostgreSQL Documentation](https://www.postgresql.org/docs/): Official PostgreSQL documentation.
- [Go database/sql tutorial](http://go-database-sql.org/): Tutorial on using Go's database/sql package.
