import QtQuick
import QtQuick.Window
//import untitled1
import qmlPrayerTimes

Window {
    height: 480
    title: qsTr("Hello World")
    visible: true
    width: 640

    PrayerTimes {
        id: prayTimeWidget

        anchors.centerIn: parent
        //        city: "montigny le bretonneux"
        latitude: "48.7739"
        longitude: "2.0360"
    }
}
