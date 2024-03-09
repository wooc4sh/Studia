#include <stdio.h>
#include <stdlib.h>

/*
 Lukasz Kopyto
 322997
 Lista 1. Zadanie 2. Wersja druga z modyfikacja drugiego elementu.
 gcc ulamek.c -o ulamek
 */

//Struktura reprezentujaca ulamek
typedef struct 
{
    int num;
    int denum;
} Ulamek;

//Funkcja zwracajaca najwiekszy wspolny dzielnik
int nwd(int a, int b)
{
    if(b == 0)
        return a;
    return nwd(b, a%b);
}

//Funkcja tworzaca nowy ulamek w postaci uproszczonej
Ulamek* nowy_ulamek(int num, int denum)
{
    Ulamek* ulamek = (Ulamek*)malloc(sizeof(Ulamek)); //rezerewacja miejsca na ulamek
    if(ulamek == NULL)
    {
        printf("Blad alokacji pamieci.\n");
        exit(EXIT_FAILURE);
    } 
    int dzielnik = nwd(num, denum);
    ulamek->num = num / dzielnik;
    ulamek->denum = denum / dzielnik;

    return ulamek;
}

//Funkcja wypisujaca wartosc ulamka
void show(Ulamek* x)
{
    printf("%d / %d\n", x->num, x->denum);
}

//Funkcja dodajaca dwa ulamki
void add(Ulamek* x1, Ulamek* x2)
{
    int new_denum = x1->denum * x2->denum;
    int new_num = x1->num * x2->denum + x2->num * x1->denum;
    
    int factor = nwd(new_num, new_denum);

    x2->num = new_num / factor;
    x2->denum = new_denum / factor;
}
//Funkcja odejmujaca drugi ulamek od pierwszego
void sub(Ulamek* x1, Ulamek* x2)
{
    int new_denum = x1->denum * x2->denum;
    int new_num = x1->num * x2->denum - x2->num * x1->denum; 
    int factor = nwd(new_num, new_denum);

    x2->num = new_num / factor;
    x2->denum = new_denum / factor;
}

//Funkcja mnozaca dwa ulamki
void mult(Ulamek* x1, Ulamek* x2)
{
    int new_denum = x1->denum * x2->denum;
    int new_num = x1->num * x2->num; 
    int factor = nwd(new_num, new_denum);

    x2->num = new_num / factor;
    x2->denum = new_denum / factor;
}

//Funkcja dzielaca dwa ulamki
void divide(Ulamek* x1, Ulamek* x2)
{
    int new_denum = x1->denum * x2->num;
    int new_num = x1->num * x2->denum;    
    int factor = nwd(new_num, new_denum);

    x2->num = new_num / factor;
    x2->denum = new_denum / factor;
}

//Funkcja przypisuje wartosc ulamka drugiego do pierwszego
void set(Ulamek* x1, Ulamek* x2)
{
    x1->num = x2->num;
    x1->denum = x2->denum;
}

int main()
{
    Ulamek* x1 = nowy_ulamek(3,2);
    Ulamek* x2 = nowy_ulamek(7,16);
    Ulamek* temp = nowy_ulamek(x2->num, x2->denum);
    
    printf("Ulamek 1: ");
    show(x1);
    printf("Ulamek 2: ");
    show(x2); 
    
    printf("Ulamek 1 + Ulamek 2: ");
    add(x1, x2);
    show(x2);
    set(x2, temp);
    
    printf("Ulamek 1 - Ulamek 2: ");
    sub(x1, x2);
    show(x2);
    set(x2, temp);
    
    printf("Ulamek 1 * Ulamek 2: ");
    mult(x1, x2);
    show(x2);
    set(x2, temp);
    
    printf("Ulamek 1 : Ulamek 2: ");
    divide(x1, x2);
    show(x2);
    set(x2, temp);
    

    free(x1);
    free(x2);
    free(temp);
    return 0;
}
