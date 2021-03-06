import std.stdio;

extern (C++)
{
    void Dfunction(int number, const char *str)
    {
        writefln("hello from D\n%d %s\n", number, *str);
    }
}
