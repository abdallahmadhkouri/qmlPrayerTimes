import QtQuick
import QtQuick.Layouts
import qmlPrayerTimes

Item {
    id: prayerTimes

    property string city
    //    property string country
    property string latitude
    property string longitude

    property var times: []
    property int daysToNextEvent
    property bool nextEventRamdan: false

    property int fontSize: 13
    property int rowSpacing: width / 4

    signal cityLatLngChanged


    function initialFetch()
    {
        if(latitude != "" && longitude !="")
        {
            PrayTimesController.requestAladhanAPI(latitude, longitude)
        }
        else{
            prayTimesTxt0.text = "-"
            prayTimesTxt1.text = "-"
            prayTimesTxt2.text = "-"
            prayTimesTxt3.text = "-"
            prayTimesTxt4.text = "-"
            prayTimesTxt5.text = "-"
        }
    }

    onLatitudeChanged: initialFetch()
    onLongitudeChanged: initialFetch()

    Connections {
        target: PrayTimesController
        function onStartTimer() {
            timeUpdater.start()
            prayTimesTxt0.text = PrayTimesController.prayTimes[0].times
            prayTimesTxt1.text = PrayTimesController.prayTimes[1].times
            prayTimesTxt2.text = PrayTimesController.prayTimes[2].times
            prayTimesTxt3.text = PrayTimesController.prayTimes[3].times
            prayTimesTxt4.text = PrayTimesController.prayTimes[4].times
            prayTimesTxt5.text = PrayTimesController.prayTimes[5].times
        }
    }

    Column {
        id: prayersTimesColumn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: height * 0.25

        Text {
            text: PrayTimesController.prayTimes[PrayTimesController.nextPrayerTime].name + " in:" //  "next prayer"
            font.pixelSize: 12
            color: "white"
            style: Text.Outline
            styleColor: "black"
        }

        Text {
            id: nextPrayerTxt
            text: "%1:%2:%3".arg(("0" + PrayTimesController.rhours).slice(-2)).arg(("0" + PrayTimesController.rminutes).slice(-2)).arg(("0" + PrayTimesController.rsecondes).slice(-2))
            font.pixelSize: 27
            color: "white"
            style: Text.Outline
            styleColor: "black"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            id: hijriDate
            //            width: parent.width
            text: PrayTimesController.hijriDate
            font.pixelSize: fontSize
            color: "white"
            style: Text.Outline
            styleColor: "black"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        RowLayout {
            width: parent.width//160
            spacing: rowSpacing
            Text {
                //                    text: modelData['name']
                text: PrayTimesController.prayTimes[0].name
                font.pixelSize: 15
                color: "white"
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                Layout.fillWidth: true
            }
            Text {
                id: prayTimesTxt0
                //                    text: modelData['times']
                text: PrayTimesController.prayTimes[0].times
                font.pixelSize: 15
                color: "white"
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                Layout.preferredWidth: 60
            }
        }
        RowLayout {
            width: parent.width//160
            spacing: rowSpacing
            Text {
                //                    text: modelData['name']
                text: PrayTimesController.prayTimes[1].name
                font.pixelSize: 15
                color: "white"
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                Layout.fillWidth: true
            }
            Text {
                id: prayTimesTxt1
                //                    text: modelData['times']
                text: PrayTimesController.prayTimes[1].times
                font.pixelSize: 15
                color: "white"
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                Layout.preferredWidth: 60
            }
        }
        RowLayout {
            width: parent.width//160
            spacing: rowSpacing
            Text {
                //                    text: modelData['name']
                text: PrayTimesController.prayTimes[2].name
                font.pixelSize: 15
                color: "white"
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                Layout.fillWidth: true
            }
            Text {
                id: prayTimesTxt2
                //                    text: modelData['times']
                text: PrayTimesController.prayTimes[2].times
                font.pixelSize: 15
                color: "white"
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                Layout.preferredWidth: 60
            }
        }
        RowLayout {
            width: parent.width//160
            spacing: rowSpacing
            Text {
                //                    text: modelData['name']
                text: PrayTimesController.prayTimes[3].name
                font.pixelSize: 15
                color: "white"
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                Layout.fillWidth: true
            }
            Text {
                id: prayTimesTxt3
                //                    text: modelData['times']
                text: PrayTimesController.prayTimes[3].times
                font.pixelSize: 15
                color: "white"
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                Layout.preferredWidth: 60
            }
        }
        RowLayout {
            width: parent.width//160
            spacing: rowSpacing
            Text {
                //                    text: modelData['name']
                text: PrayTimesController.prayTimes[4].name
                font.pixelSize: 15
                color: "white"
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                Layout.fillWidth: true
            }
            Text {
                id: prayTimesTxt4
                //                    text: modelData['times']
                text: PrayTimesController.prayTimes[4].times
                font.pixelSize: 15
                color: "white"
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                Layout.preferredWidth: 60
            }
        }
        RowLayout {
            width: parent.width//160
            spacing: rowSpacing
            Text {
                //                    text: modelData['name']
                text: PrayTimesController.prayTimes[5].name
                font.pixelSize: 15
                color: "white"
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                Layout.fillWidth: true
            }
            Text {
                id: prayTimesTxt5
                //                    text: modelData['times']
                text: PrayTimesController.prayTimes[5].times
                font.pixelSize: 15
                color: "white"
                //                    color: index === PrayTimesController.nextPrayerTime ? "lightgreen" : "white"
                style: Text.Outline
                styleColor: "black"
                Layout.preferredWidth: 60
            }
        }

    }

    //    Row {
    //        id: remainingDaysRow
    //        visible: nextEventRamdan
    //        anchors.top: prayersTimesColumn.bottom
    //        anchors.topMargin: 7
    //        anchors.right: prayersTimesColumn.right
    //        spacing: rowSpacing
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
        running: false
        repeat: true
        onTriggered: PrayTimesController.calculateNextPrayerTime()
    }
}
