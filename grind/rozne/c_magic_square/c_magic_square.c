#include <stdio.h>
#define n 3
#define suma 15
void probuj(int i);
int A[n*n];
int B[n*n];
int tab[n][n];
int dopuszczalny(int i, int x, int y); 
int q = 0;
void show();
int check();
int licznik = 0;

int main(void)
{
    for (int i = 0; i < n*n; i++) 
        A[i] = i%n;
    
    for (int i = 0; i < n*n; i++) 
        B[i] = i / n;

    for (int i = 0; i < n ; i++) 
        for (int j = 0; j < n; j++) 
            tab[i][j] = 0;
    
    probuj(1);
    //printf("%d\n", dopuszczalny(1, 0, 0));
    show();
    printf("\n\n%d\n", licznik);
    return 0;
}
int check()
{
   int result;
    
   //sprawdz wiersze
   result = 0;
   for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
         result += tab[i][j];
      }
      if(result != suma)
          return 0;
      result = 0;
   }

   //sprawdz kolumny
   result = 0;
   for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
         result += tab[j][i];
      }
      if(result != suma)
          return 0;
      result = 0;
   }

   //sprawdz diagonalna
   result = 0;
   for (int i = 0; i < n; i++) 
       result += tab[i][i];
       if(result != suma)
          return 0;
      result = 0;
    
    //sprawdz przeciwdiagonalna
    result = 0;
    int j = n-1;
    int i = 0;
    for(; i<n; i++, j--)
        result += tab[i][j];
    if(result != suma)
        return 0;

    return 1;
   
}
void show()
{
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            printf("%d ", tab[i][j]);
        }
        printf("\n");
    }
}
void probuj(int i)
{   
    licznik++;
    int u, v, k;
    k = -1;
    do {
        k = k + 1;
        u = A[k];
        v = B[k];
        q = 0;

        if(tab[u][v] == 0)
        {
            if(dopuszczalny(i, u, v) == 1)
            {
                 tab[u][v] = i;
                 if(i < n*n)
                 {
                    probuj(i+1);
                        if(q == 0)
                             tab[u][v] = 0;
                 }else
                 {
                    if(check())
                        q = 1;
                    else
                    {
                        q = 0;
                        tab[u][v] = 0;
                    }


                 } 
             }
        }
        
    } while (!q && k < n*n - 1);
}
int dopuszczalny(int k, int x, int y)
{   
     int result;

     result = k;
     for (int i = 0; i < n; i++) 
        result += tab[i][y];
 
     if(result > suma)
         return 0;

     result = k;
     for (int i = 0; i < n; i++) 
        result += tab[x][i];
 
     if(result > suma)
         return 0;
     
     if(x==y) 
     {
        result = k;
        for (int i = 0; i < n; i++) 
            result += tab[i][i];
        if(result > suma)
            return 0;
     }
     if(x+y == n-1)
     {
         result = k;
         int i = 0;
         int j = n-1;
         for(; i<n; i++, j--)
             result += tab[i][j];
         if(result > suma)
             return 0;
     }
     
     return 1;
}       

