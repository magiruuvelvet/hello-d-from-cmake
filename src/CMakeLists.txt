CreateTarget(hellolib_cxx STATIC hellolib_cxx C++ 14)
CreateTarget(hellolib_c STATIC hellolib_c C 11)
CreateTarget(hello EXECUTABLE hello D 2)

d_define_version(hello PRIVATE "MyFeature_Enabled")

d_install_injectors(hello)

# since D has no preprocessor macros, the only way to get in build-system
# known and configured values is using `configure_file`, really sad
set(CUSTOM_VALUE_FROM_CMAKE "build system configured value")
ProjectConfigureFile(hello "features.d")

target_link_libraries(hello
    PUBLIC "c++"
    PRIVATE hellolib_cxx hellolib_c libs::cerealed
)

set(ENABLE_TESTING OFF CACHE BOOL "Build unit tests as separate binary.")
if (ENABLE_TESTING)
    # this is a mess, but when writing libraries
    # unit testing in D is as easy as creating a executable target
    # and compiling it with the -unittest argument
    # no separate unit testing framework required as in C++
    CreateTarget(hello-tests EXECUTABLE hello-tests D 2)
    d_define_version(hello-tests PRIVATE "MyFeature_Enabled")
    d_install_injectors(hello-tests)
    target_sources(hello-tests PRIVATE "${PROJECT_GENERATED_DIR}/features.d")
    target_compile_options(hello-tests PRIVATE "-unittest")
    target_link_libraries(hello-tests
        PUBLIC "c++"
        PRIVATE hellolib_cxx hellolib_c libs::cerealed
    )
endif()
