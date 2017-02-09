#!/bin/bash

pushd /root > /dev/null

zeppelin_ver=0.7.0
ZEPPELIN_HOME=/root/zeppelin
ZEPPELIN_CONF_DIR="${ZEPPELIN_HOME}/conf"

MASTER "spark://spark-master:7077"
ZEPPELIN_NOTEBOOK_DIR="${ZEPPELIN_HOME}/notebook"
ZEPPELIN_MEM=-Xmx1024m

curl http://mirrors.ibiblio.org/apache/zeppelin/zeppelin-${zeppelin_ver}/zeppelin-${zeppelin_ver}-bin-netinst.tgz | \
          tar -zx -C /root
mv "/root/zeppelin-${zeppelin_ver}-bin-netinst" "${ZEPPELIN_HOME}"
${ZEPPELIN_HOME}/bin/install-interpreter.sh --name md,python,shell,file,alluxio
# additional interpreters
${ZEPPELIN_HOME}/bin/install-interpreter.sh --name jdbc,cassandra

popd > /dev/null
