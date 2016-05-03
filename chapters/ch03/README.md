# Chapter 03 - Hello To The Web World


## Goal

Create a simple web server that responds "Hello World"


## Let's Start

We will use the code from chapter 02 to start with.

### Package Name
There's a special package name that indicates this is the entry point to a runnable program vs a library. It's called `main`. Let's use that.

### Imports
Out of the box, Go has a rich set of libraries. For a web server, just import the `"net/http"` package.
Similarly to chapter 02, we will need to write text out, so we will need `"fmt"`.

### Code

#### Functions
##### sayHello()
Let's re-use the `sayHello()` from chapter 02.

```go
func sayHello() string {
	return "Hello World"
}
```

#### Mux
We need a multiplexer to route the various calls.

```go
mux := http.NewServeMux()
```

#### Route Handler
We want the server to respond "Hello World" when a user hits the index route "/hi".
If you look up the docs for "net/http", you would see there's a `func (mux *ServeMux) HandleFunc(pattern string, handler func(ResponseWriter, *Request))` function to hook into our `mux`. We can make the `pattern` equal to `"/"`. However, `sayHello() string` does not meet the function type needed for the second parameter. We need to write a second function that meets that prototype.

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
	mux.HandleFunc("/", hiHandler)
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
