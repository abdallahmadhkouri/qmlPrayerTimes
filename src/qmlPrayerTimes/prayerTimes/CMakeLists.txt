cmake_minimum_required(VERSION 3.1)
project(prayertimes)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 COMPONENTS Core REQUIRED)

add_library(prayertimes SHARED
    prayertimes.hpp
    prayertimeswrapper.h
    prayertimeswrapper.cpp
)

target_link_libraries(prayertimes PRIVATE Qt6::Core)