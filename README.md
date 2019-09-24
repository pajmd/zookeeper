# zookeeper
configs and scripts for version 3.5.5 (used for solr 7.7.2)
The config is for an ensemble running on one single node, to distinguish each server _n (n = server number) is appended to the config files and data and id folders.  

### Config files  
* /var/lib/zookeeper/data-n ( n= 1-3)  
in each data_n folfer add a /var/lib/zookeeper/data-n/myid file containing id (id = 1-3)  
* ~/apache-zookeeper-3.5.5-bin/conf/zoo-n.cfg ( n= 1-3)  

### env variables
In .profile
ZOOKEEPER_HOME=$HOME/apache-zookeeper-3.5.5-bin  
export ZOOKEEPER_HOME="$HOME/apache-zookeeper-3.5.5-bin"  
export SOLR_HOME="$HOME/solr-7.7.2/server/solr"  
