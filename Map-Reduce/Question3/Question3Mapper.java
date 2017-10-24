import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
public class Question3Mapper extends Mapper < LongWritable, Text, Text, LongWritable > {
   
    public void map(LongWritable key, Text values, Context context) throws IOException,
    InterruptedException {
    	try{
        if (key.get() > 0) {
        	long count = 0;
            String[] token = values.toString().split("\t");
            
            if (token[4].equals ("DATA SCIENTIST")) {
            	 if (token[1].equals("CERTIFIED")) {
                Text answer = new Text(token[3]);
                count++;
                context.write(answer, new LongWritable(count));
            }
        }
        }
    	}catch (IndexOutOfBoundsException e) {
        	 System.out.println(e.getMessage());
  		} catch (ArithmeticException e1) {
  			 System.out.println(e1.getMessage());
  		
  		}
    }
}