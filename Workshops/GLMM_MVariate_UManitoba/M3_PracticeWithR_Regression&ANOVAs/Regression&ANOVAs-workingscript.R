#some packages we'll need (install only once, then use regularly by turning them on):

#For importing excel files: 
install.packages("readxl")
install.packages("Rcpp")

#For making summaries:
install.packages("FSA")

#For linear mixed models, including Randomized Complete Block Designs (RCBD)
install.packages("lme4")

#for making publication quality plots:
install.packages("ggplot2")

install.packages("ggfortify")

# if installation goes haywire, trying removing the packages in the bottom right window like so:
#click on packages, then use the search bar, search the package, next to the package is an X sign
# click remove, then try to reinstall
# IF that doesn't work, let's restart your Rstudio and start again
# Please feel free to contact me if there are any hiccups; I am here to help!


#Turn on the packages:

library(FSA)
library(readxl)
library(Rcpp)
library(ggplot2)


#First things first, set up our working directory
# Follow the in instructions or use the shorthand commands ctrl+shift+h

#OR

setwd("C:\Users\Victor\Downloads\2020-01-30_Desktop_Uni_file\PhD_UoM\R workshop\Stats-examples\RCBD script")

# Let's make a new script and start with some easy syntax:

2 + 2

2 - 2

2 * 2

2 / 2

# Create vector for creating data or storage:

a <-c(0,1,2)

b <-c(3:5)

c <-c(a, b)

d<-letters [1:10]

# Once objects are created the data stored in them can be called back by
# typing the object, highlighting it, and clicking run or ctrl + enter
# or clicking on the object in the global environment 


# We can bind our objects by rows or columns:

rbind(a, d)

cbind(a, d)

# Matrices can be created to store multiple data entries but only of the same type
# types include numeric, logical, character, complex

newmat <- matrix(1:9, nrow=3, ncol=3)

newmat

newmat[2,3]

# We can rename our columns for easy typing
#Note this only works for data.frames and not for matrices or vectors

names(dataframe)<-c("newname1","newname2","newname2")

# Data frames are similar to excel sheets, it is a matrix with lists
# as a result it can hold several data types and entries as columns:

data <-data.frame(a,b)


#Let's get some basic info from our data frames or vectors

min (dataset$variable_name) 
max (dataset$ variable_name) 
IQR (dataset$ variable_name) 
mean (dataset$ variable_name) 
median (dataset$ variable_name) 
var (dataset$ variable_name) 
sd (dataset$ variable_name)


# Let's import some data we can analyze

#Names can be hard to type, let's rename for easy coding

sa_data<-X2021_02_25_Salicyclic_acid_VV

names(sa_data)=c("b","trt","leaves")

##### NOTES: We have two explanatory variables (blocks and treatments)
##### COnsisting of 4 blocks and 6 treatments of Salicylic acid application
##### replicated thrice within each block
##### Treatments 1,2,3,4,5 and 6 of salicylic acid applications
##### are 1, 1.5, 2, 2,5. 3 and 3.5 mM (micro Mole) respectively
##### We have one response variable (tomato plant leaves)


#Now, let's make some summaries of our data:

sum=Summarize(leaves ~ b, data = sa_data)
sum2=Summarize(leaves ~ trt, data = sa_data)
sum3=Summarize(leaves ~ b+trt, data = sa_data)

###by block
Table = as.table(sum$mean)

rownames(Table) = sum$b

Table

###by treatment
Table2 = as.table(sum2$mean)

rownames(Table2) = sum2$trt

Table2

###by treatment and treatments
Table3 = as.table(sum3$mean)
Table3

#It's hard to see differences in table form, let's visualize the data:
##Using boxplots()

B<-boxplot(leaves ~ b, data = sa_data, col = "lightgray")
TRT<-boxplot(leaves ~ trt, data = sa_data, col = "lightgray")

##there should be no interaction but we look at it anyway
###NOTE:Order matters! try swtiching the order of b and trt

BTRT<-boxplot(leaves ~ b*trt, data = sa_data, col = "lightgray")
TRTB<-boxplot(leaves ~ trt*b, data = sa_data, col = "lightgray")

##Using barplot()

barplot(Table, ylab="Mean leaves", xlab="Blocks")
barplot(Table2, ylab="Mean leaves", xlab="Treatments")
barplot(Table3, ylab="Mean leaves", xlab="Blocks and Treatment", col = Table3)

##################### Executing a regression model

# In a regression model we assume the relationship b/w the explanatory variable (X) and response
# variable (Y) is LINEAR

# Let's graph our data on a scatterplot


plot(sa_data$trt, sa_data$leaves, main="Scatterplot",
     xlab="Salicylic acid applications mM (micro Mole)", ylab="Number of leaves ", pch=19)

# Add fit lines

abline(lm(sa_data$leaves~sa_data$trt), col="red") # regression line (y~x)
lines(lowess(sa_data$trt,sa_data$leaves), col="blue") # lowess line (x,y) 

# In this example we see that increments of salicylic acid applications (a continuous ratio scale data) 
# might affect the number of tomato leaves grown

# We can write the model as follows:

model1 <- lm(leaves ~ trt,data = sa_data)


# When writing a regression model there are usually three assumptions of normality to fulfill:

Res<- resid(model1)
Fit<- fitted(model1)

#Now let's plot our residual vs fit plot, look at the spread from left to right 

plot(Fit,Res, xlab="Fits", ylab = "Residuals", main = "Residual vs. Fits plot for normality")

abline(h=0, col="red")

#Assumption of Homoscedasticity or homogeneous errors: Use the same plot above
# But looking at the spread of the points above and below the line


#ASsumption of independent errors or autocorrelation: lets make a lagplot 
# a lag plot helps us evaluate if errors in our dataset are random
# if they are random, we should see no pattern

lag.plot(Res, do.lines=FALSE, diag.=FALSE)

#assumption of normal distributions: let's make a qq plot and histogram

qqnorm(Res)
qqline(Res)

histogram<-hist(Res)
xfit<-seq(min(Res),max(Res),length=40)
yfit<-dnorm(xfit,mean=mean(Res),sd=sd(Res))
yfit <- yfit*diff(histogram$mids[1:2])*length(Res)
lines(xfit, yfit, col="blue", lwd=2) 

#Everything seems GOOD! Let's pull up the ANOVA

summary (model1)


# (Multiple) R-squared explains the degree to which your explanatory variables explain 
# the variation of your response variable
# However, the problem with R-squared is that it will either stay the same or increase 
# with addition of more explanatory variables, even if they do not have any relationship 
# with the output variables. On the other hand, an Adjusted R-square penalizes you for 
# adding variables which do not improve your existing model

## Let's make a publication quality scatter plot

scatter<- ggplot(sum2, aes(x=trt, y=mean)) + geom_point(size=5,color="red") +
  geom_smooth(method=lm,  linetype="dashed",
              color="darkred", fill="blue", alpha=0.1)+
  labs(title="Mean number of tomato leaves according to salicylic acid applications",
       x="Salicylic acid concentrations mM (micro Mole)", y = "Average number of tomtato leaves")+
  theme_minimal()

scatter


################################ Executing One-Way ANOVA in R


# If we were interested, We can analyze our dataset using treatments as a fixed factor
# In this case we infer to the variation within the levels of salicylic acid treatments


#NOTE: Treatments are in number format, this may confuse R 
#into thinking they are ratio scale, let's make them categorical

sa_data$trt = factor(sa_data$trt)

# We write the model similar to our first:

model2 <- lm(leaves ~ trt ,data = sa_data)

# as always, we must satisfy the assumptions of normality:

Res2<- resid(model2)
Fit2<- fitted(model2)

#Now let's plot our residual vs fit plot, look at the spread from left to right 

plot(Fit2,Res2, xlab="Fits", ylab = "Residuals", main = "Residual vs. Fits plot for normality model 2")

abline(h=0, col="red")

#Assumption of Homoscedasticity or homogeneous errors: Use the same plot above
# But looking at the spread of the points above and below the line


#ASsumption of independent errors or autocorrelation: lets make a lagplot 

lag.plot(Res2, do.lines=FALSE, diag.=FALSE)

#assumption of normal distributions: let's make a qq plot and histogram

qqnorm(Res2)
qqline(Res2)

histogram<-hist(Res2)
xfit2<-seq(min(Res2),max(Res2),length=40)
yfit2<-dnorm(xfit2,mean=mean(Res2),sd=sd(Res2))
yfit2 <- yfit2*diff(histogram$mids[1:2])*length(Res2)
lines(xfit2, yfit, col="blue", lwd=2) 

# THey seem ok, let's look at call the ANOVa table by using using the anova()


anova(model2)


# We see that there are no differences between our levels of salicylic acid treatments



##################################### Executing a 2-way ANOVA

# But wait, there's more, what If we were interested in our blocks as a fixed factor
# In this case we infer to the variation within the levels of blocks because
# we may not know how they were set up. Moreover, we may be interested in how our blocks
# interact with our salicyclic acid treatments to affect the number of tomato leaves

#NOTE: Though blocks are not in number format, R can be finicky 
# let's make them categorical anyway

sa_data$b = factor(sa_data$b)


# Our model would be as follows:

model3 <- lm(leaves ~ trt*b ,data = sa_data)

# As always, we must satisfy the assumptions of normality:

Res3<- resid(model3)
Fit3<- fitted(model3)

#Now let's plot our residual vs fit plot, look at the spread from left to right 

plot(Fit3,Res3, xlab="Fits", ylab = "Residuals", main = "Residual vs. Fits plot for normality model 3")

abline(h=0, col="red")

#Assumption of Homoscedasticity or homogeneous errors: Use the same plot above
# But looking at the spread of the points above and below the line


#ASsumption of independent errors or autocorrelation: lets make a lagplot 

lag.plot(Res3, do.lines=FALSE, diag.=FALSE)

# We see that our lagplot may not satisfy our assumption of independent errors
# since our lagplots shows an increase in the residual vs lags
# it likely suggests that the way that our samples were gathered is feeding into the independent error structure
# thus our residuals are autocorrelated


#for illistrutive purposes let's continue looking at the assumption of normally distrbuted errors

#assumption of normal distributions: let's make a qq plot and histogram

qqnorm(Res3)
qqline(Res3)

histogram<-hist(Res3)
xfit3<-seq(min(Res3),max(Res3),length=40)
yfit3<-dnorm(xfit3,mean=mean(Res3),sd=sd(Res3))
yfit3 <- yfit3*diff(histogram$mids[1:3])*length(Res3)
lines(xfit3, yfit, col="blue", lwd=3) 

# We see that our model deviated from a normal distribution and likely has a negatively (left-) skewed data
# we have more values on the right side (tail) of the distribution graph

# we may need to transform our data but for illustrative purpose let's go ahead and see the anova output


anova(model3)


# we see that the  interaction between blocks and treatments does not affect the number of tomato leaves
# instead the blocks is the only significant effect. HOwever since our data does not mean the assumption of
# normal distributions and independent errors we cannot say with confidence that we see a significant effect
# by our blocking levels


##### Use ggplot to make high quality plots and then change the position b/w boxplots

p1<-ggplot(sa_data, aes(x=trt, y=leaves, fill=trt)) + geom_boxplot()

p1

p2<-ggplot(sa_data, aes(y=leaves, fill=b)) + geom_boxplot() + facet_wrap(~trt,ncol = 6) +
  theme( axis.text.x = element_blank(), axis.ticks.x = element_blank())

p2
