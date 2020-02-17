#include<stdio.h>
#include<string.h>

void func(char *str) {
	char buffer[16];
	strcpy(buffer,str);
}

void main() {
	char large_string[256];
	int i;
	for( i = 0; i < 255; i++)
		large_string[i] = 'A';
func(large_string);
}
