package shey;

/**
 * @Project: hadoop-practice
 * @File: WordCountMapper.java
 * @PACKAGE_NAME: hadoop.wordCount
 * @Version: 1.0.0
 * @Author: Shey
 * @Created: 03/20/24
 * @Modified: 03/20/24
 * @Description: WordCountMapper.java
 **/

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;


/**
 * Mapper类，实现自定义的map函数
 * 输入数据格式为：一行一串单词，单词之间用空格分隔
 * 输出数据格式为：<单词,出现次数>
 */
public class WordCountMapper extends Mapper<LongWritable, Text, Text, IntWritable> {
    /**
     * map函数
     *
     * @param key     输入键
     * @param value   输入值
     * @param context 上下文对象，用于输出键值对
     * @throws IOException          IO异常
     * @throws InterruptedException 中断异常
     */
    @Override
    protected void map(LongWritable key, Text value, Mapper<LongWritable, Text, Text, IntWritable>.Context context) throws IOException, InterruptedException {
        // 将输入的文本内容转换为字符串
        String[] words = value.toString().split(" ");

        // 输出键值对
        for (String word : words) {
            context.write(new Text(word), new IntWritable(1));
        }
    }
}
