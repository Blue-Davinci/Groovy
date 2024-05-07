# Start from the latest golang base image
FROM golang:latest

# Add Maintainer Info
LABEL maintainer="Your Name <youremail@example.com>"

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app using the Makefile
RUN make build/api

# This assumes that the output of the Makefile is an executable named "api.exe" in the "bin" directory
CMD ["./bin/api.exe"]

# Expose port 8080 to the outside world
EXPOSE 4000