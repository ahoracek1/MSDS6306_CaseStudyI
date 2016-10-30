###########################################################################
# MSDS6306CaseStudy1_Clean_Rev2.R, Angela Horacek                         # 
###########################################################################                                          
#                                                                         # 
# PART II: CLEAN THE DATA                                                 #
#                                                                         #    
###########################################################################

#################################################
#STEP 1: SET WORKING DIRECTORY                  #
#################################################
#Set the working directory so the file is in the "Data" folder
setwd("C:/Users/Angela/Documents/1_SMU/Courses/MSDS6306DoingDataScience/CaseStudy1/MSDS6306_CaseStudyI/Data")


#################################################
# STEP 2:  CLEAN DATA SET -->  GDP Data         #
#################################################

# Step 2A: Read the data.  Change variables from factors to characters;  
# Easier to coerce if needed. Set headers=FALSE will rename variables.
GDPcountryRaw2 <- read.csv("GDPcountryRaw.csv", stringsAsFactors = FALSE, 
                           header=FALSE)

# Step 2B:  GDPcountryData:  Rename variables.(Note:  It is important to 
# define the variable for the column first before you can subset and coerce 
# the variable.)
GDPcountryData <- GDPcountryRaw2
names(GDPcountryData) <- c("CountryCode", "GDPRanking", "Col3", "CountryName", "GDP",
                           "Col6", "Col7","Col8","Col9","Col10")

# Step 2C:  Keep only the columns for the analysis.
GDPcountryData <-GDPcountryData[,c("CountryCode", "GDPRanking", "CountryName","GDP")]


# Step 2D:  GDPcountryData:  Remove first 5 lines of data because these are 
# not relevant and new headers will given.  Remove rows 196-331 (total = 136 rows)
# because these rows are not relevant to the analysis objectives(a) countries 
# do not contain GDP data, b)contain blank rows, and c)contain summary GDP data 
# by income group and region.)
dim(GDPcountryData)
RowsRemovedAtBottom <- 331-195
RowsRemovedAtBottom

GDPcountryData <- GDPcountryData[6:195,]

# Step 2E:  Remove commas in GDP column and replace with nothing.
GDPcountryData$GDP <- gsub(",", "",GDPcountryData$GDP)

# Step 2F:  Coerce GDP to an integer
GDPcountryData$GDP <- as.integer(GDPcountryData$GDP)

#Step 2G: Coerce GDPRanking to an Integer
GDPcountryData$GDPRanking <- as.integer(GDPcountryData$GDPRanking)

#Step 2H:  Before, Merging DataSets, Give DataSet New Name to Indicate It
# Has Been Cleaned.
GDPcountryDataClean <-GDPcountryData


#################################################
# STEP 3:  CLEAN DATA SET --> Education Data    # 
#################################################

# Step 3A: Read the file.  
EducationData <- read.csv("EducationRaw.csv")

#Step 3B:  Coerce the variable, CountryCode, into a character in order to merge 
# on CountryCode. This variable must be the same in each dataset in order to merge.   
EducationData$CountryCode <- as.character(EducationData$CountryCode)

#Step 3C:  Eliminate codes in the variable, CountryCode, which are regional 
# names.Identify the lines/rows where every value in the Income.Group Column 
# is blank.Then delete those lines/rows in the dataset. 
fslines <-which(EducationData$Income.Group == "")
EducationData <- EducationData[(-1 * fslines), ]

#Step 3D: Eliminate the additional columns which are not needed in the analysis.
EducationData <- EducationData [ , c("CountryCode", "Income.Group")]

#Step 3E:  Before, Merging DataSets, Give DataSet New Name to Indicate They 
# Have Been Cleaned.
EducationDataClean <- EducationData


#################################################
# STEP 4:  MERGE CLEAN DATA SETS                # 
#################################################

# Step 4A: Merge the Two Cleaned Data Sets on the Variable, CountryCode:  
# QUESTION#1:  Merge the data based on the country shortcode which is 
# named, "CountryCode".
MergeData1 <- merge(x=GDPcountryDataClean, y=EducationDataClean, 
                    by = "CountryCode", all=FALSE)
