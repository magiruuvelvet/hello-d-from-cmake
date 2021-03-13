import std.stdio;

interface Interface
{
    void someFunction();
}

abstract class AbstractClass
{
    this()
    {}

    void method()
    {
        writeln("abstract class method");
    }
}

class Implementation : Interface
{
    void someFunction()
    {
        // implemented
        writeln("implemented");
    }

    void extraFunction()
    {
        writeln("extra function");
    }
}

class ImplementedAbstractClass : AbstractClass
{
public:
    override size_t toHash() const @safe pure nothrow
    { return hashOf(this.num); }

    bool opEquals(const ImplementedAbstractClass other) const
    { writeln("cmp"); return this.num == other.num; }

    int num = 0;
}
