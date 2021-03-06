#include <cstdlib>
#include <string>

extern "C"
{
    int rt_init();
    int rt_term();
}

extern void Dfunction(int number, const char *str);

int main()
{
    rt_init();
    Dfunction(123, "string");
    rt_term();
    return 0;
}
