package shey;

/**
 * @Project: hadoop-practice
 * @File: WordCountMain.java
 * @PACKAGE_NAME: hadoop.wordCount
 * @Version: 1.0.0
 * @Author: Shey
 * @Created: 03/20/24
 * @Modified: 03/20/24
 * @Description: WordCountMain.java
 **/

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

/**
 * WordCount程序的入口类
 */
public class WordCountMain {
    /**
     * 主函数
     *
     * @param args 命令行输入参数
     * @throws Exception 异常
     */
    public static void main(String[] args) throws Exception {
        // 创建一个Job
        Job job = Job.getInstance(new Configuration());
        job.setJarByClass(WordCountMain.class); // 设置JAR包的主类

        // 设置输出类型
        job.setMapperClass(WordCountMapper.class); // 设置Mapper类
        job.setMapOutputKeyClass(Text.class); // 设置Mapper类的输出Key类型
        job.setMapOutputValueClass(IntWritable.class); // 设置Mapper类的输出Value类型

        // 设置Reducer类
        job.setReducerClass(WordCountReducer.class); // 设置Reducer类
        job.setOutputKeyClass(Text.class); // 设置Reducer类的输出Key类型
        job.setOutputValueClass(IntWritable.class); // 设置Reducer类的输出Value类型

        // 设置输入输出
        FileInputFormat.setInputPaths(job, new Path(args[0])); // 设置输入路径
        FileOutputFormat.setOutputPath(job, new Path(args[1])); // 设置输出路径

        // 提交Job
        job.waitForCompletion(true);
    }
}
