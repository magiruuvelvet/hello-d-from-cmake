import dunit;

class BasicTest
{
    mixin UnitTest;

    @Test
    @Tag("BasicTest")
    public void assertEqualsFailure() @safe pure
    {
        string expected = "bar";
        string actual = "baz";

        assertEquals(expected, actual);
    }

    @Test
    @Tag("BasicTest")
    public void assertEqualsSuccess() @safe pure
    {
        string expected = "bar";
        string actual = "bar";

        assertEquals(expected, actual);
    }
}
