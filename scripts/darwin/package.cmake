if(NOT APPLE)
    return()
endif()

# See build.sh and src/cmake/Darwin.cmake
set(CPACK_GENERATOR External)
message(STATUS "MACDEPLOYQT_EXECUTABLE package-cmake.pre ${MACDEPLOYQT_EXECUTABLE}")
message(STATUS "CMAKE_SYSTEM_PROCESSOR:       ${CMAKE_SYSTEM_PROCESSOR}")

if(NOT "${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "arm64")
    get_target_property(MOC_LOCATION ${QT_PREFIX}::moc LOCATION)
    get_filename_component(MACDEPLOYQT_EXECUTABLE ${MOC_LOCATION}/../macdeployqt ABSOLUTE)
    message(STATUS "MACDEPLOYQT_EXECUTABLE x86 package-cmake ${MACDEPLOYQT_EXECUTABLE}")
else()
    message(STATUS "MACDEPLOYQT_EXECUTABLE arm64 package-cmake ${MACDEPLOYQT_EXECUTABLE}")
endif()

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/scripts/darwin/macdeployqt.cmake.in" "${CMAKE_BINARY_DIR}/macdeployqt.cmake" @ONLY)

set(CPACK_EXTERNAL_PACKAGE_SCRIPT "${CMAKE_BINARY_DIR}/macdeployqt.cmake")

# Must be last
include(CPack)
