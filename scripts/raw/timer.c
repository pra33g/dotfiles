#include <stdio.h>
#include <stdlib.h>
int main(int argc, char* argv[]){
	if (argc!=2){printf("Usage: timer 2, for 2 min timer\n");return 0;}
	int a = 60*atoi(argv[1]);
	while (a--){
		printf("Timer %d:%d\n", a/60, a%60);
		system("sleep 1");
		system("clear");

	}
	system("zenity --info --text='Countdown finished!'");
	return 0;
}
