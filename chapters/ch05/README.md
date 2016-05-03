# Chapter 05 - Scheduling a ping to a link

## Goal

Create a web server that returns true or false to indicate if a service is up.

## Starting Code in `ch05.go`

```go
package main

import (
	"fmt"
	"net/http"
)

var (
	siteUp bool
)

func checkHandler(w http.ResponseWriter, req *http.Request) {
	fmt.Fprint(w, siteUp)
}

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/check", checkHandler)
	http.ListenAndServe(":8080", mux)
}
```

Currently this code will just return false whenever we go to [http://localhost:8080/check](http://localhost:8080/check).

The idea is schedule periodic checks to ping a site and change that flag.

## Import Dependencies

Let's import a 1) scheduler and a 2) pinger!!

Run:
```
go get github.com/carlescere/scheduler
go get github.com/augurysys/pinger
```

```go
import (
  // Other imports
  "github.com/carlescere/scheduler"
  "github.com/tobio/pinger"
)

```

**Note: A great way to find libraries is to go to [https://godoc.org/](https://godoc.org/) and search for a term.**


## Create the job in main().
```go
job := func() {
	// Create the host description
	h := pinger.Host{
		Name:               "Google",
		Url:                "https://www.google.com",
		ExpectedStatusCode: 200,
	}

	// Ignore these declarations, will be used for inspecting in the debug chapter
	var bodyStr string
	var body []byte
	var status int
	var err error

	if status, body, err = h.Ping(http.DefaultClient); err != nil {
		siteUp = false
		bodyStr = string(body) // Ignore this line for now.
	} else {
		siteUp = true
		bodyStr = string(body) // Ignore this lines for now.
	}
	_ = bodyStr // Ignore this line for now.
	_ = status  // Ignore this line for now.
}

```

## Schedule the job in main()
```go
scheduler.Every(5).Seconds().Run(job)
```

## Full Code

```go
package main

import (
	"fmt"
	"net/http"

	"github.com/augurysys/pinger"
	"github.com/carlescere/scheduler"
)

var (
	siteUp bool
)

func checkHandler(w http.ResponseWriter, req *http.Request) {
	fmt.Fprint(w, siteUp)
}

func main() {
	job := func() {
		// Create the host description
		h := pinger.Host{
			Name:               "Google",
			Url:                "https://www.google.com",
			ExpectedStatusCode: 200,
		}

		// Ignore these declarations, will be used for inspecting in the debug chapter
		var bodyStr string
		var body []byte
		var status int
		var err error

		if status, body, err = h.Ping(http.DefaultClient); err != nil {
			siteUp = false
			bodyStr = string(body) // Ignore this line for now.
		} else {
			siteUp = true
			bodyStr = string(body) // Ignore this lines for now.
		}
		_ = bodyStr // Ignore this line for now.
		_ = status  // Ignore this line for now.
	}

	// Schedule job
	scheduler.Every(5).Seconds().Run(job)

	mux := http.NewServeMux()
	mux.HandleFunc("/check", checkHandler)
	http.ListenAndServe(":8080", mux)
}

```
