package shey.average;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class SalaryTotalMain {
    public static void main(String[] args) throws Exception {
        Job job = Job.getInstance();
        job.setJarByClass(SalaryTotalMain.class);

        job.setMapperClass(SalaryTotalMapper.class);
        job.setMapOutputKeyClass(NullWritable.class);
        job.setMapOutputValueClass(Employee.class);

        job.setPartitionerClass(SalaryTotalPartitioner.class);
        job.setNumReduceTasks(3);

        job.setReducerClass(SalaryTotalReducer.class);
        job.setOutputKeyClass(NullWritable.class);
        job.setOutputValueClass(Text.class);

        FileInputFormat.setInputPaths(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        job.waitForCompletion(true);
    }
}
