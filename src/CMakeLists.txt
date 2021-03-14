CreateTarget(hellolib_cxx STATIC hellolib_cxx C++ 14)
CreateTarget(hellolib_c STATIC hellolib_c C 11)
CreateTarget(hello EXECUTABLE hello D 2)

d_define_version(hello PRIVATE "MyFeature_Enabled")

# since D has no preprocessor macros, the only way to get in build-system
# known and configured values is using `configure_file`, really sad
set(CUSTOM_VALUE_FROM_CMAKE "build system configured value")
ProjectConfigureFile(hello "features.d")

target_link_libraries(hello
    PUBLIC "c++"
    PRIVATE hellolib_cxx hellolib_c libs::cerealed
)
