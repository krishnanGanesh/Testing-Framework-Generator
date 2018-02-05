#!bin/bash

if_online(){
    ping -c 1 -q  "repo.maven.apache.org"   
}

maven_dependency_resolve(){
    if if_online; then    
        #run a maven resolve
        echo "downloading the dependancy"
        cd ./$project
        mvn dependency:resolve
        cd ..
        echo "done"

        #ask for any additional dependancies(why?.cause I can!!)
        add_dependancies="y"
        echo "Do you have other dependencies you want to add now?(y/n)(will not be added to the pom)"
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
    fi
}

maven_ide_setup(){
    if if_online; then
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
    fi
}