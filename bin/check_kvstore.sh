#!/bin/bash
read -r tok || true   # Ignore non-0 exit because Splunk closes stdin (EOF) after writing the token
date=`/bin/date +"%Y-%m-%d %H:%M:%S.%3N %z"`
status=`$SPLUNK_HOME/bin/splunk show kvstore-status -token $tok 2>/dev/null | grep -Eo "status\s+:\s+\S+" | sed -e 's/status : /status=/'`
#alternative below is for SHC, as a KV Store status of "ready" does not mean mongo/KV Store is running on the member in question
#KV Store status is not accurate on SH members, use replicationStatus
#rep_status=`$SPLUNK_HOME/bin/splunk show kvstore-status -token $tok 2>/dev/null | grep "replicationStatus" | wc -l`
#if [[ $rep_status != 0 ]]; then status="status=ready"; else status="status=failed"; fi
echo "$date $status"
