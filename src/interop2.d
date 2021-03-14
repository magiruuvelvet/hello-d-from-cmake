module interop2;

extern (C) nothrow @nogc
{
    void c_function(int a, int *_out);
}
