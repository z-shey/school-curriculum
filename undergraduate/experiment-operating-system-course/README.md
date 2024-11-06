```bash
gcc swap.c -o swap

gcc -E swap.c -o swap.i
gcc -S swap.i -o swap.s
gcc -c swap.s -o swap.o
gcc swap.o -o swap
```

```bash
gcc swap.c -o swap

gcc -E main.c -o main.i
gcc -S main.i -o main.s
gcc -c main.s -o main.o
gcc main.o -o main
```