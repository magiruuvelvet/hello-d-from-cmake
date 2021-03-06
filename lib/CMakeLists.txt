CreateTarget(callD EXECUTABLE callD C++ 14)
CreateTarget(Dlib SHARED Dlib D 2)

# for rt_init/rt_term, this is not portable across D compilers
target_link_libraries(callD PRIVATE Dlib -ldruntime-ldc-shared)
