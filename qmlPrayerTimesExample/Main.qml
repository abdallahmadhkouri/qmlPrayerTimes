import QtQuick
import QtQuick.Window
import qmlPrayerTimes

Window {
    color: "orange"
    height: 480
    title: qsTr("Hello World")
    visible: true
    width: 640

    PrayerTimes {
        id: prayTimeWidget

        anchors.centerIn: parent
        latitude: "32.8872"
        longitude: "13.1913"
    }
}
