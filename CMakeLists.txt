cmake_minimum_required(VERSION 3.16)

project(ics_keygen VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appics_keygen
    keygenerator.h keygenerator.cpp
    main.cpp
)

qt_add_qml_module(appics_keygen
    URI ics_keygen
    VERSION 1.0
    QML_FILES Main.qml
)

set_target_properties(appics_keygen PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appics_keygen
    PRIVATE Qt6::Quick
)

install(TARGETS appics_keygen
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
