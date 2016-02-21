#!/bin/bash

#--master `cat /root/spark-ec2/cluster-url` \
#--driver-java-options "-Dspark.local.dir=/mnt/spark,/mnt2/spark -XX:+UseG1GC" \
  #--master yarn-client \ 

spark-submit \
  --master yarn-cluster \
  --class "distopt.driver" \
  --driver-memory 7G \
  --num-executors 8 \
  --executor-cores 16 \
  target/scala-2.10/cocoa-assembly-0.1.jar \
	--trainFile=data/small_train.dat \
	--testFile=data/small_test.dat \
	--numFeatures=9947 \
	--numRounds=100 \
	--localIterFrac=0.1 \
	--numSplits=8 \
	--lambda=.001 \
	--justCoCoA=false \
  "$@"

