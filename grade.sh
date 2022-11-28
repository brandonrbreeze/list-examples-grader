# Create your grading script here

rm -rf student-submission
git clone $1 student-submission > null 2> null


cp TestListExamples.java student-submission > null 2> null

cp -r ./lib student-submission > null 2> null



cd student-submission

if [[ -f "./ListExamples.java" ]]

    then
        echo "File found"

    else 
        echo "File not found"
        echo "No Credit Given"
        exit 1

fi

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java 2> error.txt


if [[ $? -eq 0 ]]
    then 
        echo "Compiled successfully"
    else
     echo "failed to compile"
     cat error.txt
     echo "No Credit given!!"
     exit 1
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > results.txt 2> error.txt 

if [[ $? -ne 0 ]]
    then 
        echo "Runtime error!!! exited early!"
        cat error.txt
        cat results.txt
        grep "Tests run" results.txt
fi

if grep "Failures" results.txt > null
    then 
        grep "Tests run:" results.txt
        if grep "merge" results.txt > null 
            then 
                echo "Tests failed on merge"
        fi
        if grep "filter" results.txt > null 
            then 
                echo "Tests failed on filter"
        fi
    else
        echo "Great job all tests passed!"
        
fi