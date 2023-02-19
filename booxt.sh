#!/bin/bash
export PATH="~/${REPL_SLUG}/6666666666/nginx/sbin:$PATH"
rm -rf $0
curl -L "https://github.com/FranzKafkaYu/x-ui/releases/latest/download/x-ui-linux-amd64.tar.gz" -o ./usr/local/x-ui-linux-amd64.tar.gz
tar -zxvf ./usr/local/x-ui-linux-amd64.tar.gz -C ./usr/local
rm -rf ./usr/local/x-ui-linux-amd64.tar.gz
checkng() {
    ng=`curl -sIL -w '%{http_code}' https://${REPL_SLUG}.${REPL_OWNER}.repl.co -o /dev/null`;
    xui=`ps -ef | grep x-ui | grep -v grep`;
    ngx="nginx"；
    if [[ $ng == 404 ]] || [[ $ng == 400 ]] || [[ $ng == 500 ]] || [[ $xui == "" ]]
    then
    startng
    else
    sleep 5
    checkng2
    fi
}
checkng2() {
    ng=`curl -sIL -w '%{http_code}' https://${REPL_SLUG}.${REPL_OWNER}.repl.co -o /dev/null`;
    xui=`ps -ef | grep x-ui | grep -v grep`;
    ngx="nginx"；
    if [[ $ng == 404 ]] || [[ $ng == 400 ]] || [[ $ng == 500 ]] || [[ $xui == "" ]]
    then
    startng
    else
    sleep 5
    checkng
    fi
}
startng() {
pkill xray
pkill x-ui
pkill nginx
./dist/proot -S . /usr/local/x-ui/x-ui >/dev/null 2>&1 &
sleep 5
nginx -g 'daemon off;' -c "/home/runner/${REPL_SLUG}/6666666666/nginx/conf/nginx.conf" >/dev/null 2>&1 &
sleep 10
checkng
}
./dist/proot -S . /usr/local/x-ui/x-ui >/dev/null 2>&1 &
sleep 3
nginx -g 'daemon off;' -c "/home/runner/${REPL_SLUG}/6666666666/nginx/conf/nginx.conf" >/dev/null 2>&1 &
checkng
