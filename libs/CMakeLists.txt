CreateTargetFromPath(concepts "concepts/source" STATIC "libconcepts" D 2)
CreateTargetFromPath(cerealed "cerealed/src" STATIC "libcerealed" D 2)

target_link_libraries(cerealed PUBLIC libs::concepts)
