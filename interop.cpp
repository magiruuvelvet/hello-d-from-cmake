#include <cstdio>
#include <string>

const char *cpp_func()
{
    return "c string";
}

int cpp_func2()
{
    return 10;
}

void print_string(const char *str)
{
    std::printf("%s\n", str);
}
