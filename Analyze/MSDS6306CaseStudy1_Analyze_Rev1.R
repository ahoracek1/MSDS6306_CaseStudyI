# MSDS6306_CaseStudy1_Analyze_Rev1
# Angela Horacek

############################################################################
#PART III:  ANALYZE THE DATA                                               #
############################################################################


#######################################
# STEP 1: SET WORKING DIRECTORY       #
#######################################

setwd("C:/Users/Angela/Documents/1_SMU/Courses/MSDS6306DoingDataScience/CaseStudy1/MSDS6306_CaseStudyI/Analyze")


######################################
# STEP 2: ANALYZE THE DATA           #
######################################

# Question 1:   Determine how many IDs will match by subtract.
MatchingIDs <- nrow(MergeData1)
MatchingIDs
# Answer: There are 189 matching IDs. 



# QUESTION 2A:  Sort the data frame in ascending order by GDP(so United States
#is last).  
MergeData1Sorted <-MergeData1[order(MergeData1$GDP), ]
View(MergeData1Sorted)

#QUESTION 2B:  What is the 13th country in the resulting data frame?
Country13th <- MergeData1Sorted$CountryName[13]
Country13th
#Answer 2B:  The 13th country from the sorted data is St. Kitts and Nevis. 


# QUESTION 3:  What are the average GDP rankings for the "High income:OECD" 
# and "High income:nonOECD" groups.

AvgGDPRanking.HIOECD <- mean(MergeData1$GDPRanking[MergeData1$Income.Group 
                                                   == "High income: OECD"]) 
AvgGDPRanking.HIOECD
# ANSWER 3A. The average GDP rankings for the "High income: OECD" group is 32.97.


AvgGDPRanking.HInonOECD <-mean(MergeData1$GDPRanking[MergeData1$Income.Group 
                                                     == "High income: nonOECD"])
AvgGDPRanking.HInonOECD
# ANSWER 3B.  The average GDP rankings for the "High income: nonOECD" group 
# is 91.91.


# QUESTION #4: Plot the GDP for all of the countries.  Use ggplot2 to color 
# your plot by Income Group.
library(ggplot2)
library(dplyr)

GDPvsIncomeGroup <- MergeData1[ ,c("GDP", "Income.Group")]
View(GDPvsIncomeGroup)

GDPvsIncomeGroupSorted <-GDPvsIncomeGroup[order(GDPvsIncomeGroup$Income.Group), ]
View(GDPvsIncomeGroupSorted)

#Find the mean of all groups of Income Group

DataMean <- GDPvsIncomeGroup %>% group_by(Income.Group) %>% summarise(mean(GDP))
DataMean

names(DataMean)[1] <- "Income.Group"
names(DataMean)[2] <- "MeanGDP"
DataMean


ggplot(data=GDPvsIncomeGroupSorted, aes(x=GDP, fill=Income.Group, alpha=0.2, 
    colour=Income.Group)) + geom_density() + scale_x_log10() + 
    geom_vline(data=DataMean,aes(xintercept=MeanGDP, colour=Income.Group, 
    show.legend=TRUE), linetype= "dashed", size=1)+
    ggtitle("GDP Density Distribution by Income Group")+ xlab("GDP (millions)")+ theme_bw()



ggplot(data=GDPvsIncomeGroupSorted, aes(x=GDP, fill=Income.Group, alpha=0.2, 
    colour=Income.Group)) + geom_histogram(alpha=.5, position="Identity") 

+ 
    geom_vline(data=DataMean,aes(xintercept=MeanGDP, colour=Income.Group, 
    show.legend=TRUE), linetype= "dashed", size=1)+
    ggtitle("GDP Histogram Distribution by Income Group")+ xlab("GDP (millions)")+ theme_bw()



ggplot(data=GDPvsIncomeGroupSorted, aes(x=GDP, fill=Income.Group,
    alpha=0.2, colour=Income.Group)) + geom_density() + scale_x_log10() 
    + theme_bw() + ggtitle("GDP Distribution by Income Group")+  + xlab("GDP (millions)")



ggplot(data=GDPvsIncomeGroup,matching = aes(x=GDP, fill=Income.Group,
            alpha=0.3, color=Income.Group)) + geom_histogram(binwidth=10)+labs(x="GDP(millions)")



#QUESTION #5:  Cut the GDP ranking into 5 separate quantile groups.  Make a table
# versus Income.Group.  How many countries are Lower middle income but among the 
# 38 nations with the highest GDP?
QuantileGroups <- quantile(MergeData1$GDPRanking)
QuantileGroups
MergeData1$GDPRankingQuantileGroup <- cut(MergeData1$GDPRanking, breaks = QuantileGroups)
IncGroupQuantile <- MergeData1[ ,c("Income.Group", "GDPRankingQuantileGroup")]
IncGroupQuantile.table <-table(IncGroupQuantile)
IncGroupQuantile.table
IncGroupQuantile.table[5,4]

#ANSWER: The number of countries that are Lower Middle Income but among the 38 
# nations with the highest GDP is 17. 

