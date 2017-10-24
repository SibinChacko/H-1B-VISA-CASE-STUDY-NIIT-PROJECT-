register /usr/local/hive/lib/hive-exec-1.2.1.jar
register /usr/local/hive/lib/hive-common-1.2.1.jar

data = LOAD '/user/hive/warehouse/project.db/h1b_final' using PigStorage('\t') as(s_no, case_status, employer_name, soc_name, job_title:chararray, full_time_position, prevailing_wage, year:chararray, worksite, longitute, latitute);             --Load data

data = foreach data generate job_title, year;

JobFilter = filter data by $0 == 'DATA ENGINEER';

Year1= filter JobFilter  by $1 matches '2011';                                --filtering dataset by year
GroupByYear= group Year1 by $1;								--grouping by job
S1= foreach GroupByYear generate group,COUNT($1);
a= group S1 all;				                --generate year,job,count


Year1= filter JobFilter  by $1 matches '2012';                                --filtering dataset by year
GroupByYear= group Year1 by $1;								--grouping by job
S2= foreach GroupByYear generate group,COUNT($1);				--generate year,job,count
b= group S2 all;

Year1= filter JobFilter  by $1 matches '2013';                                 --filtering dataset by year
GroupByYear= group Year1 by $1;								--grouping by job
S3= foreach GroupByYear generate group,COUNT($1);				--generate year,job,count
c= group S3 all;

Year1= filter JobFilter  by $1 matches '2014';                                --filtering dataset by year
GroupByYear= group Year1 by $1;								--grouping by job
S4= foreach GroupByYear generate group,COUNT($1);				--generate year,job,count
d= group S4 all;

Year1= filter JobFilter  by $1 matches '2015';                                --filtering dataset by year
GroupByYear= group Year1 by $1;								--grouping by job
S5= foreach GroupByYear generate group,COUNT($1);				--generate year,job,count
e= group S5 all;

Year1= filter JobFilter  by $1 matches '2016';                                --filtering dataset by year
GroupByYear= group Year1 by $1;								--grouping by job
S6= foreach GroupByYear generate group,COUNT($1);				--generate year,job,count
f= group S6 all;

joined= join a by $0, b by $0, c by $0, d by $0, e by $0, f by $0;
--dump joined;
--(all,{(2011,18)},all,{(2012,32)},all,{(2013,41)},all,{(2014,89)},all,{(2015,160)},all,{(2016,251)})


combining = foreach joined generate FLATTEN($1), FLATTEN($3), FLATTEN($5), FLATTEN($7), FLATTEN($9), FLATTEN($11);
--dump combining;
--(2011,18,2012,32,2013,41,2014,89,2015,160,2016,251)

required = foreach combining generate $1,$3,$5,$7,$9,$11;
--dump required;
yearwiseapplications = foreach required generate (float)($1-$0)*100/$0,(float)($2-$1)*100/$1,(float)($3-$2)*100/$2,(float)($4-$3)*100/$3,(float)($5-$4)*100/$4;

finalCount = foreach yearwiseapplications generate ($0+$1+$2+$3+$4)/5;
--dump finalCount;
store finalCount INTO '/ProjectPrestn/Query1aOp' using PigStorage('\t');



