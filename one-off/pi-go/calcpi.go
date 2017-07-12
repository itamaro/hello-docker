// -*- coding: utf-8 -*-
// Copyright 2017 Itamar Ostricher

package main

import (
	"flag"
	"fmt"
)

func main() {
	N := flag.Int("iterations", 1000000, "Number of Leibniz formula iterations")
	flag.Parse()
	fmt.Println(CalcPi(*N))
}

func CalcPi(N int) (pi float64) {
	for sign, n := 1.0, 0; n < N; n++ {
		pi += sign / (2.0 * float64(n) + 1.0)
		sign *= -1.0
	}
	pi *= 4.0
	return
}
