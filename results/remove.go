package main

import (
	"io/ioutil"
	"strings"
)

func main() {

	content, _ := ioutil.ReadFile("log.csv")

	splitted_lines := strings.Split(string(content), "\n")

	newcontent := ""
	for _, line := range splitted_lines {
		if !strings.Contains(line, "MODEL ERROR") {
			newcontent += line + "\n"
		}
	}

	ioutil.WriteFile("new_log", []byte(newcontent), 0664)
}
