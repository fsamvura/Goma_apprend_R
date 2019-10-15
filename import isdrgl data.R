Etudiants<- read.csv("H:/ISDR-GL/Data/edusys/Etudiants.csv")
FeesPayment<- read.csv("H:/ISDR-GL/Data/edusys/FeesPayment.csv")
Tlevel<- read.csv("H:/ISDR-GL/Data/edusys/Tlevel.csv")
additional_reg<- read.csv("H:/ISDR-GL/Data/edusys/additional_reg.csv")
assignment<- read.csv("H:/ISDR-GL/Data/edusys/assignment.csv")
communication<- read.csv("H:/ISDR-GL/Data/edusys/communication.csv")
config_docs<- read.csv("H:/ISDR-GL/Data/edusys/config_docs.csv")
config_gen<- read.csv("H:/ISDR-GL/Data/edusys/config_gen.csv")
course<- read.csv("H:/ISDR-GL/Data/edusys/course.csv")
debts<- read.csv("H:/ISDR-GL/Data/edusys/debts.csv")
debtspayment<- read.csv("H:/ISDR-GL/Data/edusys/debtspayment.csv")
document<- read.csv("H:/ISDR-GL/Data/edusys/document.csv")
downloads<- read.csv("H:/ISDR-GL/Data/edusys/downloads.csv")
fees<- read.csv("H:/ISDR-GL/Data/edusys/fees.csv")
grid<- read.csv("H:/ISDR-GL/Data/edusys/grid.csv")
msg<- read.csv("H:/ISDR-GL/Data/edusys/msg.csv")
optionalfees<- read.csv("H:/ISDR-GL/Data/edusys/optionalfees.csv")
options<- read.csv("H:/ISDR-GL/Data/edusys/options.csv")
timetable<- read.csv("H:/ISDR-GL/Data/edusys/timetable.csv")
timetable_s<- read.csv("H:/ISDR-GL/Data/edusys/timetable_s.csv")
unity<- read.csv("H:/ISDR-GL/Data/edusys/unity.csv")
registration<- read.csv("H:/ISDR-GL/Data/edusys/registration.csv")
users<- read.csv("H:/ISDR-GL/Data/edusys/users.csv")

library(dplyr)
library(sqldf)
full_users<- sqldf("select a.*, b.* from users as a, registration as b where a.usersid=b.usersid")
full_u_fees<- sqldf("select a.*, b.* from full_users as a, FeesPayment as b where a.regid=b.regid")
Users %>% freq(school)
install.packages("sqldf")
library(summarytools)
attend <- table(Etudiants$promotion,Etudiants$faculte)
attend
summarytools::freq(Users$school)
top_stud<-Etudiants[Etudiants$resultat>69,]
df <- data.frame(table(top_stud$ecole))
df[rev(order(df$Freq)),]
getwd()

library(lubridate) # Recall the library lubridate

a<-year(FeesPayment$pdate) # Only years are extracted

b<-month(FeesPayment$pdate) # Only months are extracted

# Now you can combine using paste() function

FeesPayment$p_year_month<-paste(a,b,sep= "-")
add_promo<-full_join(FeesPayment %>%
  group_by(regid, p_year_month) %>%
  summarise(tot_paid = sum(paid)) %>%
  arrange(regid, p_year_month),registration,by="regid")
month_pay<-add_promo%>%
  group_by(p_year_month, reg_level) %>%
  summarise(av_paid = mean(tot_paid)) %>%
  arrange(p_year_month, reg_level)
library(tidyverse)
clean_m_pay<-month_pay%>%filter(str_detect(p_year_month,"2017|2018|2019"))
sum17<-clean_m_pay%>%filter(str_detect(p_year_month,"2017"))
sum_year <- table(sum17$reg_level,sum17$p_year_month)
sum_year
####
fees %>%group_by(fees_year, fees_level) %>%summarise(amount = sum(amount))
#Focus on 2018
filter(FeesPayment, regid==7550) %>%summarise(amount = sum(paid))

# write out text datafile and
# an SAS program to read it
install.packages("foreign")
library(foreign)
write.foreign(FeesPayment, "F:/MyFiles/SAS Files/FeesPayment.txt", "F:/MyFiles/SAS Files/FeesPayment.sas",   package="SAS")
write.foreign(clean_m_pay, "F:/MyFiles/SAS Files/clean_m_pay.txt", "F:/MyFiles/SAS Files/clean_m_pay.sas",   package="SAS")


