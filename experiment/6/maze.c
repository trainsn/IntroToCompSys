#include <stdio.h>
#include <stdlib.h>
int map[10][10][4];
int flag[10][10];
/* 0 west 1 south 2 east 3 north */
int dy[4]={-1,0,1,0};
int dx[4]={0,1,0,-1};
int enx,eny;
int ansx[50],ansy[50],ansp=0;
int count=0;
FILE	*fin,*fout;
void maze(int xx,int yy)
{
	int ansi,i,px,py;
	count++;
	if (count>=30000)
	{
		fprintf(fout,"NO");
		exit(0);
	}
	
	//print the valid way
	if (xx==enx&&yy==eny)
	{
		for (ansi=1;ansi<=ansp;ansi++)
		{
			fprintf(fout,"%d%d ",ansx[ansi],ansy[ansi]);
		}
	}
	
	//search through 4 directions
	for (i=3;i>=0;i--)
	{
		px=xx+dx[i];
		py=yy+dy[i];
		if (map[xx][yy][i]&& !flag[px][py]
		&&px>=0&&px<6&&py>=0&&py<8)
		{
			flag[px][py]=1;//mark the location
			ansx[++ansp]=px;//push into the result stack
			ansy[ansp]=py;
			maze(px,py);
			ansp--;//pop
			flag[px][py]=0;//clear the mark
		}
	}
}
int main(void)
{
	int two[4]={1,2,4,8};
	int i,j,k,stx=0,sty=0,exist;
	char ch;

	fin=fopen("maze.in","r");
	fout=fopen("maze.out","w");

	for (i=15;i>=0;i--)
	{
		ch=fgetc(fin);
	}
	ch=fgetc(fin);
	for (i=15;i>=0;i--)
	{
		ch=fgetc(fin);
		stx+=(ch-'0')*two[i];
	}
	ch=fgetc(fin);
	for (i=15;i>=0;i--)
	{
		ch=fgetc(fin);
		sty+=(ch-'0')*two[i];
	}
	ch=fgetc(fin);

	//create the map
	exist=0;
	for (i=0;i<6;i++)
		for (j=0;j<8;j++)
		{
			for (k=15;k>=0;k--)
			{
				ch=fgetc(fin);
				if (k==4&&ch=='1')
				{
					enx=i;
					eny=j;
					exist=1;
				}
				if (k<=3&&k>=0)
					map[i][j][k]=ch-'0';
			}
			ch=fgetc(fin);
		}

	if (exist==0)//if there is no exit, print "NO"
	{
		fprintf(fout,"NO");
		exit(0);
	}
	flag[stx][sty]=1;
	ansx[++ansp]=stx;
	ansy[ansp]=sty;
	maze(stx,sty);

}

