#include <stdio.h>
#include <stdlib.h>

/*
 Lukasz Kopyto
 322997
 Lista 1. Zadanie 4.
 gcc tabliczka.c -o tabliczka
*/

void tabliczka(float x1, float x2, float y1, float y2, float skok)
{   
    //Sprawdz czy ktorys przedzial jest zdegenerowany
    if(x1 > x2 || y1 > y2)
    {
        printf("Przedzial zdegenerowany.\n");
        exit(EXIT_FAILURE);
    }
    
    //Idea jest taka, aby trzymac naglowek wierszy i kolumn w dwoch osobnych tablicach, alokowanych dynamicznie
    int wiersze, kolumny, k;
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
    
    //Wypelniam tablice dla naglowka wierszy    
    temp = x1;
    k = 0;
    while(temp < x2)
    {
       row[k] = temp;
       k++;
       temp += skok;
    }
    
    //Wypelniam tablice dla naglowka kolumn
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
    
    free(row);
    free(col);
}


int main()
{

    tabliczka(0.2, 1.3, 0.2, 3.14, 0.3);

    return 0;
}
