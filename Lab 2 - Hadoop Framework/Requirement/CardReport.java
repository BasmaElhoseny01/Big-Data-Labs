import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;


public class CardReport {
    //Mapper
    public static class CustomerMapper extends Mapper<Object,Text,Text,IntWritable>{
        // [Word Count Example] In the case of text-based input formats like TextInputFormat, each input record typically corresponds to a line of text.
        // [Case of CSV file ]The map function in Hadoop's Mapper class processes one input record at a time. 
        // So in that example each mapper function will have imput to be row with ID and Card_Value

        private Text customer_id  = new Text();
        private IntWritable card_value = new IntWritable();

        //Overriding the function map from the Mapper Class
        public void map(Object key,Text value,Context context) throws IOException,InterruptedException {

            // Split the CSV line into fields
            String[] fields = value.toString().split(",");

            // Setting Key
            // Convert string to integer parseInt
            // int customer_id_intValue = Integer.parseInt(fields[0]);
            customer_id.set(fields[0]);

            // Setting Value
            // Convert string to integer parseInt
            int card_value_intValue = Integer.parseInt(fields[1]);
            card_value.set(card_value_intValue);


            //Writting <Key,Value> to the context
            context.write(customer_id,card_value);
        }
    }    
    
    
    //Reducer
    public static class  SumReducer extends Reducer<Text,IntWritable,Text,IntWritable>{

        private IntWritable total = new IntWritable();

        //Overriding the function reduce from the Mapper Class
        public void reduce(Text key,Iterable<IntWritable> values,Context context) throws IOException,InterruptedException{
            int sum=0;
            // Summation of all the card values for that customer
            for (IntWritable val : values){
                // Using .get IntWritable --> int :D
                sum+=val.get();
            }
            total.set(sum);
            context.write(key,total);
        }
    }

    // Main
    public static void main(String[] args) throws Exception {
        // The Configuration for the Hadoop framework when executing jobs
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "card count");
        job.setJarByClass(CardReport.class);

        job.setMapperClass(CustomerMapper.class);
        job.setCombinerClass(SumReducer.class);
        job.setReducerClass(SumReducer.class);

        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }

}
