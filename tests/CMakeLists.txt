# unit testing framework
CreateTargetFromPath(tests-undead "undead/src" STATIC "tests-undead" D 2)
CreateTargetFromPath(tests-dunit "dunit/src" STATIC "tests-dunit" D 2)
target_link_libraries(tests-dunit PUBLIC libs::tests-undead)

# unit tests
CreateTargetFromPath(tests "tests" EXECUTABLE "tests" D 2)
target_link_libraries(tests PUBLIC libs::tests-dunit)

set(TESTS_ASSET_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/assets/")
ProjectConfigureFile(tests "tests/config.d")
