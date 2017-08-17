// -*- coding: utf-8 -*-
// Copyright 2017 Itamar Ostricher

package main

import (
	"flag"
	"log"
	"net/http"
)

func main() {
	port := flag.String("port", "8900", "Server port to listen on")
	flag.Parse()
	log.Println("starting server, listening on port " + *port)
	http.HandleFunc("/", EchoHandler)
	http.ListenAndServe(":" + *port, nil)
}

// EchoHandler echoes back HTTP requests to the sender
func EchoHandler(w http.ResponseWriter, request *http.Request) {
	log.Printf("Echoing back request made to %s to client (%s)", request.URL.Path, request.RemoteAddr)
	request.Write(w)
}
