// scan.cpp : Defines the entry point for the console application.
#include "string.h"
#include "math.h"
#include<stdio.h>//
//关键字表和界符表 
char keywords[30][12]= {"program","begin","end","var","while","do","repeat",
                        "until","for","to","if","then","else",";", ":", "(", ")", ",",
                        ":=", "+", "-", "*", "/", ">", ">=", "==", "<", "<="
                       };
int num_key=28;

//状态转换矩阵 
int aut[11][8]= { 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 2, 0, 0, 0, 8, 9,15,
                  0, 2, 3, 5,11, 0, 0,11,
                  0, 4, 0, 0, 0, 0, 0, 0,
                  0, 4, 0, 5,11, 0, 0,11,
                  0, 7, 0, 0, 6, 0, 0, 0,
                  0, 7, 0, 0, 0, 0, 0, 0,
                  0, 7, 0, 0,11, 0, 0,11,
                  0, 8, 0, 0, 0, 8, 0,12,
                  0, 0, 0, 0, 0, 0,10,14,
                  0, 0, 0, 0, 0, 0, 0,13
                };
                
//符号表 
char ID[50][12];//表中存有源程序中的标识符

//常数表 
int C[20];
int num_ID=0,num_C=0;

//其它变量 
struct token {
	int code;
	int value;
};                                    //Token结构
struct token tok[100];                    //Token数组
//int s;              //当前状态
int i_token=0,num_token=0;              //Token计数器和Token个数
char strTOKEN[15];                    //当前单词//当前已经识别出的单词
int i_str;                              //当前单词指针
int n,p,m,e,t;                           //尾数值，指数值，小数位数，指数符号，类型
double num;                           //常数值
char w[50];                            //源程序缓冲区
int i;                                  //源程序缓冲区指针,当前字符为w[i]

struct map {                           //当前字符到状态转换矩阵列标记的映射
	char str[50];
	int col;//状态列 
};
struct map col1[4]= {{"0123456789",1},{".",2},{"Ee",3},{"+-",4}};   //数字
struct map col2[2]= {{"abcdefghijklmnopqrstuvwxyz",5},{"0123456789",1}}; //关键字或标识符
struct map col3[1]= {{";:(),+-*/=><",6}};                   //界符
struct map *ptr;
int num_map;//?

void act(int s);
int find(int s,char ch);
int InsertConst(double num);
int Reserve(char *str);
int InsertID(char *str);
void printToken();
void printData();

 
int main(int argc, char* argv[]) {
	
	FILE *fp;
	int s;                                //当前状态 行 
	fp=fopen("exa.txt","r");
	while (!feof(fp)) {
//		printf("\n***********************************************开始之前行为");
		int zz;
		for (zz=0;zz<50;zz++){
			w[zz]='\n';//手动覆盖所有未清除数据 
		} 
//		printf("\n");
		fgets(w,50,fp);
		
		
		i=0;
//		printf("\n***********************************************当前行为");
//		int zz;
//		for (zz=0;zz<50;zz++){
//			printf("%c",w[zz]);
//		} 
//		printf("\n");
		do {
			while (w[i]==' ')                       //滤空格
				i++;
//			printData();
//			printf("####################################################当前w[i]是%c\n",w[i]); //以开头判断单词类型 
			if (w[i]>='a' && w[i]<='z') {                   //判定单词类别
				ptr=col2;
				num_map=2;
				//printf("ptr[num_map] %s\n",ptr->str[num_map]); 
			} else if (w[i]>='0' && w[i]<='9') {
				ptr=col1;
				num_map=4;
			} else if (strchr(col3[0].str,w[i])==NULL) {
				printf("非法字符%c\n",w[i]);
				i++;
				continue;
			} else {
				ptr=col3;
				num_map=1;
			}

			i--;
			s=1;
			//i_str = 0;// 
                                 //开始处理一个单词，状态转换 
			while (s!=0) {
				act(s);
				if (s>=11 && s<=14)
				break;
				
				i++;                                  //getchar()
				s=find(s,w[i]);
			}
			if (s==0) {
				strTOKEN[i_str]='\0';
				printf("词法错误：%s\n",strTOKEN);
			}
//		printToken();
		} while (w[i]!='\n' && w[i]!='\0' );//
	}

	printf("关键字表：");                        //输出结果
	for (i=0; i<30; i++)
		printf("%s ",keywords[i]);
	printf("\n");
	printf("\n");
	printf("Token序列：");
	for (i=0; i<num_token; i++)
		printf("(%d,%d)",tok[i].code,tok[i].value);
	printf("\n");
	printf("\n");
	printToken();//格式化输出 
	printf("\n");
	printf("符号表：");
	for (i=0; i<num_ID; i++)
		printf("%s ",ID[i]);
	printf("\n");
	printf("常数表：");
	for (i=0; i<num_C; i++)
		printf("%d ",C[i]);
	printf("\n");

	fclose(fp);
	printf("Hello World!\n");
	
	
	return 0;
}

void act(int s) {
//	printf("----------------------act()--------------------\n");
	int code;
	switch (s) {
		case 1:
			n=0;
			m=0;
			p=0;
			t=0;
			e=1;
			num=0;
			i_str=0;
//			strTOKEN[i_str]='\0';                   //其它变量初始化
//			strTOKEN[15]= {0};
			memset(strTOKEN, '\0', sizeof(strTOKEN));
//			printf("n=%d m=%d p=%d t=%d e=%d num=%lf i_str=%d strTOKEN=%s \n",n,m,p,t,e,num,i_str,strTOKEN);
//			printf("----------------------act()---end-----------------\n");
			break;
		case 2:
			n=10*n+w[i]-48;
//			printf("n=%d m=%d p=%d t=%d e=%d num=%lf i_str=%d strTOKEN=%s \n",n,m,p,t,e,num,i_str,strTOKEN);
//			printf("----------------------act()---end-----------------\n");
			break;
		case 3:
			t=1;
//			printf("----------------------act()---end-----------------\n");
			break;
		case 4:
			n=10*n+w[i]-48;
			m++;
//			printf("----------------------act()---end-----------------\n");
			break;
		case 5:
			t=1;
//			printf("----------------------act()---end-----------------\n");
			break;
		case 6:
			if (w[i]=='-') e=-1;
//			printf("----------------------act()---end-----------------\n");
			break;
		case 7:
			p=10*p+w[i]-48;
//			printf("----------------------act()---end-----------------\n");
			break;
		case 8:
//			printf("前w[%d] %c strTOKEN %s i_str %d\n",i,w[i],strTOKEN,i_str);
			strTOKEN[i_str++]=w[i];  //将ch中的符号拼接到strTOKEN的尾部；//
//			printf("后w[%d] %c strTOKEN %s i_str %d\n",i,w[i],strTOKEN,i_str);
//			printf("n=%d m=%d p=%d t=%d e=%d num=%lf i_str=%d strTOKEN=%s \n",n,m,p,t,e,num,i_str,strTOKEN);
//			printf("----------------------act()---end-----------------\n");
			break;
		case 9:
//			printf("前w[%d] %c strTOKEN %s i_str %d\n",i,w[i],strTOKEN,i_str);
			strTOKEN[i_str++]=w[i];  //将ch中的符号拼接到strTOKEN的尾部；
//			printf("后w[%d] %c strTOKEN %s i_str %d\n",i,w[i],strTOKEN,i_str);
//			printf("n=%d m=%d p=%d t=%d e=%d num=%lf i_str=%d strTOKEN=%s \n",n,m,p,t,e,num,i_str,strTOKEN);
//			printf("----------------------act()---end-----------------\n");
			break;
		case 10:
//			printf("前w[%d] %c strTOKEN %s i_str %d\n",i,w[i],strTOKEN,i_str);
			strTOKEN[i_str++]=w[i]; //将ch中的符号拼接到strTOKEN的尾部；
//			printf("后w[%d] %c strTOKEN %s i_str %d\n",i,w[i],strTOKEN,i_str);
//			printf("n=%d m=%d p=%d t=%d e=%d num=%lf i_str=%d strTOKEN=%s \n",n,m,p,t,e,num,i_str,strTOKEN);
//			printf("----------------------act()---end-----------------\n");
			break;
		case 11:
//			printf("num %lf n %d e %d p %d m %d\n",num,n,e,p,m); 
			num=n*pow(10,e*(p-m));           //计算常数值
//			printf("num %lf n %d e %d p %d m %d\n",num,n,e,p,m); 
			tok[i_token].code=2;//常数的编码（code）为2 
			tok[i_token++].value=InsertConst(num);  //生成常数Token
//			printf("tok[i_token++].value %d\n",tok[i_token].value);
			num_token++;
//			printf("----------------------act()---end-----------------\n");
			break;
		case 12:
//			printf("case 12:----------\n");
			strTOKEN[i_str]='\0';
//			printf("strTOKEN %s\n",strTOKEN);
			code=Reserve(strTOKEN);                   //查关键字表//关键字和界符的编码（code）为其在关键字表中的位置，值（value）为0。
//			printf("code %d\n",code);
			if (code) {
				tok[i_token].code=code;     //生成关键字Token
				tok[i_token++].value=0;
			} else {
				tok[i_token].code=1;
				tok[i_token++].value=InsertID(strTOKEN);
			}    //生成标识符Token
			num_token++;
//			printf("case 12:----------\n");
//			printf("n=%d m=%d p=%d t=%d e=%d num=%lf i_str=%d strTOKEN=%s \n",n,m,p,t,e,num,i_str,strTOKEN);
//			printf("----------------------act()---end-----------------\n");
			break;
		case 13:
			strTOKEN[i_str]='\0';
			code=Reserve(strTOKEN);                    //查界符表
			if (code) {
				tok[i_token].code=code;    //1 //生成界符Token
				tok[i_token++].value=0;//code
			} else {
				strTOKEN[strlen(strTOKEN)-1]='\0';           //单界符
				i--;
				code=Reserve(strTOKEN);                 //查界符表
				tok[i_token].code=code;
				tok[i_token++].value=0;  //生成界符Token
			}
			num_token++;
//			printf("n=%d m=%d p=%d t=%d e=%d num=%lf i_str=%d strTOKEN[%d]=%s \n",n,m,p,t,e,num,i_str,i_str,strTOKEN);
//			printf("----------------------act()---end-----------------\n");
			break;
		case 14:
			strTOKEN[i_str]='\0';
			code=Reserve(strTOKEN);                   //查界符表
			tok[i_token].code=code;
			tok[i_token++].value=0;    //生成界符Token
			num_token++;
//			printf("----------------------act()---end-----------------\n");
			break;
	}

}
int find(int s,char ch) {
//	printf("----------------------find()-----------------------\n");
	int i,col=7;//默认最后一列 
	struct map *p;
	p=ptr;
	for (i=0; i<num_map; i++){
//	printf("217 %s %c\n",(p+i)->str,ch);//
		if (strchr((p+i)->str,ch)) {//在map中可以找到ch的话，值为ch第一次出现的位置 
			col=(p+i)->col;//将map中的col赋值给col，以便找到下一状态 
//			printf("220 col %d\n",col);//
			break;
		}}
//		printf("223 aut[%d][%d] %d\n",s,col,aut[s][col]);//
//		printf("----------------------find()----end-------------------\n");
	return aut[s][col];
}
int InsertConst(double num) {
	int i;
	for (i=0; i<num_C; i++)
		if (num==C[i])
			return i;
	C[i]=num;
	num_C++;
	return num_C;//i 
}

int Reserve(char *str) {
//	printf("Reserve---------->\n");
	int i;
	for (i=0; i<num_key; i++){
//		printf("keywords[%d] %s str %s\n",i,keywords[i],str);
		if (!strcmp(keywords[i],str))//strcmp(str1,str2)，若str1=str2，则返回零；若str1<str2，则返回负数；若str1>str2，则返回正数。
			return (i);//return (i+3);
	}
//	printf("<------------Reserve\n"); 
	return 0;
}

int InsertID(char *str) {
	int i;
//	printf("ID %s\n",ID);
	for (i=0; i<num_ID; i++)
		if (!strcmp(ID[i],str))
			return i + 1;//不是下标 
	strcpy(ID[i],str);
	num_ID++;
//	printf("ID %s\n",ID);
	return num_ID;//i 
}
void printToken(){
	//输出token
	printf("Token序列：");
	for (i=0; i<num_token; i++){
		if(!tok[i].value){
			printf("(%s,%d)",keywords[tok[i].code],tok[i].value);//关键字 
		}else if (tok[i].code == 2){
			printf("(%d,%d)",tok[i].code,C[tok[i].value-1]);//常数 
		}else if (tok[i].code == 1){
			printf("(%d,%s)",tok[i].code,ID[tok[i].value-1]);//标识符 
		}else printf("#%d,%d#",tok[i].code,tok[i].value);
	} 
	printf("\n");
}
void printData(){
//printf("*****************************\n");
int i;
printf("C[] ");
for (i = 0;i < num_C;i++){
printf(" %d ",C[i]);
}
printf("\nID[] ");
for (i = 0;i < num_ID;i++){
printf(" %s ",ID[i]);
}
//printf("\n*****************************\n");
} 


