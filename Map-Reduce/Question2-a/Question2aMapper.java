import java.io.IOException;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class Question2aMapper extends Mapper < LongWritable, Text, Text, LongWritable > {
    LongWritable one = new LongWritable(1);
    public void map(LongWritable key, Text values, Context context) throws IOException,
    InterruptedException {
    	try{
        if (key.get() > 0)

        {

            String[] token = values.toString().split("\t");
            if (token[4].equals("DATA ENGINEER") ) {
                Text answer = new Text(token[8] + "\t" + token[7]);
                context.write(answer, one);
            }
        }
    	}
        catch (ArrayIndexOutOfBoundsException e) {
         	 System.out.println(e.getMessage());
   		} catch (ArithmeticException e1) {
   			 System.out.println(e1.getMessage());
   		
   	  }

    }

}