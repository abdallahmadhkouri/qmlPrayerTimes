import QtQuick
import QtQuick.Layouts
import qmlPrayerTimes

Item {
    id: prayerTimes

    property string city
    property int daysToNextEvent
    property int fontSize: 13
    //    property string country
    property string latitude
    property string longitude
    property bool nextEventRamdan: false
    property int rowSpacing: width / 4

    signal cityLatLngChanged

    function initialFetch() {
        if (latitude != "" && longitude != "") {
            PrayTimesController.requestAladhanAPI(latitude, longitude);
        } else {
            prayTimesTxt0.text = "-";
            prayTimesTxt1.text = "-";
            prayTimesTxt2.text = "-";
            prayTimesTxt3.text = "-";
            prayTimesTxt4.text = "-";
            prayTimesTxt5.text = "-";
        }
    }

    onLatitudeChanged: initialFetch()
    onLongitudeChanged: initialFetch()

    Connections {
        function onStartTimer() {
            timeUpdater.start();
            prayTimesTxt0.text = PrayTimesController.prayTimes[0].times;
            prayTimesTxt1.text = PrayTimesController.prayTimes[1].times;
            prayTimesTxt2.text = PrayTimesController.prayTimes[2].times;
            prayTimesTxt3.text = PrayTimesController.prayTimes[3].times;
            prayTimesTxt4.text = PrayTimesController.prayTimes[4].times;
            prayTimesTxt5.text = PrayTimesController.prayTimes[5].times;
        }

        target: PrayTimesController
    }
    Column {
        id: prayersTimesColumn

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: height * 0.25

        Text {
            color: "white"
            font.pixelSize: 12
            style: Text.Outline
            styleColor: "black"
            text: PrayTimesController.prayTimes[PrayTimesController.nextPrayerTime].name + " in:" //  "next prayer"
        }
        Text {
            id: nextPrayerTxt

            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            font.pixelSize: 27
            style: Text.Outline
            styleColor: "black"
            text: "%1:%2:%3".arg(("0" + PrayTimesController.rhours).slice(-2)).arg(("0" + PrayTimesController.rminutes).slice(-2)).arg(("0" + PrayTimesController.rsecondes).slice(-2))
        }
        Text {
            id: hijriDate

            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            font.pixelSize: prayerTimes.fontSize
            style: Text.Outline
            styleColor: "black"
            //            width: parent.width
            text: PrayTimesController.hijriDate
        }
        RowLayout {
            spacing: prayerTimes.rowSpacing
            width: parent.width//160

            Text {
                Layout.fillWidth: true
                color: "white"
                font.pixelSize: 15
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                //                    text: modelData['name']
                text: PrayTimesController.prayTimes[0].name
            }
            Text {
                id: prayTimesTxt0

                Layout.preferredWidth: 60
                color: "white"
                font.pixelSize: 15
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                //                    text: modelData['times']
                text: PrayTimesController.prayTimes[0].times
            }
        }
        RowLayout {
            spacing: prayerTimes.rowSpacing
            width: parent.width//160

            Text {
                Layout.fillWidth: true
                color: "white"
                font.pixelSize: 15
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                //                    text: modelData['name']
                text: PrayTimesController.prayTimes[1].name
            }
            Text {
                id: prayTimesTxt1

                Layout.preferredWidth: 60
                color: "white"
                font.pixelSize: 15
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                //                    text: modelData['times']
                text: PrayTimesController.prayTimes[1].times
            }
        }
        RowLayout {
            spacing: prayerTimes.rowSpacing
            width: parent.width//160

            Text {
                Layout.fillWidth: true
                color: "white"
                font.pixelSize: 15
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                //                    text: modelData['name']
                text: PrayTimesController.prayTimes[2].name
            }
            Text {
                id: prayTimesTxt2

                Layout.preferredWidth: 60
                color: "white"
                font.pixelSize: 15
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                //                    text: modelData['times']
                text: PrayTimesController.prayTimes[2].times
            }
        }
        RowLayout {
            spacing: prayerTimes.rowSpacing
            width: parent.width//160

            Text {
                Layout.fillWidth: true
                color: "white"
                font.pixelSize: 15
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                //                    text: modelData['name']
                text: PrayTimesController.prayTimes[3].name
            }
            Text {
                id: prayTimesTxt3

                Layout.preferredWidth: 60
                color: "white"
                font.pixelSize: 15
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                //                    text: modelData['times']
                text: PrayTimesController.prayTimes[3].times
            }
        }
        RowLayout {
            spacing: prayerTimes.rowSpacing
            width: parent.width//160

            Text {
                Layout.fillWidth: true
                color: "white"
                font.pixelSize: 15
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                //                    text: modelData['name']
                text: PrayTimesController.prayTimes[4].name
            }
            Text {
                id: prayTimesTxt4

                Layout.preferredWidth: 60
                color: "white"
                font.pixelSize: 15
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                //                    text: modelData['times']
                text: PrayTimesController.prayTimes[4].times
            }
        }
        RowLayout {
            spacing: prayerTimes.rowSpacing
            width: parent.width//160

            Text {
                Layout.fillWidth: true
                color: "white"
                font.pixelSize: 15
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                //                    text: modelData['name']
                text: PrayTimesController.prayTimes[5].name
            }
            Text {
                id: prayTimesTxt5

                Layout.preferredWidth: 60
                color: "white"
                font.pixelSize: 15
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                //                    text: modelData['times']
                text: PrayTimesController.prayTimes[5].times
            }
        }
    }

    //    Row {
    //        id: remainingDaysRow
    //        visible: nextEventRamdan
    //        anchors.top: prayersTimesColumn.bottom
    //        anchors.topMargin: 7
    //        anchors.right: prayersTimesColumn.right
    //        spacing: prayerTimes.rowSpacing
    //        Text {
    //            id: remainingDays
    //            font.pixelSize: 15
    //            font.bold: true
    //            color: "white"
    //            style: Text.Outline
    //            styleColor: "green"
    //        }
    //        Text {
    //            id: remainingDaysTxt
    //            font.pixelSize: 15
    //            font.bold: true
    //            color: "white"
    //            style: Text.Outline
    //            styleColor: "green"
    //        }
    //    }

    Timer {
        id: timeUpdater

        interval: 1000
        repeat: true
        running: false

        onTriggered: PrayTimesController.calculateNextPrayerTime()
    }
}
