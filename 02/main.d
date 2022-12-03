module main;

import std.stdio;
import std.conv;

void main()
{
    writeln( "Part1 = ", part1( "data.txt", "" ) );
    writeln( "Part2 = ", part2( "data.txt", "" ) );
}

unittest
{
    assert( part1( "test1.txt", "" ) == "15" );
    assert( part2( "test1.txt", "" ) == "12" );
}

string part1( string fileName, string param )
{
    auto lines = File( fileName, "r" ).byLine();
    int sum = 0;
    foreach (line; lines)
    {
        int p1 = line[0] - 'A';
        int p2 = line[2] - 'X';
        sum += (p2 + 1) + ( (p2 - p1 + 4) % 3 ) * 3;
    }
    return to!string(sum);
}

string part2( string fileName, string param )
{
    auto lines = File( fileName, "r" ).byLine();
    int sum = 0;
    foreach (line; lines)
    {
        int p1     = line[0] - 'A';
        int result = line[2] - 'X';
        int p2 = (p1 + result + 2) % 3;
        sum += (p2 + 1) + result * 3;
    }
    return to!string(sum);
}