#include<stdio.h>
#include<iostream>
using namespace std;
int t;
string stack[50];					//����ջ 
int top=0;							//ջ��ָ�� 

string its();
char factor(char word);
char expr(char word);
char term(char word);
bool automat();

int main() {
	t=1;
	cout<<"������ʽ����#������"<<endl;
	automat();
}

string its(int a) { 				//int to string
	string d;
	char b='0',c;
	int i;
	while(a!=0) {
		i=a%10;
		a=a/10;
		c=(int)b+i;
		d=c+d;

	}
	return d;
}
char factor(char word) { 			//�Զ���
	string theWord;
	if (word>='a'&&word<='z'||word>='A'&&word<='automat') { //��ǰ�ַ�����ĸ
		theWord=word;
		stack[++top]=theWord;
	} else if (word=='(') { 		//(
		cin>>word;					//��ȡ��һ���ַ�
		word=expr(word);
		if (word!=')') {
			cerr<<"�������1��"<<endl;
			exit(0);
		}
	} else {
		cout<<word<<endl;
		cerr<<"�������2��"<<endl;
		exit(0);
	}
	cin>>word;						//��ȡ��һ���ַ�
	return word;
}
char expr(char word) { 				//�Զ���expr
	string operate,a,b,c;
	string state[5];
	word=term(word);
	while(word=='+'||word=='-') {	//��ǰ��+- 
		operate=word;
		cin>>word;
		word=term(word);
		b=stack[top--];
		a=stack[top--];
		cout<<"("<<operate<<","<<a<<","<<b<<",t"<<t<<")"<<endl;
		c="t"+its(t);
		stack[++top]=c;
		t++;
	}
	return word;
}
char term(char word) {
	string operate,a,b,c;
	string state[5];
	word=factor(word);
	while(word=='*'||word=='/') {	//��ǰ��*/ 
		operate=word;
		cin>>word;
		word=factor(word);
		b=stack[top--];
		a=stack[top--];
		cout<<"("<<operate<<","<<a<<","<<b<<",t"<<t<<")"<<endl;
		c="t"+its(t);
		stack[++top]=c;
		t++;
	}
	return word;
}
bool automat() { 					//automat�Զ���s
	char word;
	cin>>word;
	word=expr(word);
	if(word=='#')					//����
		return true;
	else return false;
}
