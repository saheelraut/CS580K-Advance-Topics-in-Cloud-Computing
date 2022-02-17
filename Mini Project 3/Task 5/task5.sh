rm -r input
mkdir input
echo "1
23
12
65
53
8
16
90
16
44
86
69
31
8
73
81
73
94
2
36
62
50
41
24
36
66
39
69
63
67
39
89
79
61
46
97
41
36
61
65" >input/text.txt

# create input directory on HDFS
hdfs dfs -rm -r output
hdfs dfs -rm -r input
hadoop fs -mkdir -p input
# put input files to HDFS
hdfs dfs -put ./input/* input

# run wordcount
export HADOOP_CLASSPATH=$JAVA_HOME/lib/tools.jar
hadoop com.sun.tools.javac.Main AvgMapred.java
jar cf wc.jar AvgMapred*.class 
hadoop jar wc.jar AvgMapred input output

# print the input files

echo -e "\ninput text.txt:"
hdfs dfs -cat input/text.txt

# print the output of wordcount
echo -e "\noutput:"
hdfs dfs -cat output/part-r-00000