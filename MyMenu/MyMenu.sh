#!/bin/bash 
show_menu()
{
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}**********************H1B APPLICATIONS***********************${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1.1) ${MENU} Is the number of petitions with Data Engineer job title increasing over time?${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1.2) ${MENU} Find top 5 job titles who are having highest avg growth in applications. ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2.1) ${MENU} Which part of the US has the most Data Engineer jobs for each year? ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2.2) ${MENU} Find top 5 locations in the US who have got certified visa for each year.${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3) ${MENU} Which industry(soc_name) has the most number of Certified Data Scientist positions?${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4) ${MENU} Which top 5 employers file the most petitions each year? ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5.1) ${MENU} Find the most popular top 10 job positions for H1B visa applications for each year for total applications?${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5.2) ${MENU} Find the most popular top 10 job positions for H1B visa applications for each year for for only certified applications?${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6) ${MENU} Find the percentage and the count of each case status on total applications for each year. Create a graph depicting the pattern of All the cases over the period of time.${NORMAL}"
    echo -e "${MENU}**${NUMBER} 7) ${MENU} Create a bar graph to depict the number of applications for each year${NORMAL}"
    echo -e "${MENU}**${NUMBER} 8) ${MENU}Find the average Prevailing Wage for each Job for each Year (take part time and full time separate) arrange output in descending order - [Certified and Certified Withdrawn.]${NORMAL}"
    echo -e "${MENU}**${NUMBER} 9) ${MENU} Which are employers who have the highest success rate in petitions more than 70% in petitions and total petions filed more than 1000?${NORMAL}"
    echo -e "${MENU}**${NUMBER} 10) ${MENU} Which are the top 10 job positions which have the  success rate more than 70% in petitions and total petitions filed more than 1000? ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 11) ${MENU}Export result for option no 12 to MySQL database.${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
    read opt
}
function option_picked() 
{
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE="$1"  #modified to post the correct option selected
    echo -e "${COLOR}${MESSAGE}${RESET}"
}
clear
show_menu
	while [ opt != '' ]
    do
    if [[ $opt = "" ]]; then 
            exit;
    else
        case $opt in
        1.1) clear;
        option_picked "1a) Is the number of petitions with Data Engineer job title increasing over time?";
                pig -f /home/hduser/QR1a.pig
                hadoop fs -cat /ProjectPrestn/Query1aOp/p*
        show_menu;
        ;;
        1.2) clear;
        option_picked "1b) Find top 5 job titles who are having highest growth in applications. ";
        echo -e "${MENU}Select the Case_Status${NORMAL}"
        echo -e "${MENU}**${NUMBER} 1)${MENU} CERTIFIED ${NORMAL}"
        echo -e "${MENU}**${NUMBER} 2)${MENU} CERTIFIED-WITHDRAWN ${NORMAL}"
        echo -e "${MENU}**${NUMBER} 3)${MENU} WITHDRAWN ${NORMAL}"
        echo -e "${MENU}**${NUMBER} 4)${MENU} DENIED ${NORMAL}"
            read n
	    case $n in
         1) clear;	
         option_picked "CERTIFIED";
                pig -f QR1b.pig
                 hadoop fs -cat /ProjectPrestn/Query1bCOp/p*
               ;;  
         2) clear;	
         option_picked "CERTIFIED-WITHDRAWN";
                pig -f QR1bCW.pig
                 hadoop fs -cat /ProjectPrestn/Query1bCWOp/p*
               ;;  
         3) clear;	
         option_picked "WITHDRAWN";
                pig -f QR1bW.pig
                 hadoop fs -cat /ProjectPrestn/Query1bWOp/p*
               ;; 
         4) clear;	
         option_picked "DENIED";
                pig -f QR1bD.pig
                 hadoop fs -cat /ProjectPrestn/Query1bDOp/p*
               ;;  
         *) echo "Please Select one among the option[1-4]";;
        esac
        show_menu;
        ;; 
        2.1) clear;
        option_picked "2a)Which part of the US has the most Data Engineer jobs for each year?";
		hadoop jar /home/hduser/Documents/Jars/project.jar Question2a /user/hive/warehouse/project.db/h1b_final /ProjectPrestn/Qr2a
                hadoop fs -cat /ProjectPrestn/Qr2a/p*
        show_menu;
        ;;
	    2.2) clear;
        option_picked "2b)Find top 5 locations in the US who have got certified visa for each year.";
        echo -e "Enter the year (2011,2012,2013,2014,2015,2016)"
		read var
	    hive -e " select worksite,count(worksite) as total,year from project.h1b_final where year ='$var' and case_status='CERTIFIED' group by worksite,year order by total desc limit 5;" 
        show_menu;
        ;;  
	    3) clear;
        option_picked "3) Which industry(SOC_NAME) has the most number of Data Scientist positions?[certified]";
              hadoop jar /home/hduser/Documents/Jars/project.jar Question3 /user/hive/warehouse/project.db/h1b_final /ProjectPrestn/Qr3
                hadoop fs -cat /ProjectPrestn/Qr3/p*
        show_menu;
        ;;
        4) clear;
        option_picked "4) Which top 5 employers file the most petitions each year?";
	echo -e "${MENU}Select the Case_Status${NORMAL}"
        echo -e "${MENU}**${NUMBER} 1)${MENU} CERTIFIED ${NORMAL}"
        echo -e "${MENU}**${NUMBER} 2)${MENU} CERTIFIED-WITHDRAWN ${NORMAL}"
        echo -e "${MENU}**${NUMBER} 3)${MENU} WITHDRAWN ${NORMAL}"
        echo -e "${MENU}**${NUMBER} 4)${MENU} DENIED ${NORMAL}"
            read n
	    case $n in
         1) clear;	
         option_picked "CERTIFIED";
              hadoop jar /home/hduser/Documents/Jars/project.jar Question4 /user/hive/warehouse/project.db/h1b_final /ProjectPrestn/Qr4C
                hadoop fs -cat /ProjectPrestn/Qr4C/p*
              ;;
         2) clear;	
         option_picked "CERTIFIED-WITHDRAWN";
              hadoop jar /home/hduser/Documents/Jars/project.jar Question4CW /user/hive/warehouse/project.db/h1b_final /ProjectPrestn/Qr4CW
                hadoop fs -cat /ProjectPrestn/Qr4CW/p*
              ;;
         3) clear;	
         option_picked "WITHDRAWN";
              hadoop jar /home/hduser/Documents/Jars/project.jar Question4W /user/hive/warehouse/project.db/h1b_final /ProjectPrestn/Qr4W
                hadoop fs -cat /ProjectPrestn/Qr4W/p*
              ;;
         4) clear;	
         option_picked "DENIED";
              hadoop jar /home/hduser/Documents/Jars/project.jar Question4D /user/hive/warehouse/project.db/h1b_final /ProjectPrestn/Qr4D
                hadoop fs -cat /ProjectPrestn/Qr4D/p*
              ;;
         *) echo "Please Select one among the option[1-4]";;
        esac
        show_menu;
        ;;
         
        5.1) clear;
        option_picked "5.1) Find the most popular top 10 job positions for H1B visa applications for each year for total applications?";
	    echo -e "Enter the year (2011,2012,2013,2014,2015,2016)"
		read var
		echo "For the selected year, top 10 job positions are:-";
	    hive -e "select job_title,count(job_title) as temp,year from project.h1b_final where year = '$var'  group by job_title,year order by temp desc limit 10";
        show_menu;
        ;;
        5.2) clear;
       	option_picked "5.2) Find the most popular top 10 job positions for H1B visa applications for each year for for only certified applications?";
		 hadoop jar /home/hduser/Documents/Jars/project.jar Question5b /user/hive/warehouse/project.db/h1b_final /ProjectPrestn/Qr5b
                hadoop fs -cat /ProjectPrestn/Qr5b/p*
        show_menu;
        ;;
		6) clear;
        option_picked "6) Find the percentage and the count of each case status on total applications for each year";
		pig -f /home/hduser/QR6.pig
                 hadoop fs -cat /ProjectPrestn/Query6Op/p*
        show_menu;
        ;;
		7) clear;
        option_picked "7) Create a bar graph to depict the number of applications for each year";
              hive -e " select case_status,year,count(year) from project.h1b_final group by case_status,year order by year";
               show_menu;
                ;;
                8) clear;
         option_picked "8) Find the average Prevailing Wage for each Job for each Year (take part time and full time separate). Arrange the output in descending order - [Certified and Certified Withdrawn.]";
		echo -e "Enter the year(2011,2012,2013,2014,2015,2016)"
		read year
		echo -e "Enter the choice Full time/ Part time.(Y/N)"
		read var
               echo -e "${MENU}Select the Case_Status${NORMAL}"
               echo -e "${MENU}**${NUMBER} 1)${MENU} CERTIFIED ${NORMAL}"
               echo -e "${MENU}**${NUMBER} 2)${MENU} CERTIFIED-WITHDRAWN ${NORMAL}"
            read n
	    case $n in
         1) clear;	
         option_picked "The average wage for CERTIFIED jobs are :-";
                hive -e "select job_title,full_time_position,year,avg(prevailing_wage) as average from project.h1b_final where full_time_position ='$var' and year='$year' and case_status = 'CERTIFIED' group by job_title,full_time_position,year order by average desc";
                ;;
         2) clear;	
         option_picked "The average wage for CERTIFIED-WITHDRAWN jobs are :-";
                hive -e "select job_title,full_time_position,year,avg(prevailing_wage) as average from project.h1b_final where full_time_position ='$var' and year='$year' and case_status = 'CERTIFIED-WITHDRAWN' group by job_title,full_time_position,year order by average desc";
                ;;
        *) echo "Please Select one among the option[1-2]";;
        esac
        show_menu;
        ;;
		9) clear;
		option_picked "9)Which are the employers along with the number of petitions who have the success rate more than 70%  in petitions. (total petitions filed 1000 OR more than 1000)";
		pig -f /home/hduser/QR9.pig
                hadoop fs -cat /ProjectPrestn/Query9Op/p*
        show_menu;
        ;;
		10) clear;
		option_picked "10) Which are the  job positions along with the number of petitions which have the success rate more than 70%  in petitions (total petitions filed 1000 OR more than 1000)";
		pig -f /home/hduser/QR10.pig
                  hadoop fs -cat /ProjectPrestn/Query10Op/p*
        show_menu;
        ;;
		11) clear;
		option_picked "11) Export result for question no 10 to MySql database."
		sqoop export --connect jdbc:mysql://localhost/project --username root --password 'hduser' --table h1bfinal2 --update-mode allowinsert --update-key job_title --export-dir /ProjectPrestn/Query10Op/p* --input-fields-terminated-by '\t'
                mysql -u root -p'hduser' -e 'select * from project.h1bfinal2'
        show_menu;
        ;;
		\n) exit;   
		;;
        *) clear;
        option_picked "Pick an option from the menu";
        show_menu;
        ;;
    esac
fi




done
