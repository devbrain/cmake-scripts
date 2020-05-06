macro(onyx_setup_conan)
  if(CONAN_EXPORTED) # in conan local cache
    set (CONANBUILDINFO_FILE "${CMAKE_BINARY_DIR}/../conanbuildinfo.cmake")
    include(${CONANBUILDINFO_FILE})
  else()
    if(NOT EXISTS "${CMAKE_SOURCE_DIR}/cmake/conan/conan.cmake")
      if (NOT EXISTS ${CMAKE_BINARY_DIR}/conan.cmake)
	message(STATUS "Downloading conan.cmake from https://github.com/memsharded/cmake-conan")
	file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/master/conan.cmake"
	  "${CMAKE_BINARY_DIR}/conan.cmake"
	  SHOW_PROGRESS STATUS status)
	message(STATUS "Download status = ${status}")
      else ()
	message (STATUS "Using existing ${CMAKE_BINARY_DIR}/conan.cmake")
      endif ()
      include(${CMAKE_BINARY_DIR}/conan.cmake)
    else()
      include(${CMAKE_SOURCE_DIR}/cmake/conan/conan.cmake)
    endif()
    
    conan_cmake_run(
      ${ARGN}
      IMPORTS
      "bin, *.dll -> bin"
      "lib, *.dylib -> bin"
      "lib, *.so -> bin"
      GENERATORS cmake_find_package
      BUILD missing
      BASIC_SETUP
      
      )
    conan_load_buildinfo ()
  endif()
endmacro()
