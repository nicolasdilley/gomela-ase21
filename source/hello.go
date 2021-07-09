package main

import "sync"

func main() {
	var mu *sync.Mutex

	ch := make(chan int)
	mu.Lock()

	defer func() {
		mu.Unlock()
	}()

	if true {
		return
	}
	ch <- 5
	go func() {
		mu.Lock()

		mu.Unlock()
	}()

	<-ch
	defer func() {
		mu.Unlock()
	}()

	return

}
