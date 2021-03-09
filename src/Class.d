module Class;

import std.stdio;

class Class
{
public:
    this()
    {
        writeln("constructor 1");
    }

    this(int number)
    {
        writeln("constructor overload");
        this.number = number;
    }

    ~this()
    {
        writeln("destructor");
    }

    void publicMethod() const
    {
        writeln("public method called", this.number);
        this.privateMethod();
    }

private:
    int number = 0;

    void privateMethod() const
    {
        writeln("private method called");
    }
}

final class Class2 : Class
{
public:
    this()
    {}

    override void publicMethod() const
    {
        writeln("overridden public method called", this.number);
        this.privateMethod();
    }
}
