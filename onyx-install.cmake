# ==================================================================
# Installation
# ==================================================================
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

macro(onyx_install_package)
  set(options)
  set(oneValueArgs PACKAGE_NAME CONFIG_FILE NAMESPACE)
  set(multiValueArgs TARGETS)
  cmake_parse_arguments(ONYX_INSTALL "${options}" "${oneValueArgs}"
    "${multiValueArgs}" ${ARGN} )
  


  if(CONAN_EXPORTED)
    set(ARCHIVE_DESTINATION ${CMAKE_INSTALL_LIBDIR})
    set(LIBRARY_DESTINATION ${CMAKE_INSTALL_LIBDIR})
    set(RUNTIME_DESTINATION ${CMAKE_INSTALL_BINDIR})
    set(INCLUDES_DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
  else()
    set(ARCHIVE_DESTINATION ${CMAKE_INSTALL_LIBDIR}/${CMAKE_BUILD_TYPE})
    set(LIBRARY_DESTINATION ${CMAKE_INSTALL_LIBDIR}/${CMAKE_BUILD_TYPE})
    set(RUNTIME_DESTINATION ${CMAKE_INSTALL_BINDIR}/${CMAKE_BUILD_TYPE})
    set(INCLUDES_DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
  endif()


  install (TARGETS ${ONYX_INSTALL_TARGETS}
    EXPORT ${ONYX_INSTALL_PACKAGE_NAME}-targets
    ARCHIVE DESTINATION ${ARCHIVE_DESTINATION}
    LIBRARY DESTINATION ${LIBRARY_DESTINATION}
    RUNTIME DESTINATION ${RUNTIME_DESTINATION}
    INCLUDES DESTINATION ${INCLUDES_DESTINATION}
    )
      
  set(INSTALL_CONFIGDIR ${CMAKE_INSTALL_LIBDIR}/cmake/${ONYX_INSTALL_PACKAGE_NAME})

  install(EXPORT ${ONYX_INSTALL_PACKAGE_NAME}-targets
    FILE ${ONYX_INSTALL_PACKAGE_NAME}-targets.cmake
    NAMESPACE ${ONYX_INSTALL_NAMESPACE}::
    DESTINATION ${INSTALL_CONFIGDIR})

  


  write_basic_package_version_file(
    ${CMAKE_BINARY_DIR}/cmake/${ONYX_INSTALL_PACKAGE_NAME}-config-version.cmake
    VERSION ${VERSION}
    COMPATIBILITY AnyNewerVersion
    )

  configure_package_config_file(
    ${ONYX_INSTALL_CONFIG_FILE}
    ${CMAKE_BINARY_DIR}/cmake/${ONYX_INSTALL_PACKAGE_NAME}-config.cmake
    INSTALL_DESTINATION ${INSTALL_CONFIGDIR}
    )

  install(
    FILES
    ${CMAKE_BINARY_DIR}/cmake/${ONYX_INSTALL_PACKAGE_NAME}-config.cmake
    ${CMAKE_BINARY_DIR}/cmake/${ONYX_INSTALL_PACKAGE_NAME}-config-version.cmake
    DESTINATION ${INSTALL_CONFIGDIR}
    )

  export(EXPORT ${ONYX_INSTALL_PACKAGE_NAME}-targets
    FILE ${CMAKE_BINARY_DIR}/cmake/${ONYX_INSTALL_PACKAGE_NAME}-targets.cmake
    NAMESPACE ${ONYX_INSTALL_NAMESPACE}::
    )
  
  export(PACKAGE ${ONYX_INSTALL_PACKAGE_NAME})
endmacro()
