import std.stdio;

struct SomeStruct
{
public:
    int a;
    int b;

    void setC(const int c)
    {
        this.c = c;
    }

    auto getC() const
    {
        return this.c;
    }

private:
    int c;
}

void arrays()
{
    // C++ syntax: int a[] = {1, 2, 3};
    const int[] a = [1, 2, 3];

    // C++ syntax: std::map<std::string, int> strintmap = {{"one",1},{"two",2},{"three",3}};
    const int[string] strintmap = [
        "one": 1,
        "two": 2,
        "three": 3,
        //4: 4,
    ];

    writeln(a);
    writeln(strintmap);
    writeln(strintmap["one"]);

    int[] b;
    b.reserve(1);
    b ~= [1];
    writeln(b);

    SomeStruct visibility_in_d_is_weird;
    visibility_in_d_is_weird.c = 30; // this should NOT be possible, but it is
    writeln(visibility_in_d_is_weird.c);
}
