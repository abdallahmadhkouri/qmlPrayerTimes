pragma Singleton
import QtQuick
import httpservices

Item {
    id: control

    property string aladhanBase: "http://api.aladhan.com/v1/timingsByCity"
    property string aladhanBaseGps: "http://api.aladhan.com/v1/calendar?latitude=%1&longitude=%2&method=4"
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
    function requestAladhanAPI(latitude: string, longitude: string): void {
        let query = {
            url: control.aladhanBaseGps.arg(latitude).arg(longitude),
            method: "GET"
        };
        Http.request(query).then(function (response) {
                let days = new Date().getDate() - 1;
                let dayInfo = response['data'][days];
                setPrayerTimes(dayInfo);
                var day = dayInfo["date"]["hijri"]["day"];
                var weekday = dayInfo["date"]["hijri"]["weekday"]["ar"];
                var month = dayInfo["date"]["hijri"]["month"]["ar"];
                var monthNumber = dayInfo["date"]["hijri"]["month"]["number"];
                var year = dayInfo["date"]["hijri"]["year"];
                hijriDate = weekday + " " + day + " " + month + " " + year;
                control.startTimer();
            });
    }
    function requestPrayertimesAPI(latitude: string, longitude: string): void {
        let query = {
            url: control.aladhanBaseGps.arg(latitude).arg(longitude),
            method: "GET"
        };
        Http.request(query).then(function (response) {
                let day = new Date().getDate();
                let dayInfo = response['data'][day];
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
