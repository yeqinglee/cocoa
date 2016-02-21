# CoCoA - A Framework for Communication-Efficient Distributed Optimization

New! We've added support for faster additive udpates with CoCoA+. See more information [here](http://arxiv.org/abs/1502.03508).

This code performs a comparison of 5 distributed algorithms for training of machine learning models, using [Apache Spark](http://spark.apache.org). The implemented algorithms are
 - _CoCoA+_
 - _CoCoA_
 - mini-batch stochastic dual coordinate ascent (_mini-batch SDCA_)
 - stochastic subgradient descent with local updates (_local SGD_)
 - mini-batch stochastic subgradient descent (_mini-batch SGD_)

The present code trains a standard SVM (hinge-loss, l2-regularized) using SDCA as a local solver, and reports training and test error, as well as the duality gap certificate if the method is primal-dual. The code can be easily adapted to include other internal solvers or solve other objectives.

## Getting Started
How to run the code locally:

```
sbt/sbt assembly
./run-demo-local.sh
```

(For the `sbt` script to run, make sure you have downloaded CoCoA into a directory whose path contains no spaces.)

## Run on TACC

### Create reservation
Go to [Wrangler Portal](https://portal.wrangler.tacc.utexas.edu/) and create a hadoop reservation.
Choose "Start as soon as possible?". It will take a few minute for the reservation to realize.
Then, use the following command to find out reservation name
```
showres -a
```

### Load modules
Load the necessary modules:
```
module load spark-paths
module load hadoop-paths
```

### Use hadoop reservation in debug mode

Command
```
idev -r hadoop+MATGENOME+1183 -n 1
```

Note: hadoop+MATGENOME+1183 is reservation name. 
pyspark and spark-shell can only be run on idev mode (with reservation).

### Run the code
Copy data to Hadoop File Syatem.
```
hdfs dfs -copyFromLocal data/ .
```

Run it:
```
sbt/sbt assembly
./run-demo-TACC.sh
```

Or run the shell
```
spark-shell --master yarn-master
```
**Note**: Remember to copy file to hdfs

### Check the results

```
yarn logs -applicationId application_1455766451986_0015
```
where "application_1455766451986_0015" is the application ID.


## References
The CoCoA+ and CoCoA algorithmic frameworks are described in more detail in the following papers:

_Ma, C., Smith, V., Jaggi, M., Jordan, M. I., Richtarik, P., & Takac, M. [Adding vs. Averaging in Distributed Primal-Dual Optimization](http://arxiv.org/abs/1502.03508). ICML 2015 - International Conference on Machine Learning._

_Jaggi, M., Smith, V., Takac, M., Terhorst, J., Krishnan, S., Hofmann, T., & Jordan, M. I. [Communication-Efficient Distributed Dual Coordinate Ascent](http://papers.nips.cc/paper/5599-communication-efficient-distributed-dual-coordinate-ascent) (pp. 3068–3076). NIPS 2014 - Advances in Neural Information Processing Systems 27._
