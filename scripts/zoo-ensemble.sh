#!/bin/bash


instance_num=3

usage() {
	cat << EOF
To start or stop zookeeper:

usage: zoo-ensemble [start|stop|restart]

EOF
	exit 0
}

checkInstanceConfig() {
num=$1
for i in $(seq 1 $num)
do
	if [ ! -f $ZOOKEEPER_HOME/conf/zoo-$i.cfg ]; then
    echo "conf/zoo-$i.cfg not found! Zookeeper can't be started"
	fi
	data_dir=`cat $ZOOKEEPER_HOME/conf/zoo-$i.cfg | grep data | awk -F= '{print $2}'`
	if [ ! -f $data_dir/myid ]; then
    echo "$data_dir/myid not found! Zookeeper can't be started"
	fi
done

}

runCommand() {
# IFS=';'
# echo "Commands $@ will be executed"
# read -ra cmdarr <<< "$cmds"
for i in `seq 1 $instance_num`
do
#	for cmd in "${cmdarr[@]}"
	for cmd in "$@"
	do
		start_time="$(date -u +%s)"
		echo "server: $i running command: $cmd"
		./zkServer.sh $cmd zoo-$i.cfg
		end_time="$(date -u +%s)"
		elapsed="$(($end_time-$start_time))"
		echo "$cmd took $elapsed second to execute"
	done
done
}

# main
if [ -z $ZOOKEEPER_HOME ]; then
	echo "ZOOKEEPER_HOME is not set, please set the env variable withe the root of your zookeper install"
	exit 1
fi

if [ -z "$1" ]
then
	usage
elif [ $1 = "start" ]; then
	cmd="start"
	checkInstanceConfig $instance_num
elif [ $1 = "stop" ]; then
		cmd="stop"
elif [ $1 = "restart" ]; then
		cmd=`echo "stop" "start"`
else
	echo $1: wrong command
	usage
fi

runCommand $cmd
