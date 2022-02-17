rm -r input
mkdir input
wget http://www.cs.binghamton.edu/~huilu/text.txt
echo "Hello Docker" >input/file2.txt
echo "Hello Hadoop" >input/file1.txt
mv text.txt input/text.txt

# create input directory on HDFS
hdfs dfs -rm -r output
hdfs dfs -rm -r input
hadoop fs -mkdir -p input
# put input files to HDFS
hdfs dfs -put ./input/* input

# run wordcount
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/sources/hadoop-mapreduce-examples-2.7.2-sources.jar org.apache.hadoop.examples.WordCount input output

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
