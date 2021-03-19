module interop;

extern (C++) nothrow @nogc @system
{
    char *cpp_func();
    int cpp_func2();
    void print_string(const char *str);
}
