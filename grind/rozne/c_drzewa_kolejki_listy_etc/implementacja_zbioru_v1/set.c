#include "myset.h"
myset munion(myset set_a, myset set_b)
{
    myset result = append(set_a, set_b);
    return usun_duplikaty(result);
}
myset mintersection(myset set_a, myset set_b)
{
    
}
myset mdifference(myset set_a, myset set_b)
{
    if(mempty(set_a))
        return NULL;
   
}
