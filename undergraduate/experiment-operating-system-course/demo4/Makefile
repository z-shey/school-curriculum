myapp:greeting.o myapp.o # myapp 依赖 greeting.o 和 myapp.o，编译这两个目标文件
	gcc greeting.o myapp.o -o myapp 

greeting.o:greeting.c greeting.h # greeting.o 依赖 greeting.c 和 greeting.h，编译这两个目标文件
	gcc -c greeting.c 

myapp.o:myapp.c greeting.h # myapp.o 依赖 myapp.c 和 greeting.h，编译这两个目标文件
	gcc -c myapp.c 
