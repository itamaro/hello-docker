// -*- coding: utf-8 -*-
// Copyright 2017 Itamar Ostricher

#include <cstdlib>

#include <iostream>
#include <limits>

typedef std::numeric_limits<double> dbl;

using std::cout;

// CalcPi computes a numerical Pi approximation
// by running N iterations of the Leibniz formula
// ref: https://en.wikipedia.org/wiki/Leibniz_formula_for_%CF%80
double CalcPi(int N) {
  double sign = 1, quarter_pi = 0;
  for (int n=0; n < N; ++n) {
    quarter_pi += sign / (2 * n + 1);
    sign *= -1;
  }
  return 4 * quarter_pi;
}

int main(int argc, char *argv[]) {
  int N = 1000000;
  if (argc > 1) {
    N = atoi(argv[1]);
  }
  cout.precision(dbl::max_digits10);
  cout << CalcPi(N) << std::endl;
  return 0;
}
