package main

import (
	"fmt"
	"log"
	"net/http"
	"regexp"
	"strings"
)

const (
	ALPHABET_CONSONANTS = "bcdfghjklmnpqrstvwxyz"
	ALPHABET_VOWELS     = "aeiou"
)

func vowels(s string) int {
	r := regexp.MustCompile(fmt.Sprintf("[%s]", ALPHABET_VOWELS))
	rvw := r.FindAll([]byte(s), -1)

	vw := make(map[string]int, len(rvw))
	for i := 0; i < len(rvw); i++ {
		vw[fmt.Sprintf("%s", rvw[i])] += 1
	}

	return len(vw)
}

func consonants(s string) int {
	r := regexp.MustCompile(fmt.Sprintf("[%s]", ALPHABET_CONSONANTS))
	rcs := r.FindAll([]byte(strings.ToLower(s)), -1)

	cs := make(map[string]int, len(rcs))
	for i := 0; i < len(rcs); i++ {
		cs[fmt.Sprintf("%s", rcs[i])] += 1
	}

	return len(cs)
}

func words(s string) int {
	return len(strings.Split(s, " "))
}

func cleanup(s string) string {
	r := regexp.MustCompile("[[:punct:]]")
	s = r.ReplaceAllString(s, "")

	r = regexp.MustCompile("[[:digit:]]")
	s = r.ReplaceAllString(s, "")

	return strings.ToLower(strings.TrimSpace(s))
}

func api(w http.ResponseWriter, r *http.Request) {
	phrase := r.URL.Query().Get("phrase")

	if phrase == "" {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("hello world"))
		return
	}

	phrase = cleanup(phrase)
	ws, v, c := words(phrase), vowels(phrase), consonants(phrase)

	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write([]byte(fmt.Sprintf("{\"words\": %d, \"vowels\": %d, \"consonants\": %d}\n", ws, v, c)))
}

func main() {
	phrase := "Hello sir, how are you?"
	phrase = strings.TrimSpace(strings.ToLower(phrase))

	http.HandleFunc("GET /api/v1/words", api)
	log.Println("starting the api")
	http.ListenAndServe("localhost:8080", nil)
}
