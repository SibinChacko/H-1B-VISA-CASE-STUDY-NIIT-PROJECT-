# H-1B-VISA-CASE-STUDY-NIIT-PROJECT 
------------------------------------
The H-1B Visa is an employment-based, non-immigrant Visa category for temporary foreign workers in the United States. For a foreign national to apply for H-1B visa, an US employer must offer a job and petition for H-1B visa with the US immigration department. This is the most common visa status applied for and held by international students once they complete college/ higher education (Masters, Ph.D.) and work in a full-time position. In this report, we attempt to predict the status of the visa petition based on the visa-application metadata. The intent of this study is to discover how visa status outcome is inﬂuenced by attributes of user application. The classiﬁer designed in this report could be utilized by both, H-1B aspirants and employers, to gauge the likelihood of visa certiﬁcation, before and after ﬁling the petition.

# We have to perform the followings queries on the given dataset of H-1B VISA for the year 2011-2016 :-
---------------------------------------------------------------------------------------------------
1 a) Is the number of petitions with Data Engineer job title increasing over time?
   b) Find top 5 job titles who are having highest average growth in applications.[ALL]

2 a) Which part of the US has the most Data Engineer jobs for each year?
   b) Find top 5 locations in the US who have got certified visa for each year.[Certified]

3)   Which Industry(SOC_NAME) has the most number of Data Scientist positions?
      [Certified]

4)   Which top 5 employers file the most petitions each year? - Case Status - ALL

5)   Find the most popular top 10 job positions for H1B visa applications for each year?
a)   For all the applications
b)   For only certified applications.

6)   Find the percentage and the count of each case status on total applications for each year. Create     a line graph depicting the pattern of All the cases over the period of time.

7)   Create a bar graph to depict the number of applications for each year [All]

8)  Find the average Prevailing Wage for each Job for each Year (take part time and full time    separate). Arrange the output in descending order - [Certified and Certified Withdrawn.]

9)  Which are the employers along with the number of petitions who have the success rate more than 70%  in petitions. (Total petitions filed 1000 OR more than 1000) ?

10) Which are the  job positions along with the number of petitions which have the success rate more than 70%  in petitions (Total petitions filed 1000 OR more than 1000)?

11)  Export result for question no 10 to MySql database.
_________________________________________________________________________________________________________________________________

# [SUCCESS RATE % = (Certified + Certified Withdrawn)/Total x 100]

The dataset has nearly 3 million records. The dataset description is as follows: The columns in the dataset include:
# CASE_STATUS: 
Status associated with the last significant event or decision.
Valid values include "**Certified","Certified-Withdrawn","Denied**"and"**Withdrawn**".
**Certified**          : Employer filed the LCA, which was approved by DOL
**Certified Withdrawn**: LCA was approved but later withdrawn by employer
**Withdrawn**          : LCA was withdrawn by employer before 
**Denied**             : LCA was denied by DOL

**EMPLOYER_NAME**: Name of employer submitting labour condition application.
**SOC_NAME**: the Occupational name associated with the SOC_CODE. SOC_CODE is the occupational code associated with the job being requested for temporary labour condition, as classified by the Standard Occupational Classification (SOC) System.
**JOB_TITLE**: Title of the job
**FULL_TIME_POSITION**: 
**Y**= Full Time Position;
**N** = Part Time Position
**PREVAILING_WAGE**: Prevailing Wage for the job being requested for temporary labour condition. The wage is listed at annual scale in USD. The prevailing wage for a job position is defined as the average wage paid to similarly employed workers in the requested occupation in the area of intended employment. The prevailing wage is based on the employer’s minimum requirements for the position. 
**YEAR**: Year in which the H1B visa petition was filed
**WORKSITE**: City and State information of the foreign worker’s intended area of employment
**Longitude**: longitude of the Worksite
**Latitude**: latitude of the Worksite

In the data, few columns are enclosed by double quotes and also we have comma’s in a single column and the column is enclosed by double quotes. So we have used hive csv serve to load the data. In the quoteChar, we have given “(double quote). So this will take the column value in between the double quotes. Use all the following tools :-
**MapReduce** - any 4 programs
**Hive**- any 4 programs
**Pig**- any 4 programs

**Case Status**
1.Certified
2.Certified-Withdrawn
3.Denied
4.Withdrawn

