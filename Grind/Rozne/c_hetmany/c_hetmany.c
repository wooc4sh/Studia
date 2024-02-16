#include <stdio.h>  
#define n 4

int tab[n][n];
int q = 0;

void probuj(int i);
int isfree(int x, int y);
void show();
int main(void)
{
    for (int i = 0; i < n; i++) 
        for (int j = 0; j < n; j++) 
            tab[i][j] = 0;
    
    probuj(0);
    if(q)
        show();

    return 0;
}
void show()
{
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if(tab[i][j] == 0)
                printf("o ");
            else
                printf("# ");
        }
        printf("\n");
        
    }
}
void probuj(int i)
{
    int k = -1;
    do {
        k = k+1;
        q = 0;
        if(isfree(k, i) == 1)
        {
            tab[k][i] = 1;
            if(i+1 < n)
            {
                probuj(i+1);
                if(q == 0)
                    tab[k][i] = 0;
            } else q = 1;
        }
    } while(!q && k < n-1);   
}
int isfree(int x, int y)
{
     for (int i = 0; i < n; i++) 
         if(tab[x][i] == 1 || tab[i][y] == 1)
            return 0;
    
     for (int i = 0; i < n; i++) 
     {  
        if(x-i >= 0 && y-i >= 0)
            if(tab[x-i][y-i] == 1)
                return 0;

        if(x+i < n && y+i < n)
            if(tab[x+i][y+i] == 1)
                return 0;

        if(x-i >= 0 && y+i < n)
            if(tab[x-i][y+i] == 1)
                return 0;

        if(x+i < n && y-i >= 0)
            if(tab[x+i][y-i] == 1)
                return 0;
     }

     return 1;
}
