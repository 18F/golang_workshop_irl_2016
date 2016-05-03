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
  if status, body, err := h.Ping(http.DefaultClient); err != nil {
    _ = status // Ignore these lines for now.
    _ = body // Ignore these lines for now.
    siteUp = false
  } else {
    siteUp = true
  }
}

```

## Schedule the job in main()
```go
scheduler.Every(5).Seconds().Run(job)
```

## Full Code
