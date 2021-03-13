module func;

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
