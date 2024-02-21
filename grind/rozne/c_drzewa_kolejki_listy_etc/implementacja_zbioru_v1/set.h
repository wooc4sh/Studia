#include "list.h"
#include "list.c"
//WROC DO TEGO JAK POPRAWISZ IMPLEMENTACJE LISTY
//TO ZNACZY PROBLEM JEST Z PUSTYM ZBIOREM, MOZE PUSTA LISTE POPRAWIC?
typedef pelem myset;

myset munion(myset set_a, myset set_b);
myset mintersection(myset set_a, myset set_b);
myset mdifference(myset set_a, myset set_b);
myset madd(myset set_a, int k);
myset mout(myset set_a, int k);
myset mcreate(int val);
void mshow(myset set);
int mempty(myset set);
int min(myset set, int a);
int msize(myset set);
