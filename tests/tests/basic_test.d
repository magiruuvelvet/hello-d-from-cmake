import dunit;

class BasicTest
{
    mixin UnitTest;

    @Test
    @Tag("BasicTest")
    void assertEqualsFailure() @safe pure
    {
        string expected = "bar";
        string actual = "baz";

        assertEquals(expected, actual);
    }

    @Test
    @Tag("BasicTest")
    void assertEqualsSuccess() @safe pure
    {
        string expected = "bar";
        string actual = "bar";

        assertEquals(expected, actual);
    }
}
