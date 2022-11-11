# Create your grading script here

# set -e

CPATH=".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar"

rm -rf student-submission
git clone $1 student-submission
cp TestListExamples.java student-submission/

cp -r lib/ student-submission/lib/

cd student-submission

# checks to see if ListExamples.java exists in student-submission
if [[ -e "ListExamples.java" ]] 
then 
    echo "file exists." 
else 
    echo "ListExamples.java does not exist." 
fi

 # check to see if it compiles
javac ListExamples.java

if [[ $? -eq 0 ]]
then 
    echo "Compile success!" 
else 
    echo "Compile error." 
fi

javac -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > fileOutput.txt

grep "FAILURES!!!" fileOutput.txt > fail.txt
grep "OK" fileOutput.txt > correct.txt

if [[ $? -eq 0 ]]
then
    echo "score: 2/2"
else
    echo ""
fi

echo "grader finished."
exit