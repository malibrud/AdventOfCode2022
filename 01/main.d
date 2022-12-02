module main;

import std.stdio;
import std.conv;
import std.array;
import std.algorithm;

void main()
{
    writeln( "Part1 = ", part1( "data.txt", "" ) );
    writeln( "Part2 = ", part2( "data.txt", "" ) );
}

unittest
{
    assert( part1( "test1.txt", "" ) == "24000" );
    assert( part2( "test1.txt", "" ) == "45000" );
}

string part1( string fileName, string param )
{
    auto lines = File( fileName, "r" ).byLine();
    int sum = 0;
    int max = 0;
    foreach (line; lines)
    {
        if (line.length == 0)
        {
            max = sum > max ? sum : max;
            sum = 0;
            continue;
        }
        sum += to!int( line );
    }
    max = sum > max ? sum : max;
    return to!string(max);
}

string part2( string fileName, string param )
{
    auto lines = File( fileName, "r" ).byLine();
    int sum = 0;
    int[] sums;
    foreach (line; lines)
    {
        if (line.length == 0)
        {
            sums ~= sum;
            sum = 0;
            continue;
        }
        sum += to!int( line );
    }
    sums ~= sum;
    auto ans = sums.sort!( "a > b")[0..3].sum();
    return to!string(ans);
}