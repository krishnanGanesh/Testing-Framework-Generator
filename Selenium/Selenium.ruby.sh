source ./ProjectStructure.sh

echo "Enter project Name :-"
read project
ruby_structure

#move the gemfiles
cp ../RubyFiles/Gemfile ./$project

#run bundle install
cd $project
bundle install
cd ..

