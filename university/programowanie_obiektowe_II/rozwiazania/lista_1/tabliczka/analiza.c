#include <stdio.h>
#include <stdlib.h>


void tabliczka(float x1, float x2, float y1, float y2, float skok)
{   
    //Sprawdz czy ktorys przedzial nie jest zdegenerowany
    if(x1 > x2 || y1 > y2)
    {
        printf("Przedzial zdegenerowany.\n");
        exit(EXIT_FAILURE);
    }
    
    //Idea jest taka, aby trzymac naglowek wierszy i kolumn w dwoch osobnych tablicach, alokowanych dynamicznie
    int wiersze, kolumny;
    float temp;

    //Obliczam rozmiar tablicy dla naglowka wierszy
    temp = x1;
    wiersze = 0;
    while(temp < x2)
    {
        wiersze++;
        temp += skok;
    }

    //Obliczam rozmiar tablicy dla naglowka kolumn
    temp = y1;
    kolumny = 0;
    while(temp < y2)
    {
        kolumny++;
        temp += skok;
    }
    
    //Alokuje pamiec dla naglowka wierszy
    float *row = (float *)malloc(wiersze * sizeof(float));
    if(row == NULL)
    {
        printf("Blad w alokacji pamieci.\n");
        exit(EXIT_FAILURE);
    }

    //Alokuje pamiec dla naglowka kolumn
    float *col = (float *)malloc(kolumny * sizeof(float));
    if(col == NULL)
    {
        printf("Blad alokacji pamieci.\n");
        exit(EXIT_FAILURE);
    }
    /*
    //Wypelniam tablice dla naglowka wierszy
    for(int i = 0, temp = x1; i < wiersze; i++, temp += skok)
        row[i] = temp;
    
    //Wypelniam tablice dla naglowka kolumn
    for(int i = 0, temp = y1; i < kolumny; i++, temp += skok)
        col[i] = temp;
    
    */
    
    temp = x1;
    int k = 0;
    while(temp < x2)
    {
       row[k] = temp;
       k++;
       temp += skok;
    }

    temp = y1;
    k = 0;
    while(temp <  y2)
    {
        col[k] = temp;
        k++;
        temp += skok;
    }

    
    //Wyswietl naglowek kolumn
    printf("      ");
    for (int i = 0; i < kolumny; i++) 
        printf("%.2f ", col[i]);
    printf("\n");
    

    //Wyswietl kolejno naglowek wiersza i wypelniony wiersz
    for(int i = 0; i < wiersze; i++)
    {   
        printf("%.2f  ", row[i]); //Naglowek wiersza
        for(int j = 0; j < kolumny; j++) //Caly wiersz
            printf("%.2f ", row[i]*col[j]);
        printf("\n");
    }
}


int main()
{

    tabliczka(0.2, 1.5, 0.2, 1.9, 0.3);

    /*
    float x1, x2, y1, y2, skok;
    x1 = 0.2;
    x2 = 1.5;
    y1 = 0.2;
    y2 = 1.9;
    skok = 0.2;

    int i = 0;
    int j = 0;
    float temp;
    
    temp = x1;
    while(temp < x2)
    {
        i++;
        temp += skok;
    }

    temp = y1;
    while(temp <  y2)
    {
        j++;
        temp += skok;
    }
    
    float *iksy = (float *)malloc(i* sizeof(float));
    
    if(iksy == NULL)
    {
        printf("Blad alokacji pamieci.\n");
        exit(EXIT_FAILURE);
    }
     
    float *igreki = (float *)malloc(j* sizeof(float));
        
    if(igreki == NULL)
    {
        printf("Blad alokacji pamieci.\n");                      exit(EXIT_FAILURE);
    }    
    

    temp = x1;
    int k = 0;
    while(temp < x2)
    {
       iksy[k] = temp;
       k++;
       temp += skok;
    }

    temp = y1;
    k = 0;
    while(temp <  y2)
    {
        igreki[k] = temp;
        k++;
        temp += skok;
    }


    printf("       ");
    for(int k =0; k<j; k++)
        printf("%.2f ", igreki[k]);
    printf("\n");
    
    for (int p = 0; p<i; p++) {
        printf("%.2f:  ", iksy[p]);
        for(int q = 0; q <j; q++)
        {
            printf("%.2f ", iksy[p] * igreki[q]);
        }
        printf("\n");
    }
    */


    return 0;
}
