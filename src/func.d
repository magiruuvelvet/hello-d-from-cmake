module func;

// causes cyclic module error when built with CMake
// this makes huge frameworks like hunt-framework impossible to use
// with CMake, because only dub is supported and it works there :(
//
// found a workaround by reading the language reference again: --DRT-oncycle=ignore
// the behavior when using this is undefined and the order of construction/destruction
// is no longer guaranteed as defined by the spec, when using this workaround ensure
// each module has only one constructor/destructor, and even then it still may fail
shared static this()
{
    import std.stdio;
    writeln("func global state init");
}

shared static ~this()
{
    import std.stdio;
    writeln("func global state deinit");
}

string imported_function()
{
    return "hello";
}

string get_data_from_lambda()
{
    return ({
        return "string";
    })();
}

int calc(const int a, const int b)
{
    return a + b;
}

void recursive_import_test()
{
    import hello; // import hello which imports this file
    // when building with CMake each file is compiled individually
    // and then linked together, unless dub which builds everything
    // in a single transaction, in some cases the individual building
    // can cause a cyclic module constructor/destructor error
    // message at startup
    main2("recursive import");
}
