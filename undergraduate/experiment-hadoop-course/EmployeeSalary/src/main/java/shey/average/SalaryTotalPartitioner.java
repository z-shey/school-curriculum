package shey.average;

import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.mapreduce.Partitioner;

public class SalaryTotalPartitioner extends Partitioner<NullWritable, Employee> {
    @Override
    public int getPartition(NullWritable nullWritable, Employee employee, int i) {
        if (employee.getSalary() < 1500) {
            return 1 % i;
        } else if (employee.getSalary() >= 1500 && employee.getSalary() < 3000) {
            return 2 % i;
        } else {
            return 3 % i;
        }
    }
}
