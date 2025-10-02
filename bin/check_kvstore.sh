#!/bin/bash
read -r tok || true   # Ignore non-0 exit because Splunk closes stdin (EOF) after writing the token
date=`/bin/date +"%Y-%m-%d %H:%M:%S.%3N %z"`
status=`$SPLUNK_HOME/bin/splunk show kvstore-status -token $tok 2>/dev/null | grep -Eo "status\s+:\s+\S+" | sed -e 's/status : /status=/'`
echo "$date $status"

