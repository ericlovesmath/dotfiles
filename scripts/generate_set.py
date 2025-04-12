#!/usr/bin/python3

# Script to automatically generate template for problem sets
# Usage: ./generate_set.py <number of parts for each problem> | wl-copy

import sys

def problem(number, count=1):
    s = "% PROBLEM " + str(number) + "\n"
    s += r"\begin{problem}" + "\n"
    if count > 1: 
        s += r"    \begin{enumerate}[label=\alph*)]" + "\n"
        for _ in range(count):
            s += r"        \item i" + "\n"
        s += r"    \end{enumerate}" + "\n"
    s += r"\end{problem}"
    return s

def lineproof(label):
    s = r"\begin{lineproof}[" + str(label) + "]\n"
    s += r"\end{lineproof}"
    return s

def generate_problem(number, count=1):
    print(problem(number, count))
    print()
    if count == 1:
        print(r"\medskip")
        print(lineproof(number))
        print()
    else:
        for i in range(count):
            print(r"\medskip" if i == 0 else r"\bigskip")
            print(lineproof(str(number) + chr(97 + i)))
            print()

def generate_problems(counts):
    for i, count in enumerate(counts):
        generate_problem(i + 1, int(count))
        if i < len(counts) - 1:
            print("\n\n" + r"\bigskip")

if __name__ == "__main__":
    generate_problems(sys.argv[1:])
