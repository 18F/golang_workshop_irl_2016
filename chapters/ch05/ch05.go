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
