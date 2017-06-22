
library(data.table)
library(dplyr)
library(rjson)
library(ggplot2)
library(shiny)
library(shinydashboard)

projectDir<-'D:/Applied/N start/dump/data-challenge-data-master/data'
if(getwd()!=projectDir){
  setwd(projectDir)  
}

loanData<-suppressWarnings(data.frame(fread('./2012_to_2014_loans_data.csv',na.strings=c(NA,""," "))))
instData<-suppressWarnings(data.frame(fread('./2012_to_2014_institutions_data.csv',na.strings=c(NA,""," "))))

hmdaData <-inner_join(loanData,instData,c("Respondent_ID","Agency_Code","As_of_Year"))

hmdaData <- hmdaData%>%
  filter(Respondent_Name_TS != 'MEGACHANGE MORTGAGE')

# Structre of data
# str(hmdaData)

# Converting the Applicant_Income_00 to numeric
hmdaData$Loan_Amount_000<-as.numeric(hmdaData$Loan_Amount_000)
hmdaData$Applicant_Income_000<-as.numeric(hmdaData$Applicant_Income_000)

# Converting the coded variables as factor varibales
hmdaData$Agency_Code <- as.factor(hmdaData$Agency_Code)
hmdaData$As_of_Year <- as.factor(hmdaData$As_of_Year)
hmdaData$County_Code <- as.factor(hmdaData$County_Code)

