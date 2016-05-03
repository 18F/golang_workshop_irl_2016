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
	scheduler.Every(120).Seconds().Run(job)
	mux := http.NewServeMux()
	mux.HandleFunc("/check", checkHandler)
	http.ListenAndServe(":8080", mux)
}
