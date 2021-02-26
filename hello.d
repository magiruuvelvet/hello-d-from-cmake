import std.stdio;

static import func;
static import interop;
static import interop2;

int main(string[] args)
{
    writeln(args[0]);
    writeln("hello world");
    writeln(func.imported_function());
    writeln(func.calc(1, 2));

    writeln(interop.cpp_func2());

    auto str = interop.cpp_func();
    interop.print_string(str);

    int res = 0;
    interop2.c_function(5, &res);
    writeln(res);

    return 0;
}
