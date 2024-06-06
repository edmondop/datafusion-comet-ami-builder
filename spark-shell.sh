export BUILD_FOLDER=/home/ec2-user/datafusion-comet/
export COMET_JAR=${BUILD_FOLDER}spark/target/comet-spark-spark3.4_2.12-0.1.0-SNAPSHOT.jar
export SPARK_HOME=/usr/lib/spark

$SPARK_HOME/bin/spark-shell \
    --jars $COMET_JAR \
    --conf spark.driver.extraClassPath=$COMET_JAR \
    --conf spark.executor.extraClassPath=$COMET_JAR \
    --conf spark.sql.extensions=org.apache.comet.CometSparkSessionExtensions \
    --conf spark.comet.enabled=true \
    --conf spark.comet.exec.enabled=true \
    --conf spark.comet.exec.all.enabled=true \
    --conf spark.comet.explainFallback.enabled=true