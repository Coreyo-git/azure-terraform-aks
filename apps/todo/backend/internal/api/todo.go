package api

import (
	"net/http"
	"fmt"
)

func handleTodo(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World Todo Path: %s", r.URL.Path)
}
