#!/bin/bash

# Ortam değişkenleri tekrar yüklensin diye
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export HADOOP_HOME=/opt/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$JAVA_HOME/bin

echo "[INFO] Hostname: $HOSTNAME"

if [[ "$HOSTNAME" == "resourcemanager" ]]; then
    echo "[INFO] Starting ResourceManager..."
    start-yarn.sh
    tail -f /dev/null

elif [[ "$HOSTNAME" == nodemanager* ]]; then
    echo "[INFO] Starting NodeManager..."
    yarn nodemanager
    tail -f /dev/null

elif [[ "$HOSTNAME" == "jobhistory" ]]; then
    echo "[INFO] Starting JobHistoryServer..."
    mr-jobhistory-daemon.sh start historyserver
    tail -f /dev/null

else
    echo "[ERROR] Unknown role for hostname $HOSTNAME"
    exit 1
fi
