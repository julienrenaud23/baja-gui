cmake_minimum_required(VERSION 3.16)

project(dashbee VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
SET(CMAKE_PREFIX_PATH "D:\\Qt\\6.10.0\\mingw_64\\")

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appdashbee
    main.cpp
)

qt_add_qml_module(appdashbee
    URI dashbee
    QML_FILES
        Main.qml
        QML_FILES Constants.js
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appdashbee PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appdashbee
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appdashbee
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appdashbee
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
