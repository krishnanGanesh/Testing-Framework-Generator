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
	#sudo echo "JAVA_HOME=/usr/lib/jvm/java/java-8-openjdk-amd64" >> /etc/environment

	
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

javaDarwin(){
	echo "Looks like you are on a Mac.checking for brew"
	if [ `which brew` == '' ];then
		echo "brew not installed...exiting"
		exit
		#can give an option to install brew after checking connectivity
	fi
	echo "----ALL PERMISSIONS PROMPTS ARE FROM THE SYSTEM. THIS SCRIPT ASKS OR SAVES NO PASSWORDS----"
	#installing java8 with brew cask
	brew update
	brew tap caskroom/versions
	echo "installing java 8 jdk"
	brew cask install java8 
	echo "done"

	#installing maven with brew
	echo "installing maven...."
	brew install maven
}


eval "$lang$OS"

#once the dependancies installation is successful
#cd intoProject(ask which framework Selenium/Appium/API...etc)
#run the script

