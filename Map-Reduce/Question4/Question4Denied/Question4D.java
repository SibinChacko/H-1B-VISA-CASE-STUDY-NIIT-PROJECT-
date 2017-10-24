
import java.io.IOException;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class Question4D {

    public static void main(String args[]) throws IOException, InterruptedException, ClassNotFoundException

    {
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "Top  5 Employers");

        job.setJarByClass(Question4D.class);
        job.setMapperClass(Question4MapperD.class);
        job.setPartitionerClass(Question4PartitionerD.class);
        job.setReducerClass(Question4ReducerD.class);

        job.setNumReduceTasks(6);

        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(LongWritable.class);

        job.setOutputKeyClass(NullWritable.class);
        job.setOutputValueClass(Text.class);

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);

    }

}