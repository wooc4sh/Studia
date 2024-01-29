#include "list.h"
void wypisz(pelem lista) //wypisuje wszystkie elementy z listy
{
    while (lista != NULL) {
        printf("%d\n", lista->val);
        lista = lista->next;
    }
}
pelem usun_duplikaty(pelem lista) //zwraca liste bez duplikatow
{
    pelem result;
    result = utworz(lista->val);
    while (lista != NULL)
    {
        if(in(result, lista->val) == 0)
            result = push_back(result, lista->val);
        lista = lista->next;
    }
    return result;    
}

pelem utworz(int nval)  //tworzy nowy wezel i go zwraca
{
    pelem pom;
    pom = (pelem)malloc(sizeof(selem));
    pom->val = nval;
    pom->next = NULL;

    return pom;
}

pelem push_back(pelem lista, int val)
{   
    pelem temp = utworz(val);
    pelem pom = lista;
    while(lista->next != NULL)
        lista = lista->next;

    lista->next = temp;

    return pom;
}

pelem push_front(pelem lista, int val)
{
    pelem temp = utworz(val);
    temp->next = lista;

    return temp;
}

pelem pop_back(pelem lista)
{   
    if (!lista)
    {
        printf("Error: empty list, cannot pop.\n");
        return lista;   
    }
    else if (len(lista) == 1)
    {
        return NULL;   
    }else
    {
         while(lista->next->next != NULL)
            lista = lista->next;
          
             lista->next = NULL;
         return lista; 
    }   
}

pelem pop_front(pelem lista)
{
   if(!lista)
   {
       printf("Error: empty list, cannot pop.\n");
       return NULL;
   }else if(len(lista) == 1)
   {
       return NULL;
   }
   else
   {
       return lista->next;
   }
}

pelem append(pelem list_a, pelem list_b)
{
    if(!list_a && !list_b)
        return NULL;
    else if(len(list_a) > 0)
    {
         pelem result = list_a;
         while(list_a->next != NULL)
             list_a = list_a->next;
         
         list_a->next = list_b;
         return result;
    }else
    {
         pelem result = list_b;
         while(list_b->next != NULL)
             list_b = list_b->next;
         
         list_b->next = list_a;
         return result;
    }
}

int in(pelem lista, int n)
{
    if(!lista)
    {
        return 0;
    }else
        while(lista)
        {    
            if(lista->val == n)
                return 1;
            lista = lista->next;
        }
    return 0;
}

int len(pelem lista)
{
    int result = 0;
    
    while(lista)
        {
            lista = lista->next;
            result++;
        }
    return result;
}
