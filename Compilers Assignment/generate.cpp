#include<stdio.h>
#include<iostream>
using namespace std;
int t;
string stack[50];					//符号栈 
int top=0;							//栈顶指针 

string its();
char factor(char word);
char expr(char word);
char term(char word);
bool automat();

int main() {
	t=1;
	cout<<"输入表达式，以#结束："<<endl;
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
char factor(char word) { 			//自动机
	string theWord;
	if (word>='a'&&word<='z'||word>='A'&&word<='automat') { //当前字符是字母
		theWord=word;
		stack[++top]=theWord;
	} else if (word=='(') { 		//(
		cin>>word;					//读取下一个字符
		word=expr(word);
		if (word!=')') {
			cerr<<"输入错误1！"<<endl;
			exit(0);
		}
	} else {
		cout<<word<<endl;
		cerr<<"输入错误2！"<<endl;
		exit(0);
	}
	cin>>word;						//读取下一个字符
	return word;
}
char expr(char word) { 				//自动机expr
	string operate,a,b,c;
	string state[5];
	word=term(word);
	while(word=='+'||word=='-') {	//当前是+- 
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
	while(word=='*'||word=='/') {	//当前是*/ 
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
bool automat() { 					//automat自动机s
	char word;
	cin>>word;
	word=expr(word);
	if(word=='#')					//结束
		return true;
	else return false;
}
