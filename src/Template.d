module Template;

class TemplatedClass(T)
{
public:
    this(T somevar)
    {
        this.var = somevar;
    }

    // const method
    ref const(T) getVariable() const
    {
        return this.var;
    }

    // non-const method
    void modifyVariable(T val)
    {
        this.var = val;
    }

private:
    T var;
}

struct TemplatedStruct(T, size_t S)
{
    T[S] attr;

    @property
    const(size_t) length() const
    {
        return this.attr.length;
    }
}
