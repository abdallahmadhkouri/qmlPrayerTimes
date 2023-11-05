cmake_minimum_required(VERSION 3.24)

project(qmlPrayerTimes VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.6)

set_source_files_properties(PrayTimesController.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

qt6_add_library(prayerTimesModule STATIC)
qt6_add_qml_module(prayerTimesModule
    URI qmlPrayerTimes
    # ENABLE_TYPE_COMPILER
    VERSION 1.0
    QML_FILES
        PrayerTimes.qml
        PrayTimesController.qml
)

add_subdirectory(httpservices)
target_link_libraries(prayerTimesModule PRIVATE
    httpServicesModuleplugin
)

#set(targetName prayerTimesTester)

#qt_add_executable(${targetName}
#    main.cpp)

#qt6_add_qml_module(${targetName}
#    URI tester
#    VERSION 1.0
#    QML_FILES Main.qml
#)

#set_target_properties(${targetName} PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
#    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
#    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
#    MACOSX_BUNDLE TRUE
#    WIN32_EXECUTABLE TRUE
#)

#target_link_libraries(${targetName} PRIVATE Qt6::Quick)
#target_link_libraries(${targetName} PRIVATE
#    prayerTimesModuleplugin
#)

#install(TARGETS ${targetName}
#    BUNDLE DESTINATION .
#    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

#if(QT_VERSION_MAJOR GREATER_EQUAL 6)
#    qt_import_qml_plugins(${PROJECT_NAME})
#    qt_finalize_target(${PROJECT_NAME})
#endif()
