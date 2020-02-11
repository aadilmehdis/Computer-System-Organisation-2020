// Try gcc -S swap.c to generate assembly code
#include<stdio.h>

int swap_add(int *xp, int *yp){
    int x = *xp;
    int y = *yp;

    *xp = y;
    *yp = x;
    return x + y;
}

int main(){
    int arg1 = 534;
    int arg2 = 1057;
    int sum = swap_add(&arg1, &arg2);
    int diff = arg1 - arg2;

    return sum*diff;
}
