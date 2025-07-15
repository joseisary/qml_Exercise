cmake_minimum_required(VERSION 3.16)

project(battery VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appbattery
    main.cpp
)

qt_add_qml_module(appbattery
    URI battery
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES Battery_v1.qml
        QML_FILES Battery_v2.qml
        SOURCES iobattery.h iobattery.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appbattery PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appbattery
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appbattery
    PRIVATE Qt6::Quick
)
target_link_libraries(appbattery PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS appbattery
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
