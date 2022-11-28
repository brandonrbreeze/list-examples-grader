# Create your grading script here

rm -rf student-submission
git clone $1 student-submission


cp TestListExamples.java student-submission

cp -r ./lib student-submission



cd student-submission

if [[ -f "./ListExamples.java" ]]

    then
        echo "File found"

    else 
        echo "File not found"
        exit 1

fi

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java

if [[ $? -eq 0 ]]
    then 
        echo "succeeded"
    else
     echo "failed"
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > results.txt

grep "Tests run" results.txt