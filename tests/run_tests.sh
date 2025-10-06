#!/bin/bash

# Simple test runner script for qmlPrayerTimes
# This script can be used in CI environments

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Building qmlPrayerTimes with tests...${NC}"

# Configure
cmake -B build -S . \
    -DCMAKE_BUILD_TYPE=Release \
    -DQt6_DIR=/Users/saif/Qt/6.10.0/macos/lib/cmake/Qt6

# Build
cmake --build build --parallel $(sysctl -n hw.ncpu)

echo -e "${YELLOW}Running tests...${NC}"

# Run tests with CTest
cd build
export QT_QPA_PLATFORM=offscreen
ctest --output-on-failure --verbose

# Check result
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed${NC}"
    exit 1
fi
