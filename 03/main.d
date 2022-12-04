module main;

import std.stdio;
import std.conv;
import std.array;
import std.algorithm: fold, filter, canFind, sort, setIntersection;

void main()
{
    writeln( "Part1 = ", part1( "data.txt", "" ) );
    writeln( "Part2 = ", part2( "data.txt", "" ) );
}

unittest
{
    assert( part1( "test1.txt", "" ) == "157" );
    assert( part2( "test1.txt", "" ) == "70" );
}

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