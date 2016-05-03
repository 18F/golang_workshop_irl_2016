# Chapter 04 - Importing Dependencies

## Goal

Create a simple web server that responds "Hello World" that also prints out stats generated from an imported external dependency.


## Let's Start

We will use the code from chapter 03 to start with already located in ch04.go

## Let's get `stats` on our server

[https://github.com/thoas/stats](https://github.com/thoas/stats) is a Go library that hooks into the `net/http` handlers to provide stats on the application.

In order to retrieve it, run `go get github.com/thoas/stats` from your terminal.

You can check if it was downloaded by running `tree $GOPATH -L 4`. You should see something like:

```
<Your GOPATH>
├── bin
│   └── # A bunch of stuff
├── pkg
│   └── darwin_amd64
│       └── # A bunch of stuff
└── src
    └──github.com
        └── thoas
            └── stats # TADA!!!
```

## Import the library.

```go
import (
  // other imports
  "github.com/thoas/stats"
)
```

## Declare a global variable for the middleware outside of the functions

```go
var (
	statsMiddleware *stats.Stats
)
```

## Create the middleware and wrap the mux
```go
func main() {
  statsMiddleware = stats.New()
  // other lines.
  http.ListenAndServe(":8080", statsMiddleware.Handler(mux))
}
```

## Create a new handle function to print out the stats as shown in [this example](https://github.com/thoas/stats/blob/master/examples/negroni/server.go#L24).
```go
func statsHandler(w http.ResponseWriter, req *http.Request) {
	stats := statsMiddleware.Data()
	b, _ := json.Marshal(stats)
	fmt.Fprint(w, string(b))
}
```

**Make sure you import the `"encoding/json"` package.***

## Execution

`$ go run ch04.go`

## Full Code

```go
package main

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/thoas/stats"
)

var (
	statsMiddleware *stats.Stats
)

func sayHello() string {
	return "Hello World"
}

func statsHandler(w http.ResponseWriter, req *http.Request) {
	stats := statsMiddleware.Data()
	b, _ := json.Marshal(stats)
	fmt.Fprint(w, string(b))
}

func hiHandler(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintln(w, sayHello())
}

func main() {
	statsMiddleware = stats.New()
	mux := http.NewServeMux()
	mux.HandleFunc("/hi", hiHandler)
	mux.HandleFunc("/stats", statsHandler)
	http.ListenAndServe(":8080", statsMiddleware.Handler(mux))
}
```
