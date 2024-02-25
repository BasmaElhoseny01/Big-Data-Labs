#clean environment and remove all variables in the global environment. 
rm(list=ls())
#display work items
ls()
#get working directory
getwd()


# Importing Dataset into DF from csv file 
dfcsv <- read.csv("titanic.csv",header = TRUE)
dfcsv
# Dim for the dataset
dim(dfcsv)
# Structure for the dF
str(dfcsv)
# first and the last TEN rows in the dataset.
head(dfcsv)
tail(dfcsv)
# Summary of all variables in the data frame.
summary(dfcsv)

# Summary for age only 
summary(dfcsv$Age)

# Getting first Quartile
summary(dfcsv$Age)["1st Qu."]

# Getting third Quartile
summary(dfcsv$Age)["3rd Qu."]
# wether each element is NA or not
print(is.na(dfcsv$Age))
# Does the passed list contain any value that is NA
print(anyNA(dfcsv$Age))


class(dfcsv$Embarked) # Character

# No.5
# Remove Rows with Age value be NA
dfcsv_clean=dfcsv[!is.na(dfcsv$Age), ]
dim(dfcsv)
dim(dfcsv_clean)
# Remove the rows containing any unexpected value in the embarked variable from the
dfcsv_clean=dfcsv_clean[dfcsv_clean$Embarked %in% c('C','Q','S'),]
dim(dfcsv_clean)

# Count NA Ages
dfcsv_clean[is.na(dfcsv_clean$Age), ]  # Rows
embarked_factor=factor(dfcsv_clean$Embarked)
print(levels(embarked_factor))


# Remove Cols of Cabin and Ticket
dfcsv_new <- dfcsv_clean[, !(names(dfcsv_clean) %in% c("Cabin", "Ticket"))]
dim(dfcsv_new)


# No(7)
# Creating Freq table for the gender
gender_table <- table(dfcsv_new$Gender)
print(gender_table)
male_count=gender_table["male"]
female_count=gender_table["female"]

# Draw Pie Chart
values <- c(male_count, female_count)

# Create a pie chart
pie(values)


# Create a table of counts
count_table <- table(dfcsv_new$Survived, dfcsv_new$Gender)

# Plot the counts
barplot(count_table, beside = TRUE, col = c("lightblue", "lightgreen"), legend = TRUE)


# Plot a pie chart showing the number of males and females who survived only.
# Filter the data for individuals who survived
survived_data <- subset(dfcsv_new, Survived == 1)
survived_table <- table(survived_data$Gender)
print(survived_table)
pie(survived_table)
# Conclusion: Most Survived are female this means the men helped teh women to survive :D Gentles :D


# Example data
gender <- c("Male", "Female")
counts <- c(survived_table["male"],survived_table['female'])

# Create a bar plot
barplot(counts, names.arg = gender, 
        main = "Counts by Gender",
        xlab = "Gender",
        ylab = "Count",
        col = "skyblue",
        ylim = c(0, max(counts) * 1.2),
        beside = TRUE)


# Calculate the density estimate
density_age <- density(dfcsv_new$Age)

# Plot the density distribution
plot(density_age, main = "Density Distribution of Age", xlab = "Age", ylab = "Density")

# Export
write.csv(dfcsv_new[,c("Name","Survived")], file = "output.csv", row.names = FALSE)
