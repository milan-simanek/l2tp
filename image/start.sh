#!/bin/sh

[ -n "$DEVNAMEPREFIX" ] && echo "$DEVNAMEPREFIX" > /etc/ppp/devnameprefix

cleanup() {
  kill `cat /run/xl2tpd.pid`
  pkill syslogd
  exit
}

trap "cleanup" TERM

syslogd

# Keep the tunnel interface up
while sleep 1
do
    if [ ! -f /run/xl2tpd.pid ] \
    || ! read xpid < /run/xl2tpd.pid \
    || [ -z "$xpid" ] \
    || ! [ -d /proc/$xpid ]
    then
      echo "starting xl2tpd..."
      xl2tpd
      continue
    fi

    sleep 10

    sed -n 's/^[[:space:]]*\[ *lac  *\([^[:space:]][^[:space:]]*\)[[:space:]]*\].*$/\1/p' \
        /etc/xl2tpd/xl2tpd.conf \
    | while read name x
    do
      [ -f /run/lac-$name ] \
      && read ifname < /run/lac-$name \
      && [ -n "$ifname" ] \
      && ip link show "$ifname" | grep -q '\<UP\>' && continue
      echo "reconnecting $name"
#      echo "c $name" > /var/run/xl2tpd/l2tp-control
      xl2tpd-control connect-lac "$name"
      break
    done
done
