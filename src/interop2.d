module interop2;

extern (C) nothrow @nogc @system
{
    void c_function(int a, int *_out);
}
