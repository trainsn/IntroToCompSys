#include <stdio.h>
#include <stdlib.h>
struct room
{
	char num[20],name[20] ;
	struct room *next;

};
int  main(void)
{
	int n,m,i,cp,j;
	char ch,name[20],num[20];
	int size=sizeof(struct room);
	struct room *head=NULL,*tail=NULL,*ptr,*p;
	int count;
	int flag;
	FILE *fin,*fout;
	fin=fopen("directory.in","r");
	fout=fopen("directory.out","w");

	// create the link list
	fscanf(fin,"%d",&n);
	fscanf(fin,"%c",&ch);
	for (i=0;i<n;i++)
	{
		p=(struct room *)malloc(size);
		//get name
		cp=0;
		while ((ch=fgetc(fin))!='\n')
		{
			(p->name)[cp++]=ch;
		}
		p->name[cp++]='\0';

		//get room number
		cp=0;
		while ((ch=fgetc(fin))!='\n')
		{
			p->num[cp++]=ch;
		}
		p->num[cp++]='\0';

		p->next=NULL;
		if (head==NULL)
			head=p;
		else
			tail->next=p;
		tail=p;
	}
	ch='0';
	fscanf(fin,"%d",&m);
	fscanf(fin,"%c",&ch);
	for (i=0;i<m;i++)
	{
		cp=0;
		fscanf(fin,"%c" ,&ch);
		while (ch!='\n'&&!feof(fin))
		{
			num[cp++]=ch;
			fscanf(fin,"%c" ,&ch);
		}
		num[cp++]='\0';

		//secrch
		ptr=head;
		count=0;
		while (count<n)
		{
			flag=1;
			for (j=0;j<cp;j++)
			{
				if (num[j]!=ptr->num[j])
				{
					flag=0;
					break;
				}
			}
			if (flag)//name==ptr->name
			{
				for (j=0;(ptr->name)[j]!='\0';j++)
				{
					fputc((ptr->name)[j],fout);
				}
				ch='\n';
				fputc(ch,fout);
				/*fprintf(fout,'\n');*/
				break;
			}
			ptr=ptr->next;//go to the next node 
			count++;
		}
		if (count==n)
			fprintf(fout,"No Entry\n");
	}
}
