#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/socket.h>
#include <netdb.h>
#include <fcntl.h>
#include <sys/epoll.h>
#include <string.h>

#include <signal.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <stdlib.h>
#include <arpa/inet.h>
#define MAXEVENTS 64

#include "get_keyboard.h"
#define H 20
#define L 38 
#define UN 10
int g_boards[H][L] = {
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{3,0,0,0,1,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,1,1},
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
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,3,3,1,1}
}, boards[H][L]= {};
//store user
typedef struct user {
	int fd;
	int row;
	int col;
	int flag;//0dead 1live
} U;
U user[UN];//10 users
int cnt = 0;//num of user OK
void initUsers() { 
	int i;
	for(i=0; i<UN; i++) {
		user[i].fd=-1;
		user[i].row=0;
		user[i].col=0;
		user[i].flag=0;
	}
}
int userSum() {
	int sum=0;
	while(user[sum].flag!=0) {
		sum++;
	}
	return sum;
}

void init() {
	int i;
	for(i=0; i<H*L; i++) {
		boards[i/L][i%L]=g_boards[i/L][i%L];
	}
}

void createPos(int id){
	int x=0;
	int y=0;
	while(boards[x][y]==1){
		x=rand()%H;
		y=rand()%L;
	}
	user[id].row=x;
	user[id].col=y;
	boards[x][y]=7;
} 

void move(int id,int nrow, int ncol, int nnrow, int nncol) {
	if(0==boards[nrow][ncol] || 3==boards[nrow][ncol]) { //0 1
		boards[nrow][ncol] +=7;// in
		boards[user[id].row][user[id].col] -=7;//out
		user[id].row = nrow;
		user[id].col = ncol;
	} 
	int i;
	for(i=0; i<H; i++) { //judge
		int j;
		for(j=0; j<L; j++) {
			if(10==boards[i][j]||-4==boards[i][j]) {
				cnt++;
			}
			if(userSum()==cnt) {
				printf("Í¨¹Ø£¡\n");
				close(user[id].fd);
			}
		}
	}
	cnt=0; //judge again
}

int getId(int infd){
	int i=0;
	while(user[i].fd!=infd){
		i++;
	}
	return i;
}
static int setnonblocking (int);
void handle_get(int fd, char path[]); 
int
main (int argc, char *argv[]) {
	init(); 
	int sfd, s;
	int efd;
	struct epoll_event event;
	struct epoll_event *events;
	struct addrinfo hints;
	struct addrinfo *result, *rp;
	char cmd[1024];
	char path[1024];
	if (argc != 2) {
		fprintf (stderr, "Usage: %s [port]\n", argv[0]);
		exit (EXIT_FAILURE);
	}
	memset (&hints, 0, sizeof (struct addrinfo));
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;
	hints.ai_flags = AI_PASSIVE;
	if (getaddrinfo (NULL, argv[1], &hints, &result) != 0) {
		perror("getaddrinfo");
		return -1;
	}
	for (rp = result; rp != NULL; rp = rp->ai_next) {
		if ((sfd = socket (rp->ai_family, rp->ai_socktype, rp->ai_protocol)) == -1)
			continue;
		if (bind (sfd, rp->ai_addr, rp->ai_addrlen) == 0) {
			break;
		}
		close (sfd);
	}
	if (rp == NULL) {
		fprintf (stderr, "Could not bind\n");
		return -1;
	}
	freeaddrinfo (result);
	if (sfd == -1)
		exit(EXIT_FAILURE);
	if (setnonblocking (sfd) == -1)
		abort ();
	if (listen (sfd, SOMAXCONN) == -1) {
		perror ("listen");
		exit(EXIT_FAILURE);
	}
	if ((efd = epoll_create1 (0)) == -1) {
		perror ("epoll_create");
		exit(EXIT_FAILURE);
	}
	event.data.fd = sfd;
	event.events = EPOLLIN | EPOLLET;
	if (epoll_ctl (efd, EPOLL_CTL_ADD, sfd, &event) == -1) {
		perror ("epoll_ctl: listen_soc");
		exit(EXIT_FAILURE);
	}
	events = calloc (MAXEVENTS, sizeof event);
	while (1) {
		int n, i,nn;
		if ((n = epoll_wait (efd, events, MAXEVENTS, -1)) == -1) {
			perror("epoll_pwait");
			exit(EXIT_FAILURE);
		}
		for (i = 0; i < n; i++) {
			if (sfd == events[i].data.fd) {
				while (1) {
					struct sockaddr in_addr;
					socklen_t in_len;
					int infd;
					char hbuf[NI_MAXHOST], sbuf[NI_MAXSERV];
					in_len = sizeof in_addr;
					if ((infd = accept (sfd, &in_addr, &in_len)) == -1) {
						if ((errno == EAGAIN) ||(errno == EWOULDBLOCK)) {
							break;
						} else {
							perror ("accept");
							break;
						}
					}
					if (getnameinfo (&in_addr, in_len,hbuf, sizeof hbuf,sbuf, sizeof sbuf,NI_NUMERICHOST | NI_NUMERICSERV) == 0) {
						printf("Accepted connection on descriptor %d "
						       "(host=%s, port=%s)\n", infd, hbuf, sbuf);
						user[userSum()].flag=1;
						user[userSum()-1].fd=infd;
						createPos(userSum()-1);//generate a position
						write(infd, boards, sizeof(boards));//print() all users
					}
					if (setnonblocking (infd) == -1) {
						perror ("setnonblocking");
						exit(EXIT_FAILURE);
					}
					event.data.fd = infd;
					event.events = EPOLLIN | EPOLLET;
					if (epoll_ctl (efd, EPOLL_CTL_ADD, infd, &event) == -1) {
						perror ("epoll_ctl");
						exit(EXIT_FAILURE);
					}
				}
				continue;

			} else {//do_use_fd
			
				int done = 0;
				while (1) {
					ssize_t count;
					char buf[1024];
					int infd=events[i].data.fd;
					count = read (events[i].data.fd, buf, sizeof(buf));
					if (count == -1) {
						if (errno != EAGAIN) {
							perror ("read");
							done = 1;
						}
						break;
					} else if (count == 0) {
						done = 1;
						break;
					}
					
					sscanf(buf, "%s%s%c", cmd, path,'\0');
					int dir=atoi(buf);
					int id=getId(infd);
					switch(dir) { //judge position
						case KEY_W:
						case KEY_w:
						case KEY_UP:
							move(id,user[id].row-1, user[id].col, user[id].row-2, user[id].col);
							break;
						case KEY_S:
						case KEY_s:
						case KEY_DOWN:
							move(id,user[id].row+1, user[id].col, user[id].row+2, user[id].col);
							break;
						case KEY_A:
						case KEY_a:
						case KEY_LEFT:
							move(id,user[id].row, user[id].col-1, user[id].row, user[id].col-2);
							break;
						case KEY_D:
						case KEY_d:
						case KEY_RIGHT:
							move(id,user[id].row, user[id].col+1, user[id].row, user[id].col+2);
							break;
						case KEY_q:
							exit(0);//exit
					}
					write(infd, boards, sizeof(boards));
				}
			}
		}
	}
	free (events);
	close (sfd);
	return EXIT_SUCCESS;
}
static int
setnonblocking (int sfd) {
	int flags, s;
	flags = fcntl (sfd, F_GETFL, 0);
	if (flags == -1) {
		perror ("fcntl");
		return -1;
	}
	flags |= O_NONBLOCK;
	s = fcntl (sfd, F_SETFL, flags);
	if (s == -1) {
		perror ("fcntl");
		return -1;
	}
	return 0;
}
