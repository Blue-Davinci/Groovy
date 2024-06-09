package data

import "testing"

func TestFunction(t *testing.T) {
	got := validateUrl("https:")
	want := true

	if got != want {
		t.Errorf("Got:%v But Wanted:%v", got, want)
	}
}
