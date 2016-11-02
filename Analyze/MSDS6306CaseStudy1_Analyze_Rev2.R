###########################################################################
# MSDS6306CaseStudy1_Analyze_Rev2.R, Angela Horacek                       # 
###########################################################################                                          
#                                                                         # 
# PART III: ANALYZE THE DATA                                              #
#                                                                         #    
###########################################################################



#######################################################
# STEP 1: SET WORKING DIRECTORY AND INSTALL LIBRARIES #
#######################################################

#Set working directory so the file is in the Analyze Folder.
setwd("C:/Users/Angela/Documents/1_SMU/Courses/MSDS6306DoingDataScience/CaseStudy1/MSDS6306_CaseStudyI/Analyze")

#Install Libraries.
library(ggplot2)
library(dplyr)

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


#QUESTION 2B:  What is the 13th country in the resulting data frame?
Country13th <- MergeData1Sorted$CountryName[13]
Country13th
#Answer 2B:  The 13th country from the sorted data is St. Kitts and Nevis. 


# QUESTION 3:  What are the average GDP rankings for the "High income:OECD" 
# and "High income:nonOECD" groups.

AvgGDPRanking.HIOECD <- mean(MergeData1$GDPRanking[MergeData1$Income.Group 
                                                   == "High income: OECD"]) 
AvgGDPRanking.HIOECD
# ANSWER 3A. The average GDP ranking for the "High income: OECD" group is 32.97.


AvgGDPRanking.HInonOECD <-mean(MergeData1$GDPRanking[MergeData1$Income.Group 
                                                     == "High income: nonOECD"])
AvgGDPRanking.HInonOECD
# ANSWER 3B.  The average GDP rankings for the "High income: nonOECD" group 
# is 91.91.


# QUESTION #4: Plot the GDP for all of the countries.  Use ggplot2 to color 
# your plot by Income Group.

# Step 4A:  Create a dataset with GDP and Income.Group
GDPvsIncomeGroup <- MergeData1[ ,c("GDP", "Income.Group")]
GDPvsIncomeGroupSorted <-GDPvsIncomeGroup[order(GDPvsIncomeGroup$Income.Group), ]
GDPvsIncomeGroupSorted

# Step 4B. Find the GDP mean of each Income.Group to include as a vertical line in the ggplot. 
SummaryStat <- GDPvsIncomeGroup %>% group_by(Income.Group) %>% summarise(mean(GDP), median(GDP), sd(GDP))
names(SummaryStat)[1] <- "Income.Group"
names(SummaryStat)[2] <- "MeanGDP"
names(SummaryStat)[3] <- "Median"
names(SummaryStat)[4] <- "Standard Deviation"



# Step 4C. Create histograms of GDP for all income levels.
labels <- c("High income: OECD" = "High Income\n OECD", "High income: nonOECD" = "High Income\n nonOECD",
            "Low income" = "Low Income", "Upper middle income"="Upper\n Middle\n Income",
            "Lower middle income" = "Lower\n Middle\n Income")

Histogram1 <- ggplot(data=GDPvsIncomeGroupSorted, aes(x=GDP, fill=Income.Group, colour=Income.Group)) +
    geom_histogram(bins=20)+
    facet_wrap(~ Income.Group, scales="free", drop=TRUE)+
    facet_grid(. ~ Income.Group, labeller=labeller(Income.Group = labels))+
    theme(axis.title.x=element_blank())+
    ggtitle("GDP Histogram by Income Group")+ 
    xlab("GDP (millions of US dollars)")+
    theme_bw()
Histogram1


# Step 4D. Create a density distribution plot for GDP by all income levels.
DensityDistrib1 <- ggplot(data=GDPvsIncomeGroupSorted, aes(x=GDP,  alpha=.2, colour=Income.Group)) + geom_density() + scale_x_log10() + 
    geom_vline(data=SummaryStat,aes(xintercept=Median, colour=Income.Group,
    show.legend=TRUE), linetype= "dashed", size=1)+
    ggtitle("GDP Density Distribution\nby Income Group\n- vertical lines: Medians -")+ 
    xlab("GDP (millions of US dollars)\n Log Transformed")+ theme_bw()
DensityDistrib1

# Step 4E. Create a box plot of GDP versus Income.Group for all income levels.
Boxplot1 <- ggplot(data=GDPvsIncomeGroupSorted, aes(x=Income.Group, y=GDP, 
        fill = Income.Group, alpha=0.2)) + geom_boxplot() + scale_y_log10() +
        theme_bw() + theme(axis.text.x=element_blank()) + 
        stat_summary(fun.y=mean, colour="darkred", geom="point", 
        shape=18, size=3,show.legend = FALSE)+
        ggtitle("Box Plot: \nGDP Distribution \nby Income Group") +
        ylab("GDP (millions of US dollars)\nLog Transformed")
Boxplot1


#QUESTION 5:  Cut the GDP ranking into 5 separate quantile groups.  Make a table
# versus Income.Group.  How many countries are Lower middle income but among the 
# 38 nations with the highest GDP?
QuantileGroups <- quantile(MergeData1$GDPRanking)
MergeData1$GDP.Ranking.Quantile.Groups <- cut(MergeData1$GDPRanking, breaks = QuantileGroups)
IncGroupQuantile <- MergeData1[ ,c("Income.Group", "GDP.Ranking.Quantile.Groups")]
IncGroupQuantile.table <-table(IncGroupQuantile)
IncGroupQuantile.table
IncGroupQuantile.table[5,4]

#ANSWER 5: The number of countries that are in Lower Middle Income but among the 38 
# nations with the highest GDP is 17. 

