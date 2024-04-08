#setwd("~/LAB")
rm(list=ls()) # clear the R environment by removing all objects from the workspace

#=============================Part(1)=====================================
x <- runif(100, 0, 10)     # 100 draws between 0 & 10

#(Q1) Try changing the value of standard deviation (sd) in the next command 
#How do the data points change for different values of standard deviation?

y <- 5 + 6*x + rnorm(100, sd = 2)  # default values for rnorm (mean = 0 and sigma = 1)
#Plot it
plot (x,y,main = "y=5+6*x + rnorm(100, sd = 2)")


# OLS model
# OLS : Ordinary Least Squares
model1 <- lm(y ~ x)
# Learn about this object by saying ?lm and str(d)

#(Q2) How are the coefficients of the linear model affected by changing the value
#of standard deviation in Q1?

# Regression diagnostics --
ypred <- predict(model1) # use the trained model to predict the same training data
# Learn about predict by saying ?predict.lm

par(mfrow=c(1,1))
plot(y,y, type="l",main = "Predictions Model(1) std:2", xlab="true y", ylab="predicted y") # ploting the ideal line
points(y, ypred) # plotting the predicted points
                 # the nearer to the ideal line the better

# Detailed model results
d1 <- summary(model1)
print(model1)

#(Q3) How is the value of R-squared affected by changing the value
#of standard deviation in Q1?

# Learn about this object by saying ?summary.lm and by saying str(d)
cat("OLS gave slope of ", d1$coefficients[2,1],   
    "and an R-sqr of ", d1$r.squared, "\n")

#Graphic dignostic (cont.)
par(mfrow=c(1,1)) # parameters for the next plot
plot(model1, 1,main = "Residual Plot For Model(1) std:2") # plot one diagnostic graphs

#(Q4)What do you conclude about the residual plot? Is it a good residual plot?
#========================End of Part(1)==============================================

#========================Part(2)=====================================================
#Training a linear regression model
x1 <- runif(100) 
# introduce a slight nonlinearity
#(A)
y1 = 5 + 6*x1 + 0.1*x1*x1 + rnorm(100)
plot(x1,y1)
model <- lm(y1 ~ x1)

summary(model)

#Creating a test set (test vector)

#EDIT: We renamed the variable as x1 instead of xtest (in previous versions)
#because the lm function searches in the formula for variables named 
#with x1 and not any other name.
#So, if you used xtest, the lm function will not know what is xtest and
#a random plot will be generated. 

x1 <- runif(100)
#(B)
ytrue = 5 + 6*x1 + 0.1*x1*x1 + rnorm(100)  # same equation of y1 but on xtest to get true y for xtest

ypred <- predict(model, data.frame(x1))

par(mfrow=c(1,1))
plot(ytrue, ytrue, type="l", xlab="true y", ylab="predicted y")
points(ytrue, ypred)

# graphic dignostic (cont.)
par(mfrow=c(1,1)) # parameters for the next plot
plot(model, 1) # plot the diagnostic graphs

#(Q5)What do you conclude about the residual plot? Is it a good residual plot?

#(Q6)Now, change the coefficient of the non-linear term in the original model for (A) training 
#and (B) testing to a large value instead. What do you notice about the residual plot?
#===============================End of Part(2)=============================================

#=================================Part(3)==================================================
rm(list=ls()) # clear the R environment by removing all objects from the workspace

#(Q7) Import the data set LungCapData.tsv. What are the variables in this dataset?
# Read File
df <- read.table("LungCapData.tsv", header = TRUE, sep = "\t")

# Print the column names
print(names(df))


#(Q8) Draw a scatter plot of Age (x-axis) vs. LungCap (y-axis). Label x-axis "Age" and y-axis "LungCap"
lung_cap <- df$LungCap
age <- df$Age

# Create scatter plot
plot(age, lung_cap, 
     xlab = "Age",  # Label for x-axis
     ylab = "LungCap",  # Label for y-axis
     main = "Scatter Plot of Age vs. LungCap"  # Title
)


#(Q9) Draw a pair-wise scatter plot between Lung Capacity, Age and Height. 
#Check the slides for how to plot a pair-wise scatterplot
# Create pair-wise scatter plot
pairs(~ LungCap + Age + Height, data = df)

#(Q10) Calculate correlation between Age and LungCap, and between Height and LungCap.
#Hint: You can use the function cor
# Calculate correlation between Age and LungCap
cor_age_lungcap <- cor(df$Age, df$LungCap)
print("Age and LungCap Correlation"+cor_age_lungcap)
print(paste("Age and LungCap Correlation:", cor_age_lungcap))

# Calculate correlation between Height and LungCap
cor_height_lungcap <- cor(df$Height, df$LungCap)
print(paste("Height and LungCap Correlation:", cor_height_lungcap))

#(Q11) Which of the two input variables (Age, Height) are more correlated to the 
#dependent variable (LungCap)?
print("Height")

#(Q12) Do you think the two variables (Height and LungCap) are correlated ? why ?
print("Yes,However, correlation does not imply causation, so further analysis would be needed to determine the exact relationship between these variables.")

#(Q13) Fit a liner regression model where the dependent variable is LungCap 
#and use all other variables as the independent variables
lm_model <- lm(LungCap ~ .,data = df) # the dot . represents all other variables in the dataset except the dependent variable.

#(Q14) Show a summary of this model
summary(lm_model)

#(Q15) What is the R-squared value here ? What does R-squared indicate?
print("R-squared value:0.8532")
print("It indicates that 85.42% of the variance in the dependent variable LungCap is 
      explained by the independent variables(Used by the model). In other words.
      If we draw the linear Model plane in the space and the training points we will see the points are highly around the plane")

#(Q16) Show the coefficients of the linear model. Do they make sense?
#If not, which variables don't make sense? What should you do?
print(lm_model$coefficients)
print("Yes the Make Sense More Details are in the Report :D")

#(Q17) Redraw a scatter plot between Age and LungCap. Display/Overlay the linear model (a line) over it.
#Hint: Use the function abline(model, col="red").
#Note (1) : A warning will be displayed that this function will display only the first two 
#           coefficients in the model. It's OK.
#Note (2) : If you are working correctly, the line will not be displayed on the plot. Why?
# Redraw scatter plot between Age and LungCap
plot(LungCap ~ Age, data = df, xlab = "Age", ylab = "LungCap", main = "Scatter Plot of Age vs. LungCap")

# Overlay linear model as a line
abline(lm_model, col = "red")

# Line Wasn't draw why?
#(Intercept)          Age   
#-11.3224856    0.1605296 
# Line to Draw LungCap=0.1605296*Age -11.3224856 [Refer to the Line Draw in The report]
print("The line of separator   is below the graph values we have its y-intercept -11.32 and x-intercept=70 so we cannot see it here :D")

#(Q18)Repeat Q13 but with these variables Age, Smoke and Cesarean as the only independent variables.
lm_model_2 <- lm(LungCap ~ Age + Smoke + Caesarean,data = df)

#(Q19)Repeat Q16, Q17 for the new model. What happened?
print(lm_model_2$coefficients)
print("Yes the Make Sense More Details are in the Report :D")

plot(LungCap ~ Age, data = df, xlab = "Age", ylab = "LungCap", main = "Scatter Plot of Age vs. LungCap")
# Overlay linear model as a line
abline(lm_model_2, col = "red")

#(Q20)Predict results for this regression line on the training data.
predictions <- predict(lm_model_2, newdata = df)

#(Q21)Calculate the mean squared error (MSE)of the training data.
# Calculate Mean Squared Error (MSE)
mse <- mean((df$LungCap - predictions)^2)
print(paste("Mean Squared Error (MSE) of the training data:", mse))

# [Extra] For Model 1
# Predict results for this regression line on the training data.
predictions_1 <- predict(lm_model, newdata = df)

# Calculate the mean squared error (MSE)of the training data.
# Calculate Mean Squared Error (MSE)
mse <- mean((df$LungCap - predictions_1)^2)
print(paste("Mean Squared Error (MSE) of the training data [Model 1]:", mse))
