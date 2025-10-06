# qmlPrayerTimes Tests

Modern Qt Quick Test suite for the qmlPrayerTimes widget module, following the official Qt Quick Test documentation.

## Overview

This test suite uses Qt Quick Test framework to test the QML components and indirectly cover C++ code if present. The tests are integrated into the main CMakeLists.txt following Qt best practices from https://doc.qt.io/qt-6/qtquicktest-index.html.

## Test Files

- **tst_qmlPrayerTimes.cpp** - Test harness with setup/cleanup hooks (uses QUICK_TEST_MAIN_WITH_SETUP)
- **tst_PrayerTimes.qml** - Tests for the main PrayerTimes widget component
- **tst_PrayTimesController.qml** - Tests for the PrayTimesController singleton
- **tst_HttpService.qml** - Tests for the Http service singleton

## Building and Running Tests

### From Qt Creator (Recommended)

1. Open the main momoslauncher project in Qt Creator
2. Build the project (this builds the module and tests)
3. Run tests from: `Projects → Auto Test` or use the test panel
4. Or run: `Build → Run CTest`

### From Command Line

When building from the main launcher project:

```bash
cd /path/to/momoslauncher
cmake --build build/Qt_6_10_0_for_macOS-Debug --target tst_qmlPrayerTimes
```

### Run Tests with CTest

```bash
cd build/Qt_6_10_0_for_macOS-Debug/qmlPrayerTimes
ctest --output-on-failure
```

### Run Tests Directly

```bash
cd build/Qt_6_10_0_for_macOS-Debug/qmlPrayerTimes
./tst_qmlPrayerTimes
```

### Run Tests in Headless Mode (for CI)

```bash
./tst_qmlPrayerTimes -platform offscreen
```

## Test Options

### Run Specific Test Function

```bash
./tst_qmlPrayerTimes PrayerTimesTests::test_initialState
```

### List All Test Functions

```bash
./tst_qmlPrayerTimes -functions
```

### Run with Specific Input Directory

```bash
./tst_qmlPrayerTimes -input /path/to/tests
```

### Get Help

```bash
./tst_qmlPrayerTimes -help
```

## CI Integration

### GitHub Actions Example

```yaml
- name: Run Qt Quick Tests
  run: |
    cd qmlPrayerTimes/build
    ctest --output-on-failure
  env:
    QT_QPA_PLATFORM: offscreen
```

### GitLab CI Example

```yaml
test:
  script:
    - cd qmlPrayerTimes
    - cmake -B build -S .
    - cmake --build build
    - cd build
    - ctest --output-on-failure
  variables:
    QT_QPA_PLATFORM: offscreen
```

## Test Coverage

The test suite covers:

1. **Component Initialization** - Verify default properties and initial state
2. **Property Bindings** - Test property setters and getters
3. **UI Elements** - Verify presence and structure of UI components
4. **Business Logic** - Test prayer time calculations and data processing
5. **Signal/Slot Connections** - Verify signal emissions and connections
6. **Data Structures** - Test prayer times array and data formats

## Mocking Network Requests

For CI environments, you may want to mock HTTP responses to avoid network dependencies:

1. Create mock response files in `tests/mock/` directory
2. Override the Http singleton's request function in test setup
3. Use QML test data or SignalSpy for async operation testing

## Extending Tests

To add new test cases:

1. Create a new `tst_YourComponent.qml` file in the tests directory
2. Import required modules: `import QtTest` and `import qmlPrayerTimes`
3. Create a TestCase component with your test functions
4. Test functions must start with `test_` prefix
5. Rebuild and run tests

Example:

```qml
import QtQuick
import QtTest
import qmlPrayerTimes

TestCase {
    name: "MyNewTests"

    function test_myFeature() {
        compare(1 + 1, 2)
    }
}
```

## Troubleshooting

### Tests Not Found

- Ensure test files start with `tst_*.qml`
- Check that QUICK_TEST_SOURCE_DIR is set correctly
- Verify QML_IMPORT_PATH includes the build directory

### Module Import Errors

- Confirm the prayerTimesModule is built before tests
- Check that the plugin library is linked correctly
- Verify qmldir file exists in the module directory

### Display Issues in CI

- Use `-platform offscreen` flag
- Set environment variable: `QT_QPA_PLATFORM=offscreen`
- Ensure Qt platform plugins are available

## Best Practices

1. **Keep tests independent** - Each test should be able to run in isolation
2. **Use init() and cleanup()** - Reset state between tests
3. **Test behavior, not implementation** - Focus on observable outcomes
4. **Use descriptive test names** - Make test purpose clear from name
5. **Avoid network calls** - Mock external dependencies for reliable tests
6. **Test edge cases** - Include boundary conditions and error scenarios
