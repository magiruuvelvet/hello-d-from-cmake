module threading;

import std.stdio;
import std.concurrency;
import core.thread;
import core.sync.mutex;
import core.atomic;

private shared Mutex m;

private void increment(shared int *result, int i)
{
    m.lock();
    //writeln("thread", thisTid);
    //writeln(thread_isMainThread); // false
    scope(exit) m.unlock();

    atomicOp!"+="(*result, i);
}

void start_threads()
{
    writeln("---threading");

    // true
    writeln(thread_isMainThread);

    shared int result = 0;
    m = new shared Mutex();

    for (auto i = 0; i < 10; ++i)
    {
        spawn(&increment, &result, 10);
        new Thread({
            increment(&result, 10);
        }).start();
    }

    // wait for all threads to complete
    thread_joinAll();

    // should always print 200
    writeln(result);

    writeln("---threading");
}
