#!/bin/bash

# Copyright 2015 The Kubernetes Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
export ZEPPELIN_HOME=/root/zeppelin
export ZEPPELIN_CONF_DIR="${ZEPPELIN_HOME}/conf"
#### Spark interpreter configuration ####

export MASTER="spark://{{active_master}}:7077"
## Use provided spark installation ##
## defining SPARK_HOME makes Zeppelin run spark interpreter process using spark-submit
##
# export SPARK_HOME                             # (required) When it is defined, load it instead of Zeppelin embedded Spark libraries
export SPARK_HOME="/root/spark"
# export SPARK_SUBMIT_OPTIONS                   # (optional) extra options to pass to spark submit. eg) "--driver-memory 512M --executor-memory 1G".
export SPARK_APP_NAME="Zeppelin"                         # (optional) The name of spark application.

## Use embedded spark binaries ##
## without SPARK_HOME defined, Zeppelin still able to run spark interpreter process using embedded spark binaries.
## however, it is not encouraged when you can define SPARK_HOME
##
# Options read in YARN client mode
# export HADOOP_CONF_DIR                        # yarn-site.xml is located in configuration directory in HADOOP_CONF_DIR.
# Pyspark (supported with Spark 1.2.1 and above)
# To configure pyspark, you need to set spark distribution's path to 'spark.home' property in Interpreter setting screen in Zeppelin GUI
export PYSPARK_PYTHON="/usr/bin/python27"                         # path to the python command. must be the same path on the driver(Zeppelin) and all workers.
py4j=`ls ${SPARK_HOME}/python/lib/py4j-*-src.zip`
export PYTHONPATH="${SPARK_HOME}/python:${py4j}"
# export PYTHONPATH

## Spark interpreter options ##
##
export ZEPPELIN_SPARK_USEHIVECONTEXT=false  # Use HiveContext instead of SQLContext if set true. true by default.
export ZEPPELIN_SPARK_CONCURRENTSQL=true   # Execute multiple SQL concurrently if set true. false by default.
# export ZEPPELIN_SPARK_IMPORTIMPLICIT  # Import implicits, UDF collection, and sql if set true. true by default.
# export ZEPPELIN_SPARK_MAXRESULT       # Max number of Spark SQL result to display. 1000 by default.
# export ZEPPELIN_WEBSOCKET_MAX_TEXT_MESSAGE_SIZE       # Size in characters of the maximum text message to be received by websocket. Defaults to 1024000
export ZEPPELIN_NOTEBOOK_DIR="${ZEPPELIN_HOME}/notebook"
export ZEPPELIN_MEM='-Xmx2048m'
# TODO(zmerlynn): Setting global CLASSPATH *should* be unnecessary,
# but ZEPPELIN_JAVA_OPTS isn't enough here. :(
export ZEPPELIN_PORT=8081
export MATPLOTLIBRC="${ZEPPELIN_HOME}/conf"
