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
		if _, _, err := h.Ping(http.DefaultClient); err != nil {
			siteUp = false
		} else {
			siteUp = true
		}
	}
	scheduler.Every(5).Seconds().Run(job)
	mux := http.NewServeMux()
	mux.HandleFunc("/check", checkHandler)
	http.ListenAndServe(":8080", mux)
}
