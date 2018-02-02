#!bin/bash
set -x
set -e

#get a quickstart java project
echo "getting a quick start java project from,maven archetype...."
echo "enter groupId->"
read groupId
echo "enter projectName->"
read project
 mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.0 -DgroupId=$groupId -DartifactId=$project -Dversion=1.0 -Dpackage=1
echo "done"

#copy the right pom file to the current project
echo "copying the pom file"
cat ../poms/Selenium.xml > ./$project/pom.xml
echo "done"

#run a maven resolve
echo "downloading the dependancy"
cd ./$project
mvn dependency:resolve
cd ..
echo "done"

#ask for any additional dependancies
add_dependancies="y"
echo "Do you have other dependencies you want to add now?(y/n)"
read answer
if [ $answer == "y" ] || [ $answer == "Y" ]; then
	while [ $add_dependancies == "y" ]; do
		echo "Enter the dependency as groupId:artifactId:version"
		read artifact
		mvn dependency:get -Dartifact=$artifact
		echo "Do you want to add more dependencies?(y/n)"
		read add_dependancies
	done
fi

#copy the Runner and Hooks java file to test location and Create the project structure
echo "Copying the runner and the hooks"
mkdir ./$project/src/test/java/support
mkdir ./$project/src/test/java/steps
mkdir ./$project/src/test/java/resources
mkdir ./$project/src/test/java/pages
mkdir ./$project/src/main/java/config
rm -r  ./$project/src/main/java/1
rm -r  ./$project/src/test/java/1
echo "put all your configs here over here" > ./$project/src/main/java/config/readme.txt
touch   ./$project/src/main/java/config/Config.java

mkdir ./$project/src/main/java/drivers
echo "put all your drivers over here" > ./$project/src/main/java/drivers/readme.txt
touch ./$project/src/test/java/resources/example.feature

cp ../JavaFiles/TestRunner.java ./$project/src/test/java/support/
cp ../JavaFiles/Hooks.java ./$project/src/test/java/support/
cp ../JavaFiles/StepDefs.java ./$project/src/test/java/steps/
cp ../JavaFiles/Constants.java ./$project/src/main/java/config/
cp ../JavaFiles/Config.java ./$project/src/main/java/config/
cp ../JavaFiles/WebDriverFactory.java  ./$project/src/main/java/drivers


#Set up IDE
echo "Set Project up for IntelliJ/Ecllipse(1/2)?"
read IDE
if [ $IDE == "1" ];then
	cd ./$project/
	mvn idea:idea
	cd ..
elif [ $IDE == "2" ]; then
	cd ./$project/
	mvn eclipse:eclipse
	cd ..
else
	echo "no IDE selected.. going ahead with default"
fi

echo "Kindly provide the --absolute path--  of where this project should be in your system?"
read abspath
cp  -r $project $abspath/

echo "Done.....Enjoy"
