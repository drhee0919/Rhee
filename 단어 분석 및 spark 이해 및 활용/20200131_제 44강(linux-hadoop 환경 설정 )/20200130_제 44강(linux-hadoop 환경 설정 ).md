```linux
[hadoop@master ~]$ cd /usr/local/hadoop-2.7.7/etc/hadoop/
[hadoop@master hadoop]$ pwd
[hadoop@master hadoop]$ cp mapred-site.xml.template  mapred-site.xml

[hadoop@master hadoop]$ vi mapred-site.xml
<configuration>
<property>
<name>mapreduce.framework.name</name>
<value>yarn</value>
</property>
</configuration>


[hadoop@master hadoop]$ vi yarn-site.xml
<configuration>
<property>
<name>yarn.nodemanager.aux-services</name>
<value>mapreduce_shuffle</value>
</property>
<property>
<name>yarn.nodemanager.aux-services.mapreduce_shuffle.class</name>
<value>org.apache.hadoop.mapred.ShuffleHandler</value>
</property>
</configuration>





[hadoop@master hadoop]$ mkdir -p /usr/local/hadoop-2.7.7/tmp/dfs/name
[hadoop@master hadoop]$ mkdir -p /usr/local/hadoop-2.7.7/tmp/dfs/data

[hadoop@master hadoop]$ mkdir -p /usr/local/hadoop-2.7.7/tmp/mapred/system
[hadoop@master hadoop]$ mkdir -p /usr/local/hadoop-2.7.7/tmp/mapred/local

[hadoop@master hadoop]$ chmod 755 /usr/local/hadoop-2.7.7/tmp/dfs


마스터 노드에서
[hadoop@master hadoop]$  cd /usr/local/hadoop-2.7.7
[hadoop@master hadoop]$  rsync -av . hadoop@secondary:/usr/local/hadoop-2.7.7
[hadoop@master hadoop]$  rsync -av . hadoop@slave1:/usr/local/hadoop-2.7.7
[hadoop@master hadoop]$  rsync -av . hadoop@slave2:/usr/local/hadoop-2.7.7
 
마스터 노드에서
[root@master ~]# vi /etc/sysconfig/iptables

# sample configuration for iptables service
# you can edit this manually or use system-config-firewall
# please do not ask us to add additional ports/services to this default configuration
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 8088 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 50070 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 5432 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 8032 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 12000 -j ACCEPT
-A INPUT -s 192.168.157.0/24 -d 192.168.157.0/24 -j ACCEPT
-A OUTPUT -s 192.168.157.0/24 -d 192.168.157.0/24 -j ACCEPT

-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited


[root@master ~]# cd /etc/sysconfig/
[root@master ~]# rm iptables

[root@master ~]# systemctl stop firewalld
[root@master ~]# systemctl mask firewalld
[root@master ~]# systemctl status firewalld
 
[root@master ~]# yum install iptables-services  

[root@master ~]# systemctl enable iptables
[root@master ~]# cd /etc/sysconfig
[root@master ~]# iptables -S
[root@master ~]# service iptables save

[root@master ~]# vi /etc/sysconfig/iptables

# sample configuration for iptables service
# you can edit this manually or use system-config-firewall
# please do not ask us to add additional ports/services to this default configuration
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 8088 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 50070 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 5432 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 8032 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 12000 -j ACCEPT
-A INPUT -s 192.168.157.0/24 -d 192.168.157.0/24 -j ACCEPT
-A OUTPUT -s 192.168.157.0/24 -d 192.168.157.0/24 -j ACCEPT

-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited

[root@master ~]# systemctl start iptables
또는 
[root@master ~]# systemctl restart iptables
[root@master ~]# systemctl status iptables

마스터 노드에서 하둡 환경 구성후 최초 1번만 수행합니다.
[hadoop@master ~]$ hadoop namenode -format

마스터 노드 브라우저에서
http://master:50070/dfshealth.html 

#마스터 노드에서 하둡(HDFS ) 서비스 시작시킵니다.
[hadoop@master ~]$ cd /usr/local/hadoop-2.7.7/
[hadoop@master hadoop-2.7.7]$  sbin/start-all.sh
#[hadoop@master hadoop-2.7.7]$  sbin/stop-all.sh
[hadoop@master hadoop-2.7.7]$  jps
[hadoop@master hadoop-2.7.7]$  sbin/mr-jobhistory-daemon.sh start historyserver
[hadoop@master hadoop-2.7.7]$  jps



```

vi /etc/sysconfig/iptables 