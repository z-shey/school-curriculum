#include <stdio.h>

int main()
{
    int a, b, temp;

    printf("Enter the value of a: ");
    scanf("%d", &a);
    printf("Enter the value of b: ");
    scanf("%d", &b);

    temp = a;
    a = b;
    b = temp;
    
    printf("The value of a after swapping: %d\n", a);
    printf("The value of b after swapping: %d\n", b);
    printf("The sum of a and b is: %d\n", a + b);

    return 0;
}