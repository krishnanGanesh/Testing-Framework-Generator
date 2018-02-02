#!bin/bash

#get a quickstart java project
echo "getting a quick start java project...."
mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart
echo "done"

#copy the right pom file to the current project
echo "copying the pom file"
cat ../poms/Selenium-Appium.xml > pom.xml
echo "done"

#run a maven 
echo "downloading the dependancy"
mvn dependency:resolve
echo "done"

#ask for any additional dependancies
add_dependancies="y"
echo "Do you have other dependancies you want to add now?(y/n)"
read answer
if [ $answer == "y" || $answer == "Y" ]; then
	while [ $add_dependancies == "y" ]; do
		echo "Enter the dependency as groupId:artifactId:version"
		read artifact
		mvn dependency:get -Dartifact=$artifact
		echo "Do you want to add more dependencies?(y/n)"
		read add_dependancies
	done
fi

#copy the Runner and Hooks java file to test location
echo "Copying the runner and the hooks"
mkdir ./src/test/java/support
mkdir ./src/test/java/steps
cp ../JavaFiles/TestRunner.java ./src/test/java/support/
cp ../JavaFiles/Hooks.java ./src/test/java/support/
cp ../JavaFiles/StepDef.java ./src/test/java/steps/
echo "done"

