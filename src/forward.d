module forward;

pragma(mangle, "_Dforward_declared_across_module")
extern (D) string forward_declared_across_module(string param)
{
    return param ~ ' ' ~ param;
}
