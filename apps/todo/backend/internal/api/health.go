package api

import (
	"net/http"
	"fmt"
)


func handleHealth(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHealder(http.StatusOk)
	fmt.Fprintf(w, "Hello World Health Path: %s", r.URL.Path)
}
