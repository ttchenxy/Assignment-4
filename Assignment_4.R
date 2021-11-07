#Name:CHEN YING
#Student ID:91218627


if(!file.exists("C:\\Users\\inha\\Desktop\\mycode")){
  dir.create("C:\\Users\\inha\\Desktop\\mycode")
  
}
my.dat1<- read.csv("C:\\Users\\inha\\Desktop\\mycode\\food-price-index-September-2021-index-numbers-csv-tables.csv")

########################Overview data#########################
class(my.dat1)
head(my.dat1)
dim(my.dat1)
colnames(my.dat1)
str(my.dat1)

####################### Melting data frame ##############################

install.packages("reshape2")
library(reshape2)
head(my.dat1)
datMelt<- melt(my.dat1,id=c("Series_reference","Period","STATUS"),measure.vars="Data_value",na.rm = FALSE)
head(datMelt)
tail(datMelt,n=3)

######################casting data####################################

mydata<- dcast(datMelt,Period~variable,mean)
mydata

##############################Records###########################

library(plyr)
record_count<- function(df){
  return(data.frame(count=nrow(df)))
}
ddply(my.dat1,.(Period),record_count)
summary(my.dat1)

#########################creat data tables##################

install.packages("data.table")
library(data.table)
my.dat2= fread("C:\\Users\\inha\\Desktop\\mycode\\food-price-index-September-2021-index-numbers-csv-tables.csv")
names(my.dat2)

dt=data.table(a=c("A","B"),b=c("Period","Data_value"))
tables()
dt
dt[2,]
dt[,w:=b^2]   #add a row of w

#######################writing data frames to JSON and convert back to JSON###################

library(jsonlite)
myjson<- toJSON(my.dat1,pretty = TRUE)
cat(myjson)

my.dat3<- fromJSON(myjson)
head(my.dat3)

########################################factor function#######################

#a<- split(my.dat1$Series_reference,my.dat1$Series_title_1)           testing
#sapply(a,mean)

Series_title_1<- factor(my.dat1$Series_title_1,order=TRUE)
Series_title_1

########################factor on 10weeks########################

data2 <- factor(my.dat1$Series_title_1)
data2[1:100]
class(data2)

###############sapply-->average values############################################

tapply(my.dat1$Data_value,my.dat1$Series_title_1,mean)   #using tapply test

data3=split(my.dat1$Data_value,my.dat1$Series_title_1)
data3

data4=lapply(data3,sum)
data4

unlist(data4)
sapply(data3,mean)  #same result








