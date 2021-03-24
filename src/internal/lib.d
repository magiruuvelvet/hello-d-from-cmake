module internal.lib;

import std.stdio;

struct DiStruct
{
    int a;
}

private void internal_func_not_interesting_from_outside()
{
    writeln("internal_func_not_interesting_from_outside");
}

void public_function()
{
    DiStruct d;
    d.a = 1;
    internal_func_not_interesting_from_outside();
}
