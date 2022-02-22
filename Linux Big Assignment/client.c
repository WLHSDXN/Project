#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <string.h>
#include "get_keyboard.h"
#define H 20
#define L 38 
#define UN 10
int g_boards[H][L] = {
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{0,0,0,0,1,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,1,1},
	{1,1,0,0,1,1,0,0,1,1,0,0,1,1,1,1,1,1,1,1,1,1,0,0,1,1,0,0,1,1,1,1,1,1,0,0,1,1},
	{1,1,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,1,1,0,0,1,1,0,0,0,0,0,0,1,1},
	{1,1,0,0,1,1,1,1,1,1,1,1,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,1,1,1,1,1,1,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1},
	{1,1,0,0,1,1,0,0,0,0,0,0,1,1,0,0,1,1,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1},
	{1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,1,1,1,1},
	{1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0,0,1,1},
	{1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0,0,1,1},
	{1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,1,1,1,1,1,1,1,1,0,0,1,1,0,0,1,1,1,1,1,1},
	{1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1},
	{1,1,0,0,0,0,0,0,1,1,0,0,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,0,0,1,1},
	{1,1,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,1,1},
	{1,1,0,0,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,0,0,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,0,0,1,1,1,1,1,1,0,0,0,0,0,0,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,1},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1}
}, boards[H][L]= {};
//print
void print(int boards[][L]) {
	int i,j;
	for(i=0; i<H; i++) {
		for(j=0; j<L; j++) {
			switch(boards[i][j]) {
				case 0:
					printf(" ");
					break; //rode
				case 1:
					printf("#");
					break; //wall
				case 3:
					printf("*");
					break; //desc
				case 10:
				case 7:
					printf("U");
					break; //user
			}
//			printf("%d",boards[i][j]);
		}
		printf("\n");
	}
}
int main() {
	//create socket
	int sockFd = socket(PF_INET,SOCK_STREAM,0);
	if(sockFd < 0) {
		perror("create socket error!");
		return -1;
	}
	printf("create socket OK!\n");
	//request connection
	struct sockaddr_in servAddr = {0};
	servAddr.sin_family = PF_INET;
	servAddr.sin_port = htons(8888);
	servAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
	int ret = connect(sockFd,(struct sockaddr *)&servAddr,sizeof(servAddr));
	if(ret < 0) {
		perror("connect error!");
		close(sockFd);
		return -1;
	}
	printf("connect OK!\n");
	//write
	printf("write to server:\n");
	char buf[1024];//the same size
	int num=1;
	while(1) {
		memset(buf,0,sizeof(buf));
		if(num>0){
		read (sockFd, boards, sizeof(boards));
		print(boards);
		num--;
		}
		int dir=get_keyboard();
		system("clear");
		sprintf(buf,"%d%c",dir,'\0');
		ret = write(sockFd,buf,sizeof(buf));
		if(ret < 0) {
			perror("write error!");
			close(sockFd);
			return -1;
		}
		read (sockFd, boards, sizeof(boards));
		print(boards);
		
	}
	close(sockFd);
	return 0;
}


