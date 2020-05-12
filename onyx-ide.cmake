string(COMPARE EQUAL "${CMAKE_CFG_INTDIR}" "." ONYX_IS_SINGLE_CONFIGURATION)

# Organize unrelated targets to clean IDE hierarchy.
set(COMMANDS_FOLDER "COMMANDS")

# This will also clean up the CMake ALL_BUILD, INSTALL, RUN_TESTS and ZERO_CHECK projects.
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_property(GLOBAL PROPERTY PREDEFINED_TARGETS_FOLDER ${COMMANDS_FOLDER})
