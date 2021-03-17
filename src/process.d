import std.process;
import std.stdio;

// check out how easy it is to run processes in foreground in D
// it's super easy, C++ is really lacking good process functions in its stdlib
// system() is not a solution because it is a shell escape nightmare and not portable

struct ProcessStatus
{
public:
    ubyte status = 255;
    string stdout = "";
    string stderr = "";

    string toString() const pure @safe
    {
        import std.format;
        return format("%s(success=%s, status=%s)", ProcessStatus.stringof, !this.error, this.status);
    }

private:
    bool error = true;
}

const(ProcessStatus) run_command(Args...)(const string command, const Args args)
{
    ProcessStatus status;
    try
    {
        // execute process without shell escape nightmares
        auto res = execute([command, args], null, Config.stderrPassThrough);
        status.error = false;
        status.status = cast(ubyte) res.status;
        status.stdout = res.output;
    }
    catch (Exception)
    {
        status.error = true;
        status.status = 255;
    }
    return status;
}

void command_tests()
{
    {
        auto status = run_command("echo", "hello world", "123", "\"");
        writeln(status);
        writeln(status.stdout);
    }
    {
        auto status = run_command("/usr/local/bin/this_binary_does_not_exist");
        writeln(status);
        writeln(status.stdout);
    }

    ProcessStatus st;
    writeln(st);
}

unittest
{
    ProcessStatus st;
    assert(st.toString() == "ProcessStatus(success=false, status=255)");
}
