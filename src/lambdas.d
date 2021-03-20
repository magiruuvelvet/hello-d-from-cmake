import std.stdio;

void test_lambda_functions()
{
    int outer = 1;

    // delegate() is capturing outer variables, equivalent to C++ lambda [&]{}
    auto Delegate = delegate() {
        outer = 2;
    };

    Delegate();
    writeln(outer);

    // function() does not capture, compile error when accessing outer variable
    // equivalent to C++ lambda []{}
    auto Function = function() {
        // error, outer not captured
        //outer = 4;
        auto outer = 10; // outer can be used as new variable, is not treated as shadowing
        writeln(outer);
    };

    Function();
    writeln(outer);

    auto Delegate2 = delegate() {
        auto outer = 5; // outer can also be used inside delegates as new variable
        writeln(outer);
    };

    Delegate2();
    writeln(outer);

    // prints: 2, 10, 2, 5, 2
}
