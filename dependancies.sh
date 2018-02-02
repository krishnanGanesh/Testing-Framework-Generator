#!bin/bash

set -x
set -e

echo "Choose the Language of your FrameWork(java/ruby)[Type language as shown]?"
read lang	
OS=`uname`

javaLinux(){
	echo "----ALL PERMISSIONS PROMPTS ARE FROM THE SYSTEM. THIS SCRIPT ASKS OR SAVES NO PASSWORDS----"
	#install Java if not installed
	sudo apt-get install openjdk-8-jdk
	if [ $? == 0 ]; then
		echo "java success"
	else
		echo "java installation failed,something went wrong....exiting script"
		exit
	fi
	#set JAVA_HOME
	 export JAVA_HOME=/usr/lib/jvm/java/java-8-openjdk-amd64
	#echo "export PATH=$JAVA_HOME/bin:$PATH">> sourcefile
	#source sourcefile
	#rm sourcefile

	#install maven
	sudo apt-get install maven
	if [ $? == 0 ]; then
		echo "maven installation failed.......exiting script"
	else
		echo "maven installation failed,something went wrong....exiting script"
		exit
	fi
	echo "done with java dependencies"
}


eval "$lang$OS"

