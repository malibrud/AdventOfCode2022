module main;

import std.stdio;
import std.conv;
import std.array;
import std.algorithm: fold, filter, canFind, sort, setIntersection;
import std.regex;

void main()
{
    writeln( "Part1 = ", part1( "data.txt", "" ) );
    writeln( "Part2 = ", part2( "data.txt", "" ) );
}

unittest
{
    assert( part1( "test1.txt", "" ) == "2" );
    assert( part2( "test1.txt", "" ) == "4" );
}

string part1( string fileName, string param )
{
    auto patt = regex(r"(\d+)-(\d+),(\d+)-(\d+)");
    auto sum = File( fileName, "r" )
        .byLine
        .fold!( (res, line) 
        {
            auto m = matchFirst(line, patt);
            auto p1min = to!int( m[1] );
            auto p1max = to!int( m[2] );
            auto p2min = to!int( m[3] );
            auto p2max = to!int( m[4] );
            if (p1min <= p2min && p1max >= p2max) return res + 1;
            if (p1min >= p2min && p1max <= p2max) return res + 1;
            return res + 0;
        })(0);
    return to!string(sum);
}

string part2( string fileName, string param )
{
    auto patt = regex(r"(\d+)-(\d+),(\d+)-(\d+)");
    auto sum = File( fileName, "r" )
        .byLine
        .fold!( (res, line) 
        {
            auto m = matchFirst(line, patt);
            auto p1min = to!int( m[1] );
            auto p1max = to!int( m[2] );
            auto p2min = to!int( m[3] );
            auto p2max = to!int( m[4] );
            if (p1min <= p2max && p1max >= p2min) return res + 1;
            if (p2min <= p1max && p2max >= p1min) return res + 1;
            return res + 0;
        })(0);
    return to!string(sum);

}