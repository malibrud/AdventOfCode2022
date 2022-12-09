module main;

import std.stdio;
import std.conv;

void main()
{
    writeln( "Part1 = ", part1( "data.txt", "4" ) );
    writeln( "Part2 = ", part2( "data.txt", "14" ) );
}

unittest
{
    assert( part1( "test1.txt", "4" ) == "7" );
    assert( part1( "test2.txt", "4" ) == "5" );
    assert( part1( "test3.txt", "4" ) == "6" );
    assert( part1( "test4.txt", "4" ) == "10" );
    assert( part1( "test5.txt", "4" ) == "11" );

    assert( part2( "test6.txt",  "14" ) == "19" );
    assert( part2( "test7.txt",  "14" ) == "23" );
    assert( part2( "test8.txt",  "14" ) == "23" );
    assert( part2( "test9.txt",  "14" ) == "29" );
    assert( part2( "test10.txt", "14" ) == "26" );
}

string part1( string fileName, string param )
{
    auto runLen = to!int(param);

    auto line = File( fileName, "r" ).readln;

    int i;
    for ( i = runLen-1 ; i < line.length ; i++ )
    {
        auto notEqual = true;
        for (int j = i - runLen + 1 ; j <= i ; j++ )
        for (int k = j + 1          ; k <= i ; k++ )
            notEqual &= line[j] != line[k];
        if ( notEqual ) break;
    }

    return to!string( i+1 );
}

string part2( string fileName, string param )
{
    return part1( fileName, param );
}