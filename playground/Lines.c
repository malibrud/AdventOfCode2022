#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#include "Lines.h"

#define INIT_CAPACITY 2

struct _Lines
{
    int capacity;
    int count;
    char **lines;
    void *buff;
};

Lines getLines( char *fileName )
{
    FILE *fp = fopen( fileName, "r" );
    if ( fp == NULL ) return NULL;

    Lines self = (Lines)malloc( sizeof(struct _Lines) );

    self->lines = (char**)malloc( sizeof(char*) * INIT_CAPACITY );
    self->capacity = INIT_CAPACITY;

    // Get the size of the file to store the text
    fseek( fp, 0, SEEK_END );
    fpos_t size;
    fgetpos( fp, &size );
    fseek( fp, 0, SEEK_SET );

    // Allocate the buffer to store the file contents
    self->buff = (char*)malloc( size ); 
    
    self->count = 0;
    char *bptr = self->buff;

    while ( fgets( bptr, size, fp ) )
    {
        // Grow the line array if necessary
        if ( self->count == self->capacity )
        {
            self->capacity *= 2;
            self->lines = (char*)realloc( self->lines, sizeof( char* ) * self->capacity );
        }

        int len = strlen( bptr );
        bptr[ len - 1 ] = '\0';
        self->lines[ self->count++ ] = bptr;
        bptr += len;
    }
    
}