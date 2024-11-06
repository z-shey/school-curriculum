package shey;

/**
 * @Project: hadoop-practice
 * @File: WordCountReducer.java
 * @PACKAGE_NAME: hadoop.wordCount
 * @Version: 1.0.0
 * @Author: Shey
 * @Created: 03/20/24
 * @Modified: 03/20/24
 * @Description: WordCountReducer.java
 **/

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

/**
 * Reducer类，用于对Map阶段的结果进行汇总
 */
public class WordCountReducer extends Reducer<Text, IntWritable, Text, IntWritable> {
    /**
     * reduce方法，用于对Map阶段的结果进行汇总
     *
     * @param key     单词作为输入键
     * @param values  包含单词出现次数的值的迭代器
     * @param context 上下文对象，用于输出最终的键值对
     * @throws IOException          IO异常
     * @throws InterruptedException 中断异常
     */
    @Override
    protected void reduce(Text key, Iterable<IntWritable> values, Reducer<Text, IntWritable, Text, IntWritable>.Context context) throws IOException, InterruptedException {
        // 汇总每个单词的出现次数
        int total = 0;

        // 遍历所有值，累加总和
        for (IntWritable value : values) {
            total += value.get();
        }

        // 输出最终的键值对
        context.write(key, new IntWritable(total));
    }
}
