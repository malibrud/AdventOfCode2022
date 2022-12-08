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

## [Day 02](https://adventofcode.com/2022/day/2)

Again pretty straight forward.  Instead of creating a bunch of `if-else` statements, 
I approached the problem without branching using modular arithmatic.  For part 1, the 
essential code is:

```d
int p1 = line[0] - 'A';
int p2 = line[2] - 'X';
sum += (p2 + 1) + ( (p2 - p1 + 4) % 3 ) * 3;
```
where `p1` and `p2` are the player 1 and player 2 choices. In this way, `1` beats `0`, `2` beats `1`, and `0` beats `2`.
So to determine the player 2 result, player 2 should be one greater than player 1, mod 3.  So `( p2 - p1  + 3 ) % 3` 
indicates the result as `0` for draw, `1` for win and `2` for loss.  To convert this to 3 for draw, 6 for win, and 0 for loss we just need to shift one more before the mod, thus the `+ 4`.

For part 2, it is opposite, we are given the result and need to get the player 2 choice.  Using similar logic
the following code was developed:

```d
int p1     = line[0] - 'A';
int result = line[2] - 'X';
int p2 = (p1 + result + 2) % 3;
sum += (p2 + 1) + result * 3;
```

The successul result:
```
Part1 = 13565
Part2 = 12424
```

## [Day 03](https://adventofcode.com/2022/day/3)

Really struggled to get D to do list comprehension.  For part 1, eventually implemented the `fold` function
based on the output of `byLine`.  Here is the code:

```d

string part1( string fileName, string param )
{
    auto sum = File( fileName, "r" )
        .byLine
        .fold!( (res, line) 
        {
            auto N = line.length / 2;
            auto comp1 = line[0..N];
            auto comp2 = line[N..$];
            auto c = comp1.filter!( a => comp2.canFind(a)).array[0];
            int priority = c <= 'Z' ? ( c - 'A' + 27 ) : ( c - 'a' + 1 );
            return res + priority;
        })(0);
    return to!string(sum);
}
```

For part 2, I tried to do the same and ran into all kinds of weird behavior.  Eventually settled on
more of a traditional approach after `setIntersection` didn't seem to be working.  My eventual solution
verymuch in the spirit of `c` was:

```d

string part2( string fileName, string param )
{
    auto fd = File( fileName, "r" );
    int i;
    int sum = 0;
    bool[128] common;
    while( !fd.eof() )
    {
        auto line = fd.readln()[0..$-1];

        bool[128] sack = false;
        for (int j = 0 ; j < line.length ; j++) sack[line[j]] = true;
        if (i % 3 == 0) common[] = sack[];
        for (int j = 'A' ; j <= 'z' ; j++) common[j] &= sack[j];
        if (i % 3 == 2) 
        {
            int c;
            for (c = 'A' ; c <= 'z' ; c++) if (common[c]) break;
            sum += c <= 'Z' ? ( c - 'A' + 27 ) : ( c - 'a' + 1 );
        }
        i++;
    }
    return to!string(sum);
}
```

After the experience with these two solutions, I am thinking about switching to another language.
The high level functionality, seems too brittle and the error messages are not helpful at all.

The successul result:
```
Part1 = 7967
Part2 = 2716
```

## [Day 04](https://adventofcode.com/2022/day/4)

Pretty straight forward test of overlapping ranges.  Nothing special.  Just mostly reused machinery from prior days.
No new learning with respect to D.

The successul result:
```
Part1 = 471
Part2 = 888
```

## [Day 05](https://adventofcode.com/2022/day/5)

Most of the work was involved with reading in the file and parsing the input.  Once read the implementation of
the moves was pretty straight forward.  In implementing this solution, I learned some about D's dynamic arrays
and their manipulation.  I particularly liked the concatenation `~=` operation.  It was quite handy.
I was also able to use slices to do the stack manipulation in part 2.  I was a little disappointed that
there was no actual stack data structure.  I could have used a linked list, but I figured that random
access would/might be important in part 2, and it was.

The meat of part 1 is as follows:

```d
// Do the moves
auto patt = regex( r"move (\d+) from (\d+) to (\d+)" );
while ( !file.eof )
{
    auto line = file.readln;
    auto m = line.matchFirst( patt );
    auto count = to!int( m[1] );
    auto frIdx = to!int( m[2] ) - 1;
    auto toIdx = to!int( m[3] ) - 1;
    
    for ( int i = 0 ; i < count ; i++)
    {
        auto crate = stacks[frIdx][$ - 1];
        stacks[toIdx] ~= crate;
        stacks[frIdx].length--;
    }
}
```

The meat of part 2 is as follows:

```d
// Do the moves
auto patt = regex( r"move (\d+) from (\d+) to (\d+)" );
while ( !file.eof )
{
    auto line = file.readln;
    auto m = line.matchFirst( patt );
    auto count = to!int( m[1] );
    auto frIdx = to!int( m[2] ) - 1;
    auto toIdx = to!int( m[3] ) - 1;
    
    auto crates = stacks[frIdx][$-count..$];
    stacks[toIdx] ~= crates;
    stacks[frIdx].length -= count;
}
```

The successul result:
```
Part1 = CNSZFDVLJ
Part2 = QNDWLMGNS
```