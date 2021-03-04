#!/bin/bash

#/usr/local/nginx/sbin/nginx -g 'daemon off;'

# Start Nginx
/usr/local/nginx/sbin/nginx
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start Nginx: $status"
  exit $status
fi

/usr/local/nginx/sbin/nginx-vts-exporter -nginx.scrape_uri=http://127.0.0.1/status-vts/format/json -telemetry.address=127.0.0.1:9913 -telemetry.endpoint=/metrics &

#while sleep 60; do
#  ps aux |grep 'nginx: master ' |grep -q -v grep
#  PROCESS_1_STATUS=$?
#  ps aux |grep 'nginx-vts-exporter' | grep '9913' |grep -q -v grep
#  PROCESS_2_STATUS=$?
#  # If the greps above find anything, they exit with 0 status
#  # If they are not both 0, then something is wrong
#  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
#    echo "One of the processes has already exited."
#    exit 1
#  fi
#done
while sleep 60; do
  ps aux |grep 'nginx: master ' |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep 'nginx-vts-exporter' | grep '9913' |grep -q -v grep
#  PROCESS_2_STATUS=$?
#  # If the greps above find anything, they exit with 0 status
#  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 ]; then
    echo "Nginx has already exited."
    exit 1
  fi
done
