module Template;

class TemplatedClass(T)
{
public:
    this(T somevar)
    {
        this.var = somevar;
    }

    // const method
    T getVariable() const
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
