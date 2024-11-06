package shey;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;
import java.util.Arrays;

public class SogouMapper extends Mapper<LongWritable, Text, Text, NullWritable> {
    @Override
    protected void setup(Mapper<LongWritable, Text, Text, NullWritable>.Context context) throws IOException, InterruptedException {
        super.setup(context);
    }

    @Override
    protected void map(LongWritable key, Text value, Mapper<LongWritable, Text, Text, NullWritable>.Context context) throws IOException, InterruptedException {
        String data = new String(value.getBytes(), 0, value.getLength(), "GBK");

        String words[] = data.split("\\s+");

        if (words.length != 6) {
            // 过滤掉不符合要求的行
            return;
        }

        String newData = data.replaceAll("\\s+", ",");

        context.write(new Text(newData), NullWritable.get());
    }

    @Override
    protected void cleanup(Mapper<LongWritable, Text, Text, NullWritable>.Context context) throws IOException, InterruptedException {
        super.cleanup(context);
    }
}
