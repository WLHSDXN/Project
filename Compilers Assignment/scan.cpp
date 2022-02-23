// scan.cpp : Defines the entry point for the console application.
#include "string.h"
#include "math.h"
#include<stdio.h>//
//�ؼ��ֱ�ͽ���� 
char keywords[30][12]= {"program","begin","end","var","while","do","repeat",
                        "until","for","to","if","then","else",";", ":", "(", ")", ",",
                        ":=", "+", "-", "*", "/", ">", ">=", "==", "<", "<="
                       };
int num_key=28;

//״̬ת������ 
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
                
//���ű� 
char ID[50][12];//���д���Դ�����еı�ʶ��

//������ 
int C[20];
int num_ID=0,num_C=0;

//�������� 
struct token {
	int code;
	int value;
};                                    //Token�ṹ
struct token tok[100];                    //Token����
//int s;              //��ǰ״̬
int i_token=0,num_token=0;              //Token��������Token����
char strTOKEN[15];                    //��ǰ����//��ǰ�Ѿ�ʶ����ĵ���
int i_str;                              //��ǰ����ָ��
int n,p,m,e,t;                           //β��ֵ��ָ��ֵ��С��λ����ָ�����ţ�����
double num;                           //����ֵ
char w[50];                            //Դ���򻺳���
int i;                                  //Դ���򻺳���ָ��,��ǰ�ַ�Ϊw[i]

struct map {                           //��ǰ�ַ���״̬ת�������б�ǵ�ӳ��
	char str[50];
	int col;//״̬�� 
};
struct map col1[4]= {{"0123456789",1},{".",2},{"Ee",3},{"+-",4}};   //����
struct map col2[2]= {{"abcdefghijklmnopqrstuvwxyz",5},{"0123456789",1}}; //�ؼ��ֻ��ʶ��
struct map col3[1]= {{";:(),+-*/=><",6}};                   //���
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
	int s;                                //��ǰ״̬ �� 
	fp=fopen("exa.txt","r");
	while (!feof(fp)) {
//		printf("\n***********************************************��ʼ֮ǰ��Ϊ");
		int zz;
		for (zz=0;zz<50;zz++){
			w[zz]='\n';//�ֶ���������δ������� 
		} 
//		printf("\n");
		fgets(w,50,fp);
		
		
		i=0;
//		printf("\n***********************************************��ǰ��Ϊ");
//		int zz;
//		for (zz=0;zz<50;zz++){
//			printf("%c",w[zz]);
//		} 
//		printf("\n");
		do {
			while (w[i]==' ')                       //�˿ո�
				i++;
//			printData();
//			printf("####################################################��ǰw[i]��%c\n",w[i]); //�Կ�ͷ�жϵ������� 
			if (w[i]>='a' && w[i]<='z') {                   //�ж��������
				ptr=col2;
				num_map=2;
				//printf("ptr[num_map] %s\n",ptr->str[num_map]); 
			} else if (w[i]>='0' && w[i]<='9') {
				ptr=col1;
				num_map=4;
			} else if (strchr(col3[0].str,w[i])==NULL) {
				printf("�Ƿ��ַ�%c\n",w[i]);
				i++;
				continue;
			} else {
				ptr=col3;
				num_map=1;
			}

			i--;
			s=1;
			//i_str = 0;// 
                                 //��ʼ����һ�����ʣ�״̬ת�� 
			while (s!=0) {
				act(s);
				if (s>=11 && s<=14)
				break;
				
				i++;                                  //getchar()
				s=find(s,w[i]);
			}
			if (s==0) {
				strTOKEN[i_str]='\0';
				printf("�ʷ�����%s\n",strTOKEN);
			}
//		printToken();
		} while (w[i]!='\n' && w[i]!='\0' );//
	}

	printf("�ؼ��ֱ�");                        //������
	for (i=0; i<30; i++)
		printf("%s ",keywords[i]);
	printf("\n");
	printf("\n");
	printf("Token���У�");
	for (i=0; i<num_token; i++)
		printf("(%d,%d)",tok[i].code,tok[i].value);
	printf("\n");
	printf("\n");
	printToken();//��ʽ����� 
	printf("\n");
	printf("���ű�");
	for (i=0; i<num_ID; i++)
		printf("%s ",ID[i]);
	printf("\n");
	printf("������");
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
//			strTOKEN[i_str]='\0';                   //����������ʼ��
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
//			printf("ǰw[%d] %c strTOKEN %s i_str %d\n",i,w[i],strTOKEN,i_str);
			strTOKEN[i_str++]=w[i];  //��ch�еķ���ƴ�ӵ�strTOKEN��β����//
//			printf("��w[%d] %c strTOKEN %s i_str %d\n",i,w[i],strTOKEN,i_str);
//			printf("n=%d m=%d p=%d t=%d e=%d num=%lf i_str=%d strTOKEN=%s \n",n,m,p,t,e,num,i_str,strTOKEN);
//			printf("----------------------act()---end-----------------\n");
			break;
		case 9:
//			printf("ǰw[%d] %c strTOKEN %s i_str %d\n",i,w[i],strTOKEN,i_str);
			strTOKEN[i_str++]=w[i];  //��ch�еķ���ƴ�ӵ�strTOKEN��β����
//			printf("��w[%d] %c strTOKEN %s i_str %d\n",i,w[i],strTOKEN,i_str);
//			printf("n=%d m=%d p=%d t=%d e=%d num=%lf i_str=%d strTOKEN=%s \n",n,m,p,t,e,num,i_str,strTOKEN);
//			printf("----------------------act()---end-----------------\n");
			break;
		case 10:
//			printf("ǰw[%d] %c strTOKEN %s i_str %d\n",i,w[i],strTOKEN,i_str);
			strTOKEN[i_str++]=w[i]; //��ch�еķ���ƴ�ӵ�strTOKEN��β����
//			printf("��w[%d] %c strTOKEN %s i_str %d\n",i,w[i],strTOKEN,i_str);
//			printf("n=%d m=%d p=%d t=%d e=%d num=%lf i_str=%d strTOKEN=%s \n",n,m,p,t,e,num,i_str,strTOKEN);
//			printf("----------------------act()---end-----------------\n");
			break;
		case 11:
//			printf("num %lf n %d e %d p %d m %d\n",num,n,e,p,m); 
			num=n*pow(10,e*(p-m));           //���㳣��ֵ
//			printf("num %lf n %d e %d p %d m %d\n",num,n,e,p,m); 
			tok[i_token].code=2;//�����ı��루code��Ϊ2 
			tok[i_token++].value=InsertConst(num);  //���ɳ���Token
//			printf("tok[i_token++].value %d\n",tok[i_token].value);
			num_token++;
//			printf("----------------------act()---end-----------------\n");
			break;
		case 12:
//			printf("case 12:----------\n");
			strTOKEN[i_str]='\0';
//			printf("strTOKEN %s\n",strTOKEN);
			code=Reserve(strTOKEN);                   //��ؼ��ֱ�//�ؼ��ֺͽ���ı��루code��Ϊ���ڹؼ��ֱ��е�λ�ã�ֵ��value��Ϊ0��
//			printf("code %d\n",code);
			if (code) {
				tok[i_token].code=code;     //���ɹؼ���Token
				tok[i_token++].value=0;
			} else {
				tok[i_token].code=1;
				tok[i_token++].value=InsertID(strTOKEN);
			}    //���ɱ�ʶ��Token
			num_token++;
//			printf("case 12:----------\n");
//			printf("n=%d m=%d p=%d t=%d e=%d num=%lf i_str=%d strTOKEN=%s \n",n,m,p,t,e,num,i_str,strTOKEN);
//			printf("----------------------act()---end-----------------\n");
			break;
		case 13:
			strTOKEN[i_str]='\0';
			code=Reserve(strTOKEN);                    //������
			if (code) {
				tok[i_token].code=code;    //1 //���ɽ��Token
				tok[i_token++].value=0;//code
			} else {
				strTOKEN[strlen(strTOKEN)-1]='\0';           //�����
				i--;
				code=Reserve(strTOKEN);                 //������
				tok[i_token].code=code;
				tok[i_token++].value=0;  //���ɽ��Token
			}
			num_token++;
//			printf("n=%d m=%d p=%d t=%d e=%d num=%lf i_str=%d strTOKEN[%d]=%s \n",n,m,p,t,e,num,i_str,i_str,strTOKEN);
//			printf("----------------------act()---end-----------------\n");
			break;
		case 14:
			strTOKEN[i_str]='\0';
			code=Reserve(strTOKEN);                   //������
			tok[i_token].code=code;
			tok[i_token++].value=0;    //���ɽ��Token
			num_token++;
//			printf("----------------------act()---end-----------------\n");
			break;
	}

}
int find(int s,char ch) {
//	printf("----------------------find()-----------------------\n");
	int i,col=7;//Ĭ�����һ�� 
	struct map *p;
	p=ptr;
	for (i=0; i<num_map; i++){
//	printf("217 %s %c\n",(p+i)->str,ch);//
		if (strchr((p+i)->str,ch)) {//��map�п����ҵ�ch�Ļ���ֵΪch��һ�γ��ֵ�λ�� 
			col=(p+i)->col;//��map�е�col��ֵ��col���Ա��ҵ���һ״̬ 
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
		if (!strcmp(keywords[i],str))//strcmp(str1,str2)����str1=str2���򷵻��㣻��str1<str2���򷵻ظ�������str1>str2���򷵻�������
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
			return i + 1;//�����±� 
	strcpy(ID[i],str);
	num_ID++;
//	printf("ID %s\n",ID);
	return num_ID;//i 
}
void printToken(){
	//���token
	printf("Token���У�");
	for (i=0; i<num_token; i++){
		if(!tok[i].value){
			printf("(%s,%d)",keywords[tok[i].code],tok[i].value);//�ؼ��� 
		}else if (tok[i].code == 2){
			printf("(%d,%d)",tok[i].code,C[tok[i].value-1]);//���� 
		}else if (tok[i].code == 1){
			printf("(%d,%s)",tok[i].code,ID[tok[i].value-1]);//��ʶ�� 
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


