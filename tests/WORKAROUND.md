# Compiler Crash Workaround

## Issue
The AppleClang 12.0.5 compiler is crashing when building the QML type registration code. This is a known issue with older Xcode Command Line Tools and Qt 6.8+.

## Workaround: Test Using Qt's qmlscene/qml Tool

Since Qt Creator works fine, you can run tests directly using Qt's qml tool without building the C++ test harness:

### Option 1: Run Individual QML Tests with qml

```bash
# Use Qt's qml tool to load and run tests
/Users/saif/Qt/6.8.0/macos/bin/qml tests/tst_PrayerTimes.qml
/Users/saif/Qt/6.8.0/macos/bin/qml tests/tst_PrayTimesController.qml
/Users/saif/Qt/6.8.0/macos/bin/qml tests/tst_HttpService.qml
```

### Option 2: Create Simple Test Runner QML

Create a file `tests/TestRunner.qml`:

```qml
import QtQuick
import QtTest

Item {
    id: testRunner

    TestCase {
        name: "Loading Tests"
        function initTestCase() {
            console.log("Test suite initialized")
        }
    }

    Loader {
        id: testLoader
        source: Qt.application.arguments[1] || "tst_PrayerTimes.qml"
    }
}
```

Run with:
```bash
/Users/saif/Qt/6.8.0/macos/bin/qml tests/TestRunner.qml tests/tst_PrayerTimes.qml
```

### Option 3: Use Qt Creator's Test Integration

1. Open qmlPrayerTimes project in Qt Creator
2. Go to Tools → Tests
3. Qt Creator will automatically discover QML test files
4. Run tests directly from the IDE

### Option 4: Build from Qt Creator

Qt Creator likely uses a different compiler configuration. To build tests:

1. Open `/Users/saif/Documents/git/momosLabs/momoslauncher/qmlPrayerTimes/CMakeLists.txt` in Qt Creator
2. Configure with Qt 6.8
3. Build the project
4. Run tests from the test panel

## For CI: Use Docker with Proper Toolchain

```dockerfile
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    clang-14

# Install Qt (use aqtinstall)
RUN pip3 install aqtinstall
RUN aqt install-qt linux desktop 6.8.0 gcc_64

# Build and test
WORKDIR /app
COPY . .
RUN cmake -B build -S qmlPrayerTimes -DCMAKE_CXX_COMPILER=clang++-14
RUN cmake --build build
RUN cd build && ctest --output-on-failure
```

## Permanent Fix

Upgrade your development tools:

```bash
# Option 1: Install Xcode from App Store (free)
# Then set it as active developer directory:
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# Option 2: Update Command Line Tools
softwareupdate --list
softwareupdate --install "Command Line Tools for Xcode-<version>"
```

After upgrading, the normal CMake build should work:

```bash
cd qmlPrayerTimes
cmake -B build -S . -DCMAKE_PREFIX_PATH=/Users/saif/Qt/6.8.0/macos
cmake --build build
cd build && ctest --output-on-failure
```
