# Chapter 03 - Hello To The Web World

---
#### [Previous Chapter](../ch02/README.md) | [Table of Contents](../README.md) | [Next Chapter](../ch04/README.md)
---

## Goal

Create a simple web server that responds "Hello World"


## Let's Start

We will modify the code we developed in [Chapter 02](../ch02/README.md) to expand it to handle web servers. There is code in [ch03.go](ch03.go) as a starting point.

### Imports
Out of the box, Go has a rich set of libraries. For a web server, just import the `"net/http"` package.
Similarly to [Chapter 02](../ch02/README.md), we will need to write text out, so we will need `"fmt"`.

### Code

#### Functions
##### sayHello()
Let's re-use the `sayHello()` from [Chapter 02](../ch02/README.md).

```go
func sayHello() string {
	return "Hello World"
}
```

#### Mux
We need a multiplexer to route the various calls. Put this in the top of the `main` function before all other calls.

```go
mux := http.NewServeMux()
```

#### Route Handler
We want the server to respond "Hello World" when a user hits the index route "/hi".
If you look up the docs for "net/http", you would see there's a function to hook into our `mux`:

```go
func (mux *ServeMux) HandleFunc(pattern string, handler func(ResponseWriter, *Request))
```
We can make the `pattern` equal to `"/hi"`. However, `sayHello() string` does not meet the function type needed for the second parameter. We need to write a second function that meets that prototype.

```go
func hiHandler(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintln(w, sayHello())
}
```

`http.ResponseWriter` is a writer that will write to a given http response. We use `Fprintln` to use that writer and write our "Hello World" to it, which is the response.

#### main()
Let's have main setup the server.

```go
func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/hi", hiHandler)
	http.ListenAndServe(":8080", mux)
}
```

### Execution

`$ go run ch03.go`

### Full Code
```go
package main

import (
	"fmt"
	"net/http"
)

func sayHello() string {
	return "Hello World"
}

func hiHandler(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintln(w, sayHello())
}

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/hi", hiHandler)
	http.ListenAndServe(":8080", mux)
}
```

---
#### [Previous Chapter](../ch02/README.md) | [Table of Contents](../README.md) | [Next Chapter](../ch04/README.md)
---
