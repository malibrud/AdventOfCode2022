# Overview

For the 2022 [Advent of Code](https://adventofcode.com/), I chose to use the [D Language](https://dlang.org/)
developed by [Walter Bright](https://en.wikipedia.org/wiki/Walter_Bright) and others.  I have followed the
development of D since 2003 and have desired to use it for something significant.  Using it for Advent of Code
will help expose me to the power of the language both as a replacement for C/C++ at the low level and
utilizing some of its higher level functions.  

## [Day 01](https://adventofcode.com/2022/day/1)

Pretty straightforward puzzle.  Part 2 used some of D's chaining of functions to calculate the final sum.
I thought it was pretty powerful to do this

```d
auto ans = sums.sort!( "a > b")[0..3].sum();
```

Skills learned:
* Setup VSCode to interoperate with D in the debugger
* Setup and configuration of `dub` and `dub.json`.
* Use of D's `unittest` feature
* Use of D's dynamic arrays and sorting.
* Using D to read an ASCII file line by line.

The successul result:
```
Part1 = 69501
Part2 = 202346
```