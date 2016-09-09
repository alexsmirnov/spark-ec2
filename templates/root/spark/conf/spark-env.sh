#!/usr/bin/env bash

export SPARK_LOCAL_DIRS="{{spark_local_dirs}}"

# Standalone cluster options
export SPARK_MASTER_OPTS="{{spark_master_opts}}"
if [ -n "{{spark_worker_instances}}" ]; then
  export SPARK_WORKER_INSTANCES={{spark_worker_instances}}
fi
export SPARK_WORKER_CORES={{spark_worker_cores}}
export SPARK_WORKER_DIR="/mnt/spark"
export HADOOP_HOME="/root/ephemeral-hdfs"
export SPARK_MASTER_IP={{active_master}}
export MASTER=`cat /root/spark-ec2/cluster-url`

export SPARK_SUBMIT_LIBRARY_PATH="$SPARK_SUBMIT_LIBRARY_PATH:/root/ephemeral-hdfs/lib/native/"

SPARK_EXTRA_CLASSPATH="/root/ephemeral-hdfs/share/hadoop/tools/lib/aws-java-sdk-1.7.4.jar:/root/ephemeral-hdfs/share/hadoop/tools/lib/hadoop-aws-2.7.2.jar"
#ALLUXIO_CLIENT_JAR="/root/{{tachyon_name}}/core/client/target/{{tachyon_name}}-core-client-{{tachyon_version}}-jar-with-dependencies.jar"
#if [[ -f "$ALLUXIO_CLIENT_JAR" ]] ; then
    # export SPARK_EXTRA_CLASSPATH="$ALLUXIO_CLIENT_JAR:$SPARK_EXTRA_CLASSPATH"
#fi
export SPARK_SUBMIT_CLASSPATH="$SPARK_CLASSPATH:$SPARK_SUBMIT_CLASSPATH:/root/ephemeral-hdfs/conf:$SPARK_EXTRA_CLASSPATH"

# Bind Spark's web UIs to this machine's public EC2 hostname otherwise fallback to private IP:
export SPARK_PUBLIC_DNS=`
wget -q -O - http://169.254.169.254/latest/meta-data/public-hostname ||\
wget -q -O - http://169.254.169.254/latest/meta-data/local-ipv4`

# Used for YARN model
export YARN_CONF_DIR="/root/ephemeral-hdfs/conf"

# Set a high ulimit for large shuffles, only root can do this
if [ $(id -u) == "0" ]
then
    ulimit -n 1000000
fi
