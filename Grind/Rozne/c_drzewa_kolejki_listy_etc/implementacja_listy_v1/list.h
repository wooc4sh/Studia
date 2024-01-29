#include <stdio.h>
#include <stdlib.h>
typedef struct elem *pelem;
typedef struct elem{
    int val;
    pelem next;
} selem;

void wypisz(pelem lista);                //wypisuje liste
pelem usun_duplikaty(pelem lista);       //zwraca liste bez duplikatow
pelem utworz(int val);                   //zwraca liste 1-elementowa z nval
pelem push_back(pelem lista, int val);   //dodaje element na koniec
pelem push_front(pelem lista, int val);  //dodaje element na poczatek
pelem pop_back(pelem lista);             //usuwa element z konca
pelem pop_front(pelem lista);            //usuwa element z poczatku
pelem append(pelem a, pelem b);          //scala dwie listy
int in(pelem lista, int val);            //sprawdza czy val jest na liscie
int len(pelem lista);                    //zwraca dlugosc listy
