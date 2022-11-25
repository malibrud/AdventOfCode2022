#include <stdlib.h>
#include <stdio.h>


main()
{

    FILE *fp = fopen("test.txt", "r");

    if (fp == NULL) printf( "error\n");

    char c = getc(fp);
    char buff[100];
    fgets(buff, 100, fp);

    fseek( fp, 0, SEEK_END);
    fpos_t pos;
    int size = fgetpos( fp, &pos );
}