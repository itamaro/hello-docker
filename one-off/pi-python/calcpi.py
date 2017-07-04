#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Copyright 2017 Itamar Ostricher

"""Numericla Pi approximation"""


def calc_pi(N):
  """Return a numerical Pi approximation by running N iterations of the Leibniz formula

  ref: https://en.wikipedia.org/wiki/Leibniz_formula_for_%CF%80
  """
  quarter_pi = 0
  sign = 1.0
  for n in range(N):
    quarter_pi += sign / (2.0 * n + 1.0)
    sign *= -1.0
  return 4.0 * quarter_pi


if __name__ == '__main__':
  import sys
  print(calc_pi(int(sys.argv[1]) if len(sys.argv) > 1 else 1000000))
