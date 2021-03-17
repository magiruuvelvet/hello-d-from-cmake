module tests.main;

import std.stdio;

import dunit;
import tests.config;

int main(string[] args)
{
    writefln("asset directory: %s", AssetDirectory);
    return dunit_main(args);
}
