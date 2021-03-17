import dunit;
import tests.config;
import std.string;
import fs = std.file;

class AssetTest
{
    mixin UnitTest;

    @Test
    @Tag("AssetTest")
    void testFileContents()
    {
        string file = fs.readText(AssetDirectory ~ "somefile.txt");
        assertEquals("contents\n", file);
    }
}
