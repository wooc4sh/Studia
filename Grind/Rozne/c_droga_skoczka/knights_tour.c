#include <stdio.h>
#define n 5

void probuj(int i, int x, int y);
//const int n = 5;
int a[8];
int b[8];
int h[n][n];
int q;
int q1;
int licznik = 0;

int main(int argc, char *argv[])
{
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            h[i][j] = 0;
    
    a[0] = -2; b[0] = -1;
    a[1] = -1; b[1] = -2;
    a[2] = -2; b[2] =  1;
    a[3] = -1; b[3] =  2;
    a[4] =  2; b[4] = -1;
    a[5] =  1; b[5] = -2;
    a[6] =  2; b[6] =  1;
    a[7] =  1; b[7] =  2;

    h[1][1] = 1;
    probuj(2, 1, 1);
        
    if(q)
    {
        for (int i = 0; i < n; i++) {
            for (int j  = 0; j < n; j++) {
                printf("%d ", h[i][j]);
        }
        printf("\n");

    }

    }
    else
        printf("Brak rozwiazania\n");
    return 0;
}
void probuj(int i, int x, int y)
{
    int k = -1;
    int u, v;

    do {
        k = k+1;
        q = 0;
        u = x + a[k];
        v = y + b[k];

        if((u>=0 && u<n) && (v>=0 && v<n))
        {
            if(h[u][v] == 0)
            {
                h[u][v] = i;
                if(i < n*n)
                {
                    probuj(i+1, u, v);
                    if(q == 0)
                        h[u][v] = 0;
                } else  q = 1;
            } 
        }
    } while (k<7 && !q);
    //q1 = q;
}
