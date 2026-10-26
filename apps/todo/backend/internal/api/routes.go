package api

import (
	"net/http"
)

func Routes() http.Handler {
	mux := http.NewServeMux() 

	//	mux.HandleFunc("GET /api/todo", handleTodo)
	mux.HandleFunc("GET /api/health", handleHealth)
	
	return mux
}

