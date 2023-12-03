set_source_files_properties(PrayTimesController.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)
set_source_files_properties(Http.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

qt_add_library(prayerTimesModule STATIC)
qt_add_qml_module(prayerTimesModule
    URI qmlPrayerTimes
    # ENABLE_TYPE_COMPILER
    VERSION 1.0
    QML_FILES
        PrayerTimes.qml
        PrayTimesController.qml
        Http.qml
)
