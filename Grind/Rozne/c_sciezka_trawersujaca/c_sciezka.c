#include <stdio.h>  
#define n 3

void probuj(int i, int x, int y);
int dopuszczalny(int x, int y);
int q = 0;
int A[2];
int B[2];
int max_result = 10000000;
int current = 10;
int a[3][3] = {{10, 9, 31}, {21, 7, 8}, {13, 14, 10}};

int main(void)
{
    A[0] = B[1] = 1;
    A[1] = B[0] = 0;
    probuj(1,0,0);
    printf("%d\n", max_result);

    return 0;
}
int dopuszczalny(int x, int y)
{
    if(x < n && y < n)
        return 1;
    return 0;
}
void probuj(int i, int x, int y)
{    
    int k = -1;
    int u, v;

    do {
        k = k + 1;
        u = x + A[k];
        v = y + B[k];
        q = 0;
        if(dopuszczalny(u, v) == 1)
        {
            current += a[u][v];
            if(i < 2*n-2)
            {
                probuj(i+1, u, v);
                if(q==0)
                    current -= a[u][v];
            }else
            {
                if(current < max_result)
                    max_result = current;
                current -= a[u][v];
            }       
        }
    } while (k < 1);

}

