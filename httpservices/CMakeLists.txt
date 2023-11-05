find_package(Qt6 6.6 REQUIRED COMPONENTS Quick Core)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
qt_standard_project_setup(REQUIRES 6.6)

set_source_files_properties(Http.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)
qt6_add_library(httpServicesModule STATIC)
qt6_add_qml_module(httpServicesModule
    URI httpservices
    ENABLE_TYPE_COMPILER
#    RESOURCE_PREFIX /momoslab/imports
    VERSION 1.0
    QML_FILES
        Http.qml
)
