package shey.partition;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.mapreduce.Partitioner;

public class SalaryTotalPartitioner extends Partitioner<IntWritable, Employee> {
    @Override
    public int getPartition(IntWritable intWritable, Employee employee, int i) {
        if (employee.getDepartmentId() == 10) {
            return 1 % i;
        } else if (employee.getDepartmentId() == 20) {
            return 2 % i;
        } else {
            return 3 % i;
        }
    }
}
