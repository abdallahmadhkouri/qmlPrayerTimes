cmake_minimum_required(VERSION 3.16)

project(qmlPrayerTimesExample VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appqmlPrayerTimesExample
    main.cpp
)

qt_add_qml_module(appqmlPrayerTimesExample
    URI qmlPrayerTimesExample
    VERSION 1.0
    QML_FILES Main.qml
)
#target_link_libraries(${targetName}
#    PRIVATE Qt6::Quick
#)

add_subdirectory(../src ../build-qmlPrayerTimes)

target_link_libraries(appqmlPrayerTimesExample PRIVATE
    prayerTimesModuleplugin
)

#set_target_properties(appqmlPrayerTimesExample PROPERTIES
#    QT_QMLCACHEGEN_ARGUMENTS "--verbose"
#)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appqmlPrayerTimesExample PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appqmlPrayerTimesExample
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appqmlPrayerTimesExample
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appqmlPrayerTimesExample
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
