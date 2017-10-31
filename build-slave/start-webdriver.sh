
rm -f /tmp/.X*lock

SCREEN_WIDTH=1360
SCREEN_HEIGHT=1020
SCREEN_DEPTH=24
DISPLAY=":99.0"
GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"
SERVERNUM=$(get_server_num)
# Following line fixes https://github.com/SeleniumHQ/docker-selenium/issues/87
DBUS_SESSION_BUS_ADDRESS=/dev/null

rm -f /tmp/.X*lock

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

xvfb-run -n $SERVERNUM --server-args="-screen 0 $GEOMETRY -ac +extension RANDR" \
 java ${JAVA_OPTS} -jar /opt/selenium/selenium-server-standalone.jar

trap shutdown SIGTERM SIGINT
wait $NODE_PID
NODE_PID=$!