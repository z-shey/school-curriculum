package shey.average;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;

public class SalaryTotalMapper extends Mapper<LongWritable, Text, NullWritable, Employee> {
    @Override
    protected void map(LongWritable key, Text value, Mapper<LongWritable, Text, NullWritable, Employee>.Context context) throws IOException, InterruptedException {
        String data = value.toString();
        String[] words = data.split(",");

        Employee employee = new Employee();

        employee.setEmployeeId(Integer.parseInt(words[0]));
        employee.setEmployeeName(words[1]);
        employee.setJob(words[2]);

        try {
            employee.setManager(Integer.parseInt(words[3]));
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        employee.setHireDate(words[4]);
        employee.setSalary(Integer.parseInt(words[5]));

        try {
            employee.setCommission(Integer.parseInt(words[6]));
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        employee.setDepartmentId(Integer.parseInt(words[7]));

        NullWritable nullWritable = NullWritable.get();
        Employee employeeTotal = employee;

        context.write(nullWritable, employeeTotal);
    }
}
