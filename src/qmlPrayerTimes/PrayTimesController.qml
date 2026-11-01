pragma Singleton
import QtQuick
import qmlPrayerTimes

Item {
    id: control

    property string aladhanBase: "https://api.aladhan.com/v1/timingsByCity"
    // One day, by date, at the coordinates: no month array to index into, and no
    // redirect to follow (the bare /v1/calendar path answers 302 into /YYYY/MM).
    property string aladhanBaseGps: "https://api.aladhan.com/v1/timings/%1?latitude=%2&longitude=%3&method=4"
    property string hijriDate
    property int nextPrayerTime: -1
    property variant prayTimes: [{
            "name": "Fajr",
            "times": ""
        }, {
            "name": "Sunrise",
            "times": ""
        }, {
            "name": "Dhuhr",
            "times": ""
        }, {
            "name": "Asr",
            "times": ""
        }, {
            "name": "Maghrib",
            "times": ""
        }, {
            "name": "Isha",
            "times": ""
        }]
    property string prayertimesBase: "https://api.pray.zone/v2/times/today.json"
    property int rhours: 0
    property int rminutes: 0
    property int rsecondes: 0

    signal startTimer

    function calculateNextPrayerTime() {
        let currentDate = new Date();
        let currentTime = currentDate.getTime();
        let r = remaindTime(currentTime);
        rhours = r[0];
        rminutes = r[1];
        if (rhours == 0 && rminutes == 0) {
            r = remaindTime(currentTime, 1);
        }
        rhours = r[0];
        rminutes = r[1];
        rsecondes = r[2];
    }
    function remaindTime(currentTime: date, day = 0) {
        for (let i = 0; i < prayTimes.length; i++) {
            let d = prayTimes[i]["times"].split(":");
            let date = new Date();
            date = new Date(date.setHours(parseInt(d[0])));
            date = new Date(date.setMinutes(parseInt(d[1])));
            date = new Date(date.setSeconds(0));
            if (day !== 0) {
                date = new Date(date.setDate(date.getDate() + 1));
            }
            let time = date.getTime();
            if (currentTime < time) {
                nextPrayerTime = i;
                let timeleft = time - currentTime;
                let hours = Math.floor((timeleft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                let minutes = Math.floor((timeleft % (1000 * 60 * 60)) / (1000 * 60));
                let secondes = Math.floor((timeleft % (1000 * 60)) / 1000);
                return [hours, minutes, secondes];
            }
        }
        return [0, 0, 0];
    }
    function aladhanDateString() {
        let now = new Date();
        let day = ("0" + now.getDate()).slice(-2);
        let month = ("0" + (now.getMonth() + 1)).slice(-2);
        return day + "-" + month + "-" + now.getFullYear();
    }
    function requestAladhanAPI(latitude: string, longitude: string): void {
        if (!latitude || !longitude)
            return;
        let query = {
            url: control.aladhanBaseGps.arg(aladhanDateString()).arg(latitude).arg(longitude),
            method: "GET"
        };
        Http.request(query).then(function (response) {
                let dayInfo = response['data']; // { timings, date, meta } for that one day
                if (!dayInfo || !dayInfo['timings']) {
                    console.log("prayer times: unexpected response shape");
                    return;
                }
                setPrayerTimes(dayInfo);
                let hijri = dayInfo["date"]["hijri"];
                hijriDate = hijri["weekday"]["ar"] + " " + hijri["day"] + " " + hijri["month"]["ar"] + " " + hijri["year"];
                control.startTimer();
            }).catch(function (error) {
                // A failed request must not leave an unhandled rejection behind; the
                // widget keeps the last times it managed to fetch.
                console.log("prayer times: request failed - " + (error && error.statusText ? error.statusText : error));
            });
    }
    function requestPrayertimesAPI(latitude: string, longitude: string): void {
        let query = {
            url: control.aladhanBaseGps.arg(aladhanDateString()).arg(latitude).arg(longitude),
            method: "GET"
        };
        Http.request(query).then(function (response) {
                let dayInfo = response['data'];
                setPrayerTimes(dayInfo);
                control.startTimer();
            });
    }
    function setPrayerTimes(response): void {
        control.prayTimes = [{
                "name": "Fajr",
                "times": response["timings"]["Fajr"].split("(")[0]
            }, {
                "name": "Sunrise",
                "times": response["timings"]["Sunrise"].split("(")[0]
            }, {
                "name": "Dhuhr",
                "times": response["timings"]["Dhuhr"].split("(")[0]
            }, {
                "name": "Asr",
                "times": response["timings"]["Asr"].split("(")[0]
            }, {
                "name": "Maghrib",
                "times": response["timings"]["Maghrib"].split("(")[0]
            }, {
                "name": "Isha",
                "times": response["timings"]["Isha"].split("(")[0]
            }];
    }
}
