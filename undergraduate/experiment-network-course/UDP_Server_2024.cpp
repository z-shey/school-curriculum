#define _CRT_SECURE_NO_WARNINGS
#define _WINSOCK_DEPRECATED_NO_WARNINGS

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <winsock2.h>//导入头文件winsock2.h,才可以在程序中调用socket、bind、listen等函数。

#define BUF_SIZE 30
void ErrorHandling(const char *message);

int main(int argc, char *argv[])
{
	WSADATA wsaData;
	SOCKET servSock;
	char message[BUF_SIZE];
	int strLen;
	int clntAdrSz;
	
	SOCKADDR_IN servAdr, clntAdr;
	if(argc!=2) {
		printf("用法: %s <port>\n", argv[0]);
		exit(1);
	}
	if(WSAStartup(MAKEWORD(2, 2), &wsaData)!=0)//调用WSAStartup函数，设置程序中用到的Winsock版本，并初始化相应版本的库
		ErrorHandling("WSAStartup() error!"); 
	
	servSock=socket(PF_INET, SOCK_DGRAM, 0);//创建UDP套接字，socket函数第一个参数表示选择IPv4协议，第二个参数表示支持UDP
	if(servSock==INVALID_SOCKET)
		ErrorHandling("UDP socket creation error");
	
	memset(&servAdr, 0, sizeof(servAdr));
	servAdr.sin_family=AF_INET;
	servAdr.sin_addr.s_addr=htonl(INADDR_ANY);
	servAdr.sin_port=htons(atoi(argv[1]));
	
	if(bind(servSock, (SOCKADDR*)&servAdr, sizeof(servAdr))==SOCKET_ERROR)
		ErrorHandling("bind() error");//分配地址
	
	while(1) 
	{
		clntAdrSz=sizeof(clntAdr);
		strLen=recvfrom(servSock, message, BUF_SIZE, 0,(SOCKADDR*)&clntAdr, &clntAdrSz);//接收数据
		if (strLen > 0) {
			// 打印消息
			printf("Received message: %s\n", message);
		}

		sendto(servSock, message, strLen, 0,(SOCKADDR*)&clntAdr, sizeof(clntAdr));//将接收到的数据进行逆向重传
	}	
	closesocket(servSock);
	WSACleanup();
	return 0;
}

void ErrorHandling(const char *message)
{
	fputs(message, stderr);
	fputc('\n', stderr);
	exit(1);
}