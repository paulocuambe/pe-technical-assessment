package main

import (
	"testing"
)

func TestVowels(t *testing.T) {
	tests := []struct {
		input    string
		expected int
	}{
		{"hello", 2},
		{"beautiful", 4},
		{"rhythm", 0},
		{"", 0},
		{"aeiou", 5},
		{"AEIOU", 5},
		{"aeiouAEIOU", 5},
	}

	for _, test := range tests {
		actual := vowels(test.input)
		if actual != test.expected {
			t.Errorf("vowels(%q): expected %d, got %d", test.input, test.expected, actual)
		}
	}
}

func TestConsonants(t *testing.T) {
	tests := []struct {
		input    string
		expected int
	}{
		{"hello", 2},
		{"beautiful", 4},
		{"rhythm", 5},
		{"", 0},
		{"bcdfghjklmnpqrstvwxyz", 21},
		{"BCDFGHJKLMNPQRSTVWXYZ", 21},
	}

	for _, test := range tests {
		actual := consonants(test.input)
		if actual != test.expected {
			t.Errorf("consonants(%q): expected %d, got %d", test.input, test.expected, actual)
		}
	}
}

func TestWords(t *testing.T) {
	tests := []struct {
		input    string
		expected int
	}{
		{"hello world", 2},
		{"this is a test", 4},
		{"one", 1},
		{"", 1},
		{"  leading and trailing spaces  ", 4},
	}

	for _, test := range tests {
		actual := words(test.input)
		if actual != test.expected {
			t.Errorf("words(%q): expected %d, got %d", test.input, test.expected, actual)
		}
	}
}

func TestCleanup(t *testing.T) {
	tests := []struct {
		input    string
		expected string
	}{
		{"Hello sir, how are you? 123", "hello sir how are you"},
		{"  Another test!  ", "another test"},
		{"!@#$%^&*()_+", ""},
		{"", ""},
		{"  Hello    World  ", "hello    world"},
	}

	for _, test := range tests {
		actual := cleanup(test.input)
		if actual != test.expected {
			t.Errorf("cleanup(%q): expected %q, got %q", test.input, test.expected, actual)
		}
	}
}
