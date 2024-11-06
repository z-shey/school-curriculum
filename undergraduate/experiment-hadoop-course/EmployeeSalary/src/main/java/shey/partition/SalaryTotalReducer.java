package shey.partition;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.mapreduce.Reducer;

public class SalaryTotalReducer extends Reducer<IntWritable, Employee, IntWritable, IntWritable> {
    @Override
    protected void reduce(IntWritable key, Iterable<Employee> values, Reducer<IntWritable, Employee, IntWritable, IntWritable>.Context context) throws IOException, InterruptedException {
        int total = 0;
        for (Employee employee : values) {
            total += employee.getSalary();
        }
        context.write(key, new IntWritable(total));
    }
}
