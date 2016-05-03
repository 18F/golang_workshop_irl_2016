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
