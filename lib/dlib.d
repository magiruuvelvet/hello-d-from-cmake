import std.stdio;
import std.string;

extern (C++)
{
    void Dfunction(int number, const char *str)
    {
        writefln("hello from D\n%d %s\n", number, fromStringz(str));
    }
}
