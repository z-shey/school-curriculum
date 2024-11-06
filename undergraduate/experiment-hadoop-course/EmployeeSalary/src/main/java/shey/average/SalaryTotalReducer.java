package shey.average;

import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

import java.io.IOException;

public class SalaryTotalReducer extends Reducer<NullWritable, Employee, NullWritable, Text> {
    @Override
    protected void reduce(NullWritable key, Iterable<Employee> values, Reducer<NullWritable, Employee, NullWritable, Text>.Context context) throws IOException, InterruptedException {
        String line = null;

        for (Employee value : values) {
            line = value.toString();
            context.write(key, new Text(line));
        }
    }
}
