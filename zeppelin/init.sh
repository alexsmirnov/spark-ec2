#!/bin/bash

pushd /root > /dev/null

zeppelin_ver=0.7.2
ZEPPELIN_HOME=/root/zeppelin
ZEPPELIN_CONF_DIR="${ZEPPELIN_HOME}/conf"

ZEPPELIN_NOTEBOOK_DIR="${ZEPPELIN_HOME}/notebook"
ZEPPELIN_MEM=-Xmx1024m
if [[ ! -d  "${ZEPPELIN_HOME}" ]] ; then
curl http://mirrors.ibiblio.org/apache/zeppelin/zeppelin-${zeppelin_ver}/zeppelin-${zeppelin_ver}-bin-all.tgz | \
          tar -zx -C /root
mv "/root/zeppelin-${zeppelin_ver}-bin-all" "${ZEPPELIN_HOME}"
fi
popd > /dev/null
