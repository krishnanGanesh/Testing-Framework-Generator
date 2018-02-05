#create project structure

java_structure(){
	mkdir -p ./$project/src/test/java/support
	mkdir -p ./$project/src/test/java/steps
	mkdir -p ./$project/src/test/java/resources
	mkdir -p ./$project/src/test/java/pages
	mkdir -p ./$project/src/main/java/config
	mkdir -p ./$project/src/main/java/drivers
}

ruby_structure(){
	mkdir -p ./$project/features/step_defenition
	mkdir -p ./$project/features/support
	mkdir -p ./$project/environment
}
