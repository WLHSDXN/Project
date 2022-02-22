#ifndef GETCH_H
#define GETCH_H
#include <stdio.h>
#include <termios.h>
#include <stdlib.h>
#include <unistd.h>

typedef enum KEYBOARD {
    KEY_UP  = 183,
    KEY_DOWN = 184,
    KEY_RIGHT = 185,
    KEY_LEFT = 186,
    KEY_BACKSPACE = 127,
    KEY_ENTER = 10,
    KEY_SPACE = 32,
    KEY_0   = 48,
    KEY_1   = 49,
    KEY_2   = 50,
    KEY_3   = 51,
    KEY_4   = 52,
    KEY_5   = 53,
    KEY_6   = 54,
    KEY_7   = 55,
    KEY_8   = 56,
    KEY_9   = 57,
    KEY_A   = 65,
    KEY_B   = 66,
    KEY_C   = 67,
    KEY_D   = 68,
    KEY_E   = 69,
    KEY_F   = 70,
    KEY_G   = 71,
    KEY_H   = 72,
    KEY_I   = 73,
    KEY_J   = 74,
    KEY_K   = 75,
    KEY_L   = 76,
    KEY_M   = 77,
    KEY_N   = 78,
    KEY_O   = 79,
    KEY_P   = 80,
    KEY_Q   = 81,
    KEY_R   = 82,
    KEY_S   = 83,
    KEY_T   = 84,
    KEY_U   = 85,
    KEY_V   = 86,
    KEY_W   = 87,
    KEY_X   = 88,
    KEY_Y   = 89,
    KEY_Z   = 90,
    KEY_a   = 97,
    KEY_b   = 98,
    KEY_c   = 99,
    KEY_d   = 100,
    KEY_e   = 101,
    KEY_f   = 102,
    KEY_g   = 103,
    KEY_h   = 104,
    KEY_i   = 105,
    KEY_j   = 106,
    KEY_k   = 107,
    KEY_l   = 108,
    KEY_m   = 109,
    KEY_n   = 110,
    KEY_o   = 111,
    KEY_p   = 112,
    KEY_q   = 113,
    KEY_r   = 114,
    KEY_s   = 115,
    KEY_t   = 116,
    KEY_u   = 117,
    KEY_v   = 118,
    KEY_w   = 119,
    KEY_x   = 120,
    KEY_y   = 121,
    KEY_z   = 122
} KEYBOARD;

//此函数能立即从键盘不回显的接收数据
static int get_keyboard(void) {
//接收系统调用的执行结果
	int ret = 0;
//存储终端设备的配置信息
	struct termios old;
//通过系统调用获取终端的配置信息
	ret=tcgetattr(STDIN_FILENO,&old);
	if(0 > ret) {
		perror("tcgetattr");
		return -1;
	}
//初始化新的终端配置信息
	struct termios new = old;
//取消回显并立即获取
	new.c_lflag &= ~(ICANON|ECHO);
//设置新的终端配置信息
	ret= tcsetattr(STDIN_FILENO,TCSANOW,&new);
	if(0 > ret) {
		perror("tcsetattr");
		return -2;
	}
//在新的模式下从终端获取数据
	int key_value = 0;
	do {
		key_value += getchar();
//由于和系统对FILE结构体的实现各不相同
//linux系统 while(stdin->_IO_read_end - stdin->_IO_read_ptr);
//OS系统 while(stdin->_r);
	} while(stdin->_IO_read_end - stdin->_IO_read_ptr);
//还原终端的配置信息
	ret = tcsetattr(STDIN_FILENO,TCSANOW,&old);
	if(0 > ret) {
		perror("tcsetattr");
		return -3;
	}
//返回获取到的数据
	return key_value;
}
#endif//GETCH_H
