module main;

import std.stdio;
import std.conv;
import std.array;
import std.algorithm: fold, filter, canFind, sort, setIntersection;
import std.regex;

void main()
{
    writeln( "Part1 = ", part1( "data.txt", "9x8" ) );
    writeln( "Part2 = ", part2( "data.txt", "9x8" ) );
}

unittest
{
    assert( part1( "test1.txt", "3x3" ) == "CMZ" );
    assert( part2( "test1.txt", "3x3" ) == "MCD" );
}

string part1( string fileName, string param )
{
    int nStacks = param[0] - '0';
    int nLayers = param[2] - '0';
    int maxDepth = nStacks * nLayers;

    auto file = File( fileName, "r" );

    // Read in the state of the stacks
    dchar[][] stacks;
    stacks.length = nStacks;

    for( int i = 0 ; i < nLayers ; i++ )
    {
        auto line = file.readln;
        for ( int j = 0 ; j < nStacks ; j++ )
        {
            auto crate = line[ j*4 + 1 ];
            if ( crate == ' ') continue;
            stacks[j] ~= crate;
        }
    }

    // Reverse the stacks
    for (int i = 0 ; i < nStacks ; i++ ) 
    {
        auto N = stacks[i].length;
        stacks[i].reserve( nStacks * nLayers );
        for ( int j = 0 ; j < N/2 ; j++ )
        {
            auto t = stacks[i][j];
            stacks[i][j] = stacks[i][N-j-1];
            stacks[i][N-j-1] = t;
        }
    }

    // Read the number line and the blank line.
    file.readln;
    file.readln;

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

    // Assemble the top crates on each stack.
    dchar[] topCrates;
    foreach ( ref stack; stacks)
    {
        topCrates ~= stack[$-1];
    }

    return to!string(topCrates);
}

string part2( string fileName, string param )
{
    int nStacks = param[0] - '0';
    int nLayers = param[2] - '0';
    int maxDepth = nStacks * nLayers;

    auto file = File( fileName, "r" );

    // Read in the state of the stacks
    dchar[][] stacks;
    stacks.length = nStacks;

    for( int i = 0 ; i < nLayers ; i++ )
    {
        auto line = file.readln;
        for ( int j = 0 ; j < nStacks ; j++ )
        {
            auto crate = line[ j*4 + 1 ];
            if ( crate == ' ') continue;
            stacks[j] ~= crate;
        }
    }

    // Reverse the stacks
    for (int i = 0 ; i < nStacks ; i++ ) 
    {
        auto N = stacks[i].length;
        stacks[i].reserve( nStacks * nLayers );
        for ( int j = 0 ; j < N/2 ; j++ )
        {
            auto t = stacks[i][j];
            stacks[i][j] = stacks[i][N-j-1];
            stacks[i][N-j-1] = t;
        }
    }

    // Read the number line and the blank line.
    file.readln;
    file.readln;

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

    // Assemble the top crates on each stack.
    dchar[] topCrates;
    foreach ( ref stack; stacks)
    {
        topCrates ~= stack[$-1];
    }

    return to!string(topCrates);
}