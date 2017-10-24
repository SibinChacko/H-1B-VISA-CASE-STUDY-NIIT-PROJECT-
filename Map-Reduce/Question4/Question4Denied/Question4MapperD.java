
import java.io.IOException;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class Question4MapperD extends Mapper < LongWritable, Text, Text, LongWritable > {
    LongWritable one = new LongWritable(1);
    public void map(LongWritable key, Text value, Context context) throws IOException,
    InterruptedException {
        if (key.get() > 0)

        {
            String[] token = value.toString().split("\t");
            if (token[1].equals("DENIED")) {
                Text answer = new Text(token[2] + "\t" + token[7]);
                context.write(answer, one);
            }
        }
    }
}