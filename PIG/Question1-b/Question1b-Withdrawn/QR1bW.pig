register /usr/local/hive/lib/hive-exec-1.2.1.jar
register /usr/local/hive/lib/hive-common-1.2.1.jar

data2 = LOAD '/user/hive/warehouse/project.db/h1b_final' using PigStorage('\t') as(s_no:int, case_status:chararray, employer_name:chararray, soc_name:chararray, job_title:chararray, full_time_position:chararray, prevailing_wage:int, year:chararray, worksite:chararray, longitute:double, latitute:double);			--Load data

RemoveHeader= filter data2 by $0>=1;		--Remove header 

statusMatch = filter RemoveHeader by $1 == 'WITHDRAWN';

A= filter statusMatch by $7 matches '2011'; --filtering dataset by year
a= group A by $4;								--grouping by job
A1= foreach a generate group,COUNT($1);				--generate year,job,count


A= filter statusMatch  by $7 matches '2012'; --filtering dataset by year
a= group A by $4;								--grouping by job
A2= foreach a generate group,COUNT($1);				--generate year,job,count


A= filter statusMatch  by $7 matches '2013'; --filtering dataset by year
a= group A by $4;								--grouping by job
A3= foreach a generate group,COUNT($1);				--generate year,job,count


A= filter statusMatch  by $7 matches '2014'; --filtering dataset by year
a= group A by $4;								--grouping by job
A4= foreach a generate group,COUNT($1);				--generate year,job,count

A= filter statusMatch  by $7 matches '2015'; --filtering dataset by year
a= group A by $4;								--grouping by job
A5= foreach a generate group,COUNT($1);				--generate year,job,count


A= filter statusMatch  by $7 matches '2016'; --filtering dataset by year
a= group A by $4;								--grouping by job
A6= foreach a generate group,COUNT($1);				--generate year,job,count


joined2= join A1 by $0, A2 by $0, A3 by $0, A4 by $0, A5 by $0, A6 by $0;
yearwiseapplications= foreach joined2 generate $0,$1,$3,$5,$7,$9,$11;


--generate progressive growth
progressivegrowth= foreach yearwiseapplications  generate $0, (float)($6-$5)*100/$5, (float)($5-$4)*100/$4, (float)($4-$3)*100/$3, (float)($3-$2)*100/$2, (float)($2-$1)*100/$1;

--average progressive growth
avgprogressivegrowth= foreach progressivegrowth generate $0,($1+$2+$3+$4+$5)/5;
---ordered progressive growth
orderedavggrowth= order avgprogressivegrowth by $1 desc;
--display top5 only
answer = limit orderedavggrowth  5;
--dump answer;
store answer INTO '/ProjectPrestn/Query1bWOp' using PigStorage('\t');

