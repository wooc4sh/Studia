#include "list.h"


int main(int argc, char *argv[])
{   
    pelem temp = utworz(10);
    pelem nowa = utworz(1);
    temp = push_back(temp, 70);
    temp = push_back(temp, 60);
    temp = push_back(temp, 50);
    temp = push_back(temp, 40);
    temp = push_back(temp, 30);

    nowa = push_front(nowa, 2);
    nowa = push_front(nowa, 3);
    nowa = push_front(nowa, 4);
    nowa = push_front(nowa, 5);
    nowa = push_front(nowa, 6);

   // wypisz(nowa);
   // wypisz(temp);
    
    pelem stara = append(temp, nowa);

    wypisz(stara);
    printf("\n");
    stara = push_front(stara, 10);
    stara = push_back(stara, 1);
    wypisz(stara);
    printf("\n");
    stara = usun_duplikaty(stara);
    wypisz(stara);
    printf("\n");
    return 0;
}
