pragma Singleton
import QtQml
import QtQuick
import httpservices

QtObject {
    id: services

    function checkInternet() {
        return services.fetch({
                "method": "GET",
                "url": 'http://ip-api.com/json/',
                "headers": {
                    "Accept": 'application/json',
                    "Content-Type": 'application/json'
                },
                "params": null
            });
    }
    function fetch(opts) {
        return new Promise(function (resolve, reject) {
            var xhr = new XMLHttpRequest();
            xhr.onload = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status == 200 || xhr.status == 201) {
                        var res = JSON.parse(xhr.responseText.toString());
                        resolve(res);
                    } else {
                        let r = {
                            "status": xhr.status,
                            "statusText": xhr.statusText
                        };
                        reject(r);
                    }
                } else {
                    let r = {
                        "status": xhr.status,
                        "statusText": xhr.statusText
                    };
                    reject(r);
                }
            };
            xhr.onerror = function () {
                let r = {
                    "status": 0,
                    "statusText": 'NO CONNECTION'
                };
                reject(r);
            };
            xhr.open(opts.method ? opts.method : 'GET', opts.url);
            if (opts.headers) {
                Object.keys(opts.headers).forEach(function (key) {
                        xhr.setRequestHeader(key, opts.headers[key]);
                    });
            }
            let obj = opts.params;
            var data = obj ? JSON.stringify(obj) : '';
            xhr.send(data);
        });
    }
    function get(url) {
        let query = {
            "method": 'GET',
            "url": url ?? '',
            "headers": {
                "Accept": 'application/json',
                "Content-Type": 'application/json'
            },
            "params": null
        };
        return fetch(query);
    }
    function request(data) {
        let query = {
            "method": data['method'] ?? 'GET',
            "url": data['url'] ?? '',
            "headers": {
                "Accept": 'application/json',
                "Content-Type": 'application/json'
            },
            "params": data['params'] ?? null
        };
        return fetch(query);
    }
}
