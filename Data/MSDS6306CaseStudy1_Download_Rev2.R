# MSDS 6306_ Case Study 1_Angela Horacek_Rev1

############################################################################
#PART I:  Download Data                                                    #
############################################################################
# Step 1:  Install Packages and download library
#install.packages("downloader")
library("downloader")

#Set working directory
setwd("C:/Users/Angela/Documents/1_SMU/Courses/MSDS6306DoingDataScience/CaseStudy1/MSDS6306_CaseStudyI/Data")


# Load the Gross Domestic Product data for the 190 ranked countries in this data set:  
download("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
         destfile="GDPcountryRaw.csv")

#Load the educational data from this data set:  
download("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
         destfile ="EducationRaw.csv") 


#Read Files and Exploratory Data Review
GDPcountryRaw <-read.csv("GDPcountryRaw.csv")

EducationRaw <- read.csv("EducationRaw.csv")


