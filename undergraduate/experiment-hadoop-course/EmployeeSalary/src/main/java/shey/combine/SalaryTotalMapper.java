package shey.combine;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class SalaryTotalMapper extends Mapper<LongWritable, Text, IntWritable, IntWritable> {
    @Override
    protected void map(LongWritable key, Text value, Mapper<LongWritable, Text, IntWritable, IntWritable>.Context context) throws IOException, InterruptedException {
        String data = value.toString();
        String[] words = data.split(",");
        IntWritable intWritable = new IntWritable(Integer.parseInt(words[7]));
        IntWritable intWritable1 = new IntWritable(Integer.parseInt(words[5]));
        context.write(intWritable, intWritable1);
    }
}
