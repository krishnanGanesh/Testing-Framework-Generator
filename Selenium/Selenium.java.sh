#!bin/bash
set -x
set -e

#create project structure
source ./ProjectStructure.sh
echo "getting a quick start java project from,maven archetype...."
echo "enter projectName->"
read project
java_structure
echo "done"

#copy the right pom file to the current project
echo "copying the pom file"
cat ../poms/Selenium.xml > ./$project/pom.xml
echo "done"

#run a maven resolve
source if_online.sh
maven_dependency_resolve

#copy the Runner and Hooks java file to test location and Create the project structure
echo "Copying the runner and the hooks"
echo "put all your configs here over here,added an example Config.java" > ./$project/src/main/java/config/readme.txt

echo "put all your drivers over here." > ./$project/src/main/java/drivers/readme.txt
#provide option to download the driver in the future
touch ./$project/src/test/java/resources/example.feature

cp ../JavaFiles/TestRunner.java ./$project/src/test/java/support/
cp ../JavaFiles/Hooks.java ./$project/src/test/java/support/
cp ../JavaFiles/StepDefs.java ./$project/src/test/java/steps/
cp ../JavaFiles/Constants.java ./$project/src/main/java/config/
cp ../JavaFiles/Config.java ./$project/src/main/java/config/
cp ../JavaFiles/WebDriverFactory.java  ./$project/src/main/java/drivers


#setup IDE
maven_ide_setup

echo "Kindly provide the --absolute path--  of where this project should be in your system?"
read abspath
cp  -r $project $abspath/

echo "Done.....Enjoy"
