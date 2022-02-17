rm -r input
mkdir input
wget http://www.cs.binghamton.edu/~huilu/text.txt
echo "Hello Docker" >input/file2.txt
echo "Hello Hadoop" >input/file1.txt
cp text.txt input/text.txt

# create input directory on HDFS
hdfs dfs -rm -r output
hdfs dfs -rm -r input
hadoop fs -mkdir -p input
# put input files to HDFS
hdfs dfs -put ./input/* input

# run wordcount
export HADOOP_CLASSPATH=$JAVA_HOME/lib/tools.jar
hadoop com.sun.tools.javac.Main WordCount.java
jar cf wc.jar WordCount*.class
hadoop jar wc.jar WordCount input output

# print the input files
echo -e "\ninput file1.txt:"
hdfs dfs -cat input/file1.txt

echo -e "\ninput file2.txt:"
hdfs dfs -cat input/file2.txt

echo -e "\ninput text.txt:"
hdfs dfs -cat input/text.txt

# print the output of wordcount
echo -e "\nwordcount output:"
hdfs dfs -cat output/part-r-00000