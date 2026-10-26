package main

import (
	"net/http"
	"log"
	"todo-app/internal/api"
)

func main() {
	log.Println("listening on :8080")
	handler := api.Routes()

	err := http.ListenAndServe(":8080", handler)
	if err != nil {
		log.Fatal(err)
	}
}
