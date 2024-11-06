# gcc swap.c -o swap

# gcc -E swap.c -o swap.i
# gcc -S swap.i -o swap.s
# gcc -c swap.s -o swap.o
# gcc swap.o -o swap

swap:swap.o
	gcc swap.o -o swap
swap.o:swap.s
	gcc -c swap.s -o swap.o
swap.s:swap.i
	gcc -S swap.i -o swap.s
swap.i:swap.c
	gcc -E swap.c -o swap.i