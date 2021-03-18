#include <cstdio>
#include <string>

class CxxClass
{
public:
    CxxClass()
    {}

    ~CxxClass()
    {}

    static int get1()
    {
        return ([]{
            return 1;
        })();
    }

    int get() const
    {
        return this->num;
    }

    bool operator== (const CxxClass &other) const
    { return this->num == other.num; }

private:
    int num = 0;
};

class CxxClass2 final : public CxxClass
{
    CxxClass2()
    {}

    virtual ~CxxClass2()
    {}
};

const char *cpp_func()
{
    return "c string";
}

int cpp_func2()
{
    return 10;
}

void print_string(const char *str)
{
    std::printf("%s, %s (%s:%i)\n", __PRETTY_FUNCTION__, __FUNCTION__, __FILE__, __LINE__);
    std::printf("%s\n", str);
}
