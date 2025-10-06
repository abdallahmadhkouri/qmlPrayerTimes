cmake_minimum_required(VERSION 3.16)

project(qmlPrayerTimes VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Qml QuickTest)

qt_standard_project_setup(REQUIRES 6.6)

add_subdirectory(src)

# Enable testing
enable_testing()

# Define the source directory for test discovery
# The test harness scans this directory recursively for "tst_*.qml" files
add_definitions(-DQUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}/tests")

# Create the test executable
# Adding QML test files here makes them visible in Qt Creator
add_executable(tst_qmlPrayerTimes
    tests/tst_qmlPrayerTimes.cpp
    tests/tst_PrayerTimesWidget.qml
)

# Mark QML files as header files so they don't get compiled
set_source_files_properties(
    tests/tst_PrayerTimesWidget.qml
    PROPERTIES HEADER_FILE_ONLY TRUE
)

# Link against Qt testing libraries and the prayer times module
target_link_libraries(tst_qmlPrayerTimes
    PRIVATE
    Qt6::QuickTest
    Qt6::Qml
    prayerTimesModuleplugin
)

# Register the test with CTest
add_test(NAME tst_qmlPrayerTimes COMMAND tst_qmlPrayerTimes)

# Set the QML import path so tests can find the module
# The module is built in src/qmlPrayerTimes within the qmlPrayerTimes build directory
set_tests_properties(tst_qmlPrayerTimes PROPERTIES
    ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_CURRENT_BINARY_DIR}/src/qmlPrayerTimes"
)
