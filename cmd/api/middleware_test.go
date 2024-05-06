package main

import (
	"groovy/internal/data"
	"groovy/internal/jsonlog"
	"groovy/internal/mailer"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestRateLimit(t *testing.T) {

	// Create an instance of the application struct with mocked dependencies.
	app := &application{
		config: config{},
		log:    &jsonlog.Logger{},
		models: data.NewModels(nil),
		mailer: mailer.New("", 8000, "", "", ""),
	}

	// Define the number of requests to simulate and the expected status code.
	numRequests := 10 // Adjust this to match your rate limit configuration.
	expectedStatusCode := http.StatusTooManyRequests

	// Create a new http.Request instance.
	req, err := http.NewRequest(http.MethodGet, "/v1/healthcheck", nil)
	if err != nil {
		t.Fatal(err)
	}

	// Create a ResponseRecorder to record the response from each request.
	rr := httptest.NewRecorder()

	// Create a handler that uses the rateLimit middleware.
	handler := app.rateLimit(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {}))

	// Send the specified number of requests to the handler.
	for i := 0; i < numRequests; i++ {
		handler.ServeHTTP(rr, req)
	}

	// Check that the last response has the expected status code.
	if status := rr.Code; status != expectedStatusCode {
		t.Errorf("handler returned wrong status code: got %v want %v", status, expectedStatusCode)
	}
}
