하둡 시작 명령어 

> ```bash
> [hadoop@master ~]$ cd /usr/local/hadoop-2.7.7/
> [hadoop@master hadoop-2.7.7]$  sbin/start-all.sh
> ```

파이어 폭스 브라우저 열고 다음 주소 입력하기 

> ```bash
> http://master:50070/dfshealth.html
> ```

```bash
#하위 디렉토리에 testfile1 생성 
[hadoop@master ~]$ hadoop fs -ls /
[hadoop@master ~]$ hadoop fs -mkdir /data/
[hadoop@master ~]$ hadoop fs -ls /
[hadoop@master ~]$ echo "A long time ago in a galaxy far far away" > /home/hadoop/testfile1
[hadoop@master ~]$ ls
[hadoop@master ~]$ hadoop fs -put ./testfile1  /data/
[hadoop@master ~]$ hadoop fs -ls -R /
[hadoop@master ~]$ hadoop fs -cat  /data/testfile1

[hadoop@master ~]$ ls 
[hadoop@master ~]$ rm testfile1
[hadoop@master ~]$ ls 
[hadoop@master ~]$ hadoop fs -get  /data/testfile1  .
[hadoop@master ~]$ ls 
[hadoop@master ~]$ cat testfile1


# testfile2 도 생성 
[hadoop@master ~]$ echo "Another episode of Star Wars" > /home/hadoop/testfile2
[hadoop@master ~]$ ls 
[hadoop@master ~]$ hadoop fs -put ./testfile2  /data/
[hadoop@master ~]$ hadoop fs -ls -R /
[hadoop@master ~]$ hadoop fs -cat  /data/testfile2


#testfile1 + testfile2 = testfile3
[hadoop@master ~]$ hadoop fs -getmerge  /data/testfile*  ./testfile3
[hadoop@master ~]$ ls
[hadoop@master ~]$ cat testfile3
```



**Word count** **MapReduce** **동작하기**

하둡 스트리밍 jar 파일 가져오기 

> ```bash
> [hadoop@master ~]$ ls ./Downloads 
> [hadoop@master ~]$ su -
> [root@master ~]# cp /home/hadoop/Downloads/hadoop-streaming-2.7.3.jar  /usr/lib/
> [root@master ~]# ls -l /usr/lib/
> [root@master ~]# chown -R hadoop:hadop  /usr/lib/hadoop-streaming-2.7.3.jar 
> [root@master ~]# ls -l /usr/lib/ #확인하고 
> [root@master ~]# exit #exit
> ```

```

```

wordcount_mapper.py 생성

> ```bash
> [hadoop@master ~]$ gedit wordcount_mapper.py
> #!/usr/bin/env python
> 
> import sys
> 
> for line in sys.stdin:
>     line = line.strip()
>     keys = line.split()
> 
>     for key in keys:
>         value = 1
>         print('{0}\t{1}'.format(key, value))
> ```

wordcount_reducer.py 생성

> ```bash
> [hadoop@master ~]$ gedit wordcount_reducer.py
> #!/usr/bin/env python
> 
> import sys
> 
> last_key = None
> running_total = 0
> 
> for input_line in sys.stdin:
>     input_line = input_line.strip()
> 
>     this_key, value = input_line.split("\t", 1)
>     value = int(value)
>     
>     if last_key == this_key:
>         running_total += value
>     else:
>         if last_key:
>             print("{0}\t{1}".format(last_key, running_total))
>         running_total = value
>         last_key = this_key
> 
> if last_key == this_key:
>     print("{0}\t{1}".format(last_key, running_total))
> ```

> ```bash
> [hadoop@master ~]$ chmod +x wordcount_mapper.py
> [hadoop@master ~]$ chmod +x wordcount_reducer.py
> [hadoop@master ~]$ gedit testfile1
> 
> #해당 문구입력
> Apache Hadoop 2.7.2 is a minor release in the 2.x.y release line, building upon the previous stable release 2.7.1.
> 
> Here is a short overview of the major features and improvements.
> 
> Common
> 
> Authentication improvements when using an HTTP proxy server. This is useful when accessing WebHDFS via a proxy server.
> A new Hadoop metrics sink that allows writing directly to Graphite.
> Specification work related to the Hadoop Compatible Filesystem (HCFS) effort.
> HDFS
> 
> Support for POSIX-style filesystem extended attributes. See the user documentation for more details.
> Using the OfflineImageViewer, clients can now browse an fsimage via the WebHDFS API.
> The NFS gateway received a number of supportability improvements and bug fixes. The Hadoop portmapper is no longer required to run the gateway, and the gateway is now able to reject connections from unprivileged ports.
> The SecondaryNameNode, JournalNode, and DataNode web UIs have been modernized with HTML5 and Javascript.
> YARN
> 
> YARN’s REST APIs now support write/modify operations. Users can submit and kill applications through REST APIs.
> The timeline store in YARN, used for storing generic and application-specific information for applications, supports authentication through Kerberos.
> The Fair Scheduler supports dynamic hierarchical user queues, user queues are created dynamically at runtime under any specified parent-queue.
> 
> #testfile 2도 편집해주기 
> [hadoop@master ~]$ gedit testfile2
> HDFS is the primary distributed storage used by Hadoop applications. A HDFS cluster primarily consists of a NameNode that manages the file system metadata and DataNodes that store the actual data. The HDFS Architecture Guide describes HDFS in detail. This user guide primarily deals with the interaction of users and administrators with HDFS clusters. The HDFS architecture diagram depicts basic interactions among NameNode, the DataNodes, and the clients. Clients contact NameNode for file metadata or file modifications and perform actual file I/O directly with the DataNodes.
> 
> The following are some of the salient features that could be of interest to many users.
> 
> Hadoop, including HDFS, is well suited for distributed storage and distributed processing using commodity hardware. It is fault tolerant, scalable, and extremely simple to expand. MapReduce, well known for its simplicity and applicability for large set of distributed applications, is an integral part of Hadoop.
> 
> HDFS is highly configurable with a default configuration well suited for many installations. Most of the time, configuration needs to be tuned only for very large clusters.
> 
> Hadoop is written in Java and is supported on all major platforms.
> 
> Hadoop supports shell-like commands to interact with HDFS directly.
> 
> The NameNode and Datanodes have built in web servers that makes it easy to check current status of the cluster.
> 
> New features and improvements are regularly implemented in HDFS. The following is a subset of useful features in HDFS:
> 
> File permissions and authentication.
> Rack awareness: to take a node’s physical location into account while scheduling tasks and allocating storage.
> Safemode: an administrative mode for maintenance.
> fsck: a utility to diagnose health of the file system, to find missing files or blocks.
> fetchdt: a utility to fetch DelegationToken and store it in a file on the local system.
> Balancer: tool to balance the cluster when the data is unevenly distributed among DataNodes.
> Upgrade and rollback: after a software upgrade, it is possible to rollback to HDFS’ state before the upgrade in case of unexpected problems.
> Secondary NameNode: performs periodic checkpoints of the namespace and helps keep the size of file containing log of HDFS modifications within certain limits at the NameNode.
> Checkpoint node: performs periodic checkpoints of the namespace and helps minimize the size of the log stored at the NameNode containing changes to the HDFS. Replaces the role previously filled by the Secondary NameNode, though is not yet battle hardened. The NameNode allows multiple Checkpoint nodes simultaneously, as long as there are no Backup nodes registered with the system.
> Backup node: An extension to the Checkpoint node. In addition to checkpointing it also receives a stream of edits from the NameNode and maintains its own in-memory copy of the namespace, which is always in sync with the active NameNode namespace state. Only one Backup node may be registered with the NameNode at once.
> 
> ```

> ```bash
> [hadoop@master ~]$ hadoop fs -mkdir /input
> [hadoop@master ~]$ hadoop fs -put ./testfile1  /input
> [hadoop@master ~]$ hadoop fs -put ./testfile2  /input
> [hadoop@master ~]$ hadoop fs -ls /input/
> 
> [hadoop@master ~]$ hadoop jar /usr/lib/hadoop-streaming-2.7.3.jar -input  /input/  -output /output/  -mapper  /home/hadoop/wordcount_mapper.py  -reducer /home/hadoop/wordcount_reducer.py
> 
> [hadoop@master ~]$ hadoop fs -ls /output/
> [hadoop@master ~]$ hadoop fs -cat /output/part-00000
> ```