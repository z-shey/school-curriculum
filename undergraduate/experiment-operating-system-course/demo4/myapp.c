#include <stdio.h>
#include "greeting.h"

int main(int argc, char const *argv[])
{
    char *p = "Hello World!"; // 指针最大作用就是解决空间碎片化
    test(p);

    return 0;
}
