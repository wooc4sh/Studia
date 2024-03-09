#include <stdio.h>
#include <stdlib.h>

/*
 Lukasz Kopyto
 322997
 Lista 1. Zadanie 2. Wersja pierwsza z funkcja zwracajaca wskaznik do nowoutworzonego elementu
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
Ulamek* add(Ulamek* x1, Ulamek* x2)
{
    int new_denum = x1->denum * x2->denum;
    int new_num = x1->num * x2->denum + x2->num * x1->denum;
    
    return nowy_ulamek(new_num, new_denum);
}
//Funkcja odejmujaca drugi ulamek od pierwszego
Ulamek* sub(Ulamek* x1, Ulamek* x2)
{
    int new_denum = x1->denum * x2->denum;
    int new_num = x1->num * x2->denum - x2->num * x1->denum;

    return nowy_ulamek(new_num, new_denum);
}

//Funkcja mnozaca dwa ulamki
Ulamek* mult(Ulamek* x1, Ulamek* x2)
{
    int new_denum = x1->denum * x2->denum;
    int new_num = x1->num * x2->num;
    
    return nowy_ulamek(new_num, new_denum);
}

//Funkcja dzielaca dwa ulamki
Ulamek* divide(Ulamek* x1, Ulamek* x2)
{
    int new_denum = x1->denum * x2->num;
    int new_num = x1->num * x2->denum;

    return nowy_ulamek(new_num, new_denum);
}

int main()
{
    Ulamek* u1 = nowy_ulamek(3,2);
    Ulamek* u2 = nowy_ulamek(7,16);
    printf("Ulamek 1: ");
    show(u1);
    printf("Ulamek 2: ");
    show(u2); 
    
    Ulamek* suma = add(u1, u2);
    printf("Ulamek 1 + Ulamek 2: ");
    show(suma);

    Ulamek* roznica = sub(u1, u2);
    printf("Ulamek 1 - Ulamek 2: ");
    show(roznica);

    Ulamek* iloczyn = mult(u1, u2);
    printf("Ulamek 1 * Ulamek 2: ");
    show(iloczyn);

    Ulamek* iloraz = divide(u1, u2);
    printf("Ulamek 1 : Ulamek 2: ");
    show(iloraz);

    
    free(suma);
    free(roznica);
    free(iloczyn);
    free(iloraz);
    free(u1);
    free(u2);
    return 0;
}
