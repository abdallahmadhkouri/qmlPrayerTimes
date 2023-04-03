var prayertimesBase = "https://api.pray.zone/v2/times/today.json"
var aladhanBase = "http://api.aladhan.com/v1/timingsByCity"

function prayertimesRequest(city, cb) {
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function() {
        print('xhr: on ready state change: ' + xhr.readyState)
        if(xhr.readyState === XMLHttpRequest.DONE) {
            if(cb) {
                var res = JSON.parse(xhr.responseText.toString())
                cb(res)
            }
        }
    }
    var params = '?city=' + city + "&school=" + 4
    //print ("prayertimesRequest: " + prayertimesBase + params)
    xhr.open("GET", prayertimesBase + params)
    xhr.setRequestHeader('Content-Type', 'application/json')
    xhr.setRequestHeader('Accept', 'application/json')
    var data = ''
    xhr.send(data)
}

function aladhanRequest(city, country, cb) {
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function() {
        //print('xhr: on ready state change: ' + xhr.readyState)
        if(xhr.readyState === XMLHttpRequest.DONE) {
            if(cb) {
                var res = JSON.parse(xhr.responseText.toString())
                cb(res)
            }
        }
    }
    var params = '?city=' + city + "&country=" + country + "&method=" + 4
    //print ("aladhanRequest: " + aladhanBase + params)
    xhr.open("GET", aladhanBase + params)
    xhr.setRequestHeader('Content-Type', 'application/json')
    xhr.setRequestHeader('Accept', 'application/json')
    var data = ''
    xhr.send(data)
}
