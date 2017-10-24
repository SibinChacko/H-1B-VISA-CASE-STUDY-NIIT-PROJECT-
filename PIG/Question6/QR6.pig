register /usr/local/hive/lib/hive-exec-1.2.1.jar
register /usr/local/hive/lib/hive-common-1.2.1.jar

data = LOAD '/user/hive/warehouse/project.db/h1b_final' using PigStorage('\t') as(s_no:int, case_status:chararray, employer_name:chararray, soc_name:chararray, job_title:chararray, full_time_position:chararray, prevailing_wage:int, year:chararray, worksite:chararray, longitute:double, latitute:double);

RemoveHeader= filter data by $0>=1;   

A= group RemoveHeader by $7;
B= foreach A generate group,COUNT(RemoveHeader.$1);

RemoveHeader= filter data by $0>=1;

A= group RemoveHeader by ($7,$1);
YearCount= foreach A generate group,group.$0,COUNT($1);

joined= join YearCount by $1,B by $0;
final= foreach joined generate FLATTEN($0),(float)($2*100)/$4,$2; 
--dump final;
store final INTO '/ProjectPrestn/Query6Op' using PigStorage('\t');

