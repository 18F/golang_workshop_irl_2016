# Chapter 07 - Intro to Go Testing

---
#### [Previous Chapter](../ch06/README.md) | [Table of Contents](../README.md)
---

## Goal

We will create tests for the simple web app created in [Chapter 03](../ch03/README.md). The code developed in chapter 03 has been copied into this chapter and is in [ch07.go](ch07.go). All the test code will go in [ch07_test.go](ch07_test.go).

## Go testing conventions

- All files that end with `_test.go` are recognized by the Go toolchain as test files.
- All testing functions start with `Test`.

## Import the `testing` dependency

The standard library comes with a testing library.

```go
package main

import (
  "testing"
)
```

## Sample test

```go
func TestXYZ(t *testing.T) {
  // do testing and compare
}
```

You use the testing.T struct as your test runner.

## Testing our `sayHello` function.

`sayHello` just returns a string so let's just make sure it returns what we want.

```go
func TestSayHello(t *testing.T) {
  if sayHello() != "Hello World" {
    t.Error("SayHello() did not return \"Hello World\"")
  }
}
```

## Testing our web server / `hiHandler`

### Setting up a test web server.

In order to test our web server, we need to create a test server. The standard library has test helpers for the web server in `"net/http/httptest"`.

```go
import (
  // other imports
  "net/http/httptest"
)
```

### Using the test web server.

```go
func TestHiHandler(t *testing.T) {
  // Where the test code will go for this.
}
```

#### Create the test server.

```go
// Setup the mux
mux := http.NewServeMux()
mux.HandleFunc("/hi", hiHandler)
```

#### Add a sample request and response recorder

```go
// Create a sample request
req, _ := http.NewRequest("GET", "/hi", nil)

// Create a response recorder
w := httptest.NewRecorder()
```

#### Serve the request to the test server and test the output and status codes.

```go

// Send the request to the server
mux.ServeHTTP(w, req)

// Test out the status.
if w.Code != http.StatusOK {
	t.Errorf("Hi page didn't return %v", http.StatusOK)
}
// Test out the text.
if string(w.Body.Bytes()) != "Hello World" {
	t.Error("SayHello() did not return \"Hello World\"")
}
```

## Execution

`go test`

Should see
```
PASS
```

## Full Code

```go
package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestSayHello(t *testing.T) {
	if sayHello() != "Hello World" {
		t.Error("SayHello() did not return \"Hello World\"")
	}
}

func TestHiHandler(t *testing.T) {
	// Setup the mux
	mux := http.NewServeMux()
	mux.HandleFunc("/hi", hiHandler)

	// Create a sample request
	req, _ := http.NewRequest("GET", "/hi", nil)

	// Create a response recorder
	w := httptest.NewRecorder()

	// Send the request to the server
	mux.ServeHTTP(w, req)

	// Test out the status.
	if w.Code != http.StatusOK {
		t.Errorf("Hi page didn't return %v", http.StatusOK)
	}
	// Test out the text.
	if string(w.Body.Bytes()) != "Hello World" {
		t.Error("SayHello() did not return \"Hello World\"")
	}
}
```

---
#### [Previous Chapter](../ch06/README.md) | [Table of Contents](../README.md)
---
