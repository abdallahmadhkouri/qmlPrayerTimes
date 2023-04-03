import QtQuick
import QtQuick.Window
//import untitled1
import qmlPrayerTimes

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    PrayerTimes {
        anchors.centerIn: parent
        id: prayTimeWidget
        //        city: "montigny le bretonneux"
        latitude: "48.7739"
        longitude: "2.0360"
    }
}
