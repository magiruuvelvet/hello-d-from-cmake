import std.stdio;
import std.string;
import cstdio = core.stdc.stdio;
import std.typecons : scoped;
import fs = std.file;
import std.process : environment, execute;
alias env = environment;

static import func;
static import interop;
static import interop2;

import Class;
import Template;
import Interface;
static import arrays;
import threading;
import process;

static import features;

import cerealed;

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

void main2(string def = "default value")
{
    scope(exit)
    {
        writeln("main2 returned, goodby");
    }

    version (MyFeature_Enabled)
    {
        writeln("my feature is enabled");
    }
    else
    {
        writeln("my feature is disabled");
    }

    writeln(def);
}

void main2(string def, int a)
{
    writeln(def, a);
}

pragma(inline) void call_me(void delegate() lambda)
{
    lambda();
}

int call_me_with_args(int delegate(int) lambda, int arg)
{
    return lambda(arg) + lambda(arg);
}

void about_pointers()
{
    // null pointers are false when used as boolean

    string msg = "msg";
    string *msgptr = null;
    writeln(msgptr ? "not null" : "null"); // null
    msgptr = &msg;
    writeln(msgptr ? "not null" : "null"); // not null
    writeln(msgptr.length); // 3, string.length called, there is no separate -> operator like in C++
    msgptr = null;
    //writeln(msgptr.length); // segmentation fault, weirdly glad this is possible in D
        // i like programming languages which don't try to babysit you too hard and let you shot yourself in the foot

    // apparently in D arrays can be "null" too
    // but length can still be used safely and returns 0
    // empty arrays are false
    // empty strings are true

    string msg2 = null;
    writeln(msg2 ? "not null" : "null"); // null
    msg2 = "msg";
    writeln(msg2 ? "not null" : "null"); // not null
    msg2 = "";
    writeln(msg2 ? "not null" : "null"); // not null

    int[] array = null;
    writeln(array ? "not null" : "null", array.length); // null 0
    array = [];
    writeln(array ? "not null" : "null", array.length); // null 0
    array = [1];
    writeln(array ? "not null" : "null", array.length); // not null 1
}

int main(string[] args)
{
    writeln(args[0]);
    writeln(env.get("HOME", ""));
    writeln("hello world");
    writefln("%s, %s (%s:%s)", __PRETTY_FUNCTION__, __FUNCTION__, __FILE__, __LINE__);
    writeln(func.imported_function());
    writeln(func.calc(1, 2));
    writeln(func.get_data_from_lambda());

    writeln(interop.cpp_func2());

    auto str = interop.cpp_func();
    interop.print_string(str);

    int res = 0;
    interop2.c_function(5, &res);
    writeln(res);

    main2();
    main2("abc");
    main2("abc", 1);

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

        Struct struct_;
        writeln(struct_.getValue());
        // with structs the destructor is called immediately when out of scope
        // also stack allocation is possible out of the box without using scoped
    }
    writeln("---");
    {
        auto instance2 = new Class(10);
        instance2.publicMethod();
        writeln("getNumber:", instance2.getNumber());
        //instance2.getNumber() = 4;
        // without explicit delete the destructor is called when main() returns

        Struct struct_ = 10;
        writeln(struct_.getValue());
        // with structs the destructor is called immediately when out of scope
    }
    int instance2 = 0; // scope ended, "instance2" variable name available again to use with different data type (just like in C++)
    writeln("---");
    {
        // using scoped for stack allocation works
        // using "Class instance3;" directly causes a segfault
        auto instance3 = scoped!Class;
        instance3.publicMethod();
        //instance3.abc(); // error
        auto instance4 = scoped!Class2;
        instance4.publicMethod();
        instance4.abc();
        // class destructor is called when scoped goes out of scope
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

    auto f = scoped!Implementation;
    f.someFunction();
    f.extraFunction();

    // testing if this works as in C++, except that C++ is using "something() = 0" instead of "interface" for abstract classes
    auto pol = cast(Interface)f;
    pol.someFunction();
    //pol.extraFunction(); // error as expected

    //auto f2 = new Interface(); // error as expected

    // so there are "abstract classes" and "interfaces" in D :thinking:
    auto cl = scoped!ImplementedAbstractClass;
    cl.method();

    // testing if abstract classes can be cast back to as interfaces
    auto pl2 = cast(AbstractClass)cl;
    pl2.method();

    writeln("---");

    // operator overloading
    writeln(cl == new ImplementedAbstractClass()); // true, uses operator
    cl.num = 1;
    writeln(cl == new ImplementedAbstractClass()); // false, uses operator
    //writeln(cl == cl);                             // true, not using operator why?, this line makes valgrind go brrrr
    auto cl1 = scoped!ImplementedAbstractClass();
    cl1.num = 1;
    auto cl2 = scoped!ImplementedAbstractClass();
    cl2.num = 1;
    //writeln(cl1 == cl2);                           // true, not using operator why?, this line makes valgrind go brrrr

    // unicode (utf-8) check
    writeln("日本語は楽しいです。");

    foreach (char ch; "日本語")
    { write(ch, ','); } // iterates over bytes, prints garbage
    writeln();
    foreach (dchar ch; "日本語")
    { write(ch, ','); } // iterates over code points, prints '日,本,語,'
    writeln();
    writeln("日本語".length); // prints 9
    writeln("日本語"d.length); // prints 3

    cstdio.printf("%s\n", toStringz("D string"));

    // lambda functions
    call_me(delegate(){
        writeln("call me 1");
    });
    call_me((){
        writeln("call me 2");
    });
    call_me({
        writeln("call me 3");
    });

    // lambda function with arguments
    auto result = call_me_with_args((int c){
        return c;
    }, 10);
    writeln(result); // 20

    result = call_me_with_args((c1){ // datatype not even required
        return c1 * 2;
    }, 20);
    writeln(result); // 80

    result = call_me_with_args(delegate(arg){
        return 1; // ignore passed argument
    }, 0);
    writeln(result); // 2

    // testing 3rd party libraries using CMake rather than dub
    writeln(cerealise(5));
    assert(cerealise(5) == [0, 0, 0, 5]);

    // cmake configured value
    writeln(features.build_system_configured);


    arrays.arrays();
    arrays.SomeStruct st;
    st.a = 0;
    //st.c = 1; // here we get an error as expected, but instead of saying private, it says doesn't exist???
    st.setC(2);
    writeln(st);

    // just testing something with strings
    //'should fail'; // it does, thanks :)
    cast(void)"should work";
    cast(void)'c';

    start_threads();

    command_tests();

    // template arguments with literal values
    TemplatedStruct!(int, 10) array;
    writeln(array.length); // prints 10

    about_pointers();


    writeln("\ngoodby");
    // there should be only 1 destructor call after main returns in this example
    return 0;
}

unittest
{
    writeln("running tests...");
    assert(true);
}

unittest
{
    // prints cryptic crap to console (it's actually just the backtrace, but it's way too long),
    // manual unit testing like in C++ may still be desired in some cases when a more human-friendly
    // output is desired and printing miles long backtraces just makes no sense
    //assert(false);
}
