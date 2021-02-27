import std.stdio;
import std.typecons : scoped;

static import func;
static import interop;
static import interop2;

import Class;
import Template;

// rename imports
// import renamed = module.to.import;

/**
 * Decided to learn D. No plans yet to use it for an application.
 * In this example I try to figure out how D manages memory by
 * reading the docs and getting my hands dirty with some tests,
 * and compare it to the C++ RAII.
 *
 * Also experimenting with C and C++ interoperability by directly
 * linking the foreign language objects into the same binary.
 * No plans to try dynamic loading yet.
 *
 * I know D has a package manager, but I like CMake and git submodules :)
 * If I ever do a real D project, don't expect that I use dub for this.
 */

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

    writeln("---");
    {
        writeln("start of scope (does this work the same or similar as C++ RAII???)");

        // Class instance1; // stack allocation segfaults when calling any method
        auto instance1 = new Class();
        //instance1.number = 3; // error, private attribute
        instance1.publicMethod();
        //instance1.privateMethod(); // error, private method
        //delete instance1; // deprecated
        instance1.destroy();
    }
    writeln("---");
    {
        auto instance2 = new Class(10);
        instance2.publicMethod();
        // without explicit delete the destructor is called when main() returns
    }
    int instance2 = 0; // scope ended, "instance2" varialbe name available again to use with different data type (just like in C++)
    writeln("---");
    {
        // using scoped for stack allocation works
        // using "Class instance3;" directly causes a segfault
        auto instance3 = scoped!Class;
        instance3.publicMethod();
    }
    writeln("---");

    alias TemplatedClassStr = TemplatedClass!string;

    const auto a = scoped!TemplatedClassStr("hello");
    writeln(a.getVariable());
    const auto b = scoped!(TemplatedClass!int)(4);
    writeln(b.getVariable());

    //a.modifyVariable("changed"); // error as expected, non-const method called on const object
    auto c = scoped!(TemplatedClass!string)("hello");
    c.modifyVariable("changed");
    writeln(c.getVariable());


    writeln("\ngoodby");
    // there should be only 1 destructor call after main returns in this example
    return 0;
}
