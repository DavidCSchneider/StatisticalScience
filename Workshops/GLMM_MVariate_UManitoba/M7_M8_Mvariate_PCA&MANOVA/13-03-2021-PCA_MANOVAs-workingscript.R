#Use packages:

library(ggplot2)
library(readr)
library(FSA)
library(ggfortify)

#First things first, set up our working directory
# Follow the in instructions or use the shorthand commands ctrl+shift+h

#OR

setwd("C:/Users/Victor/Downloads/2020-01-30_Desktop_Uni_file/PhD_UoM/R workshop/Stats-examples/PCA analysis")



#import your data file in text format


BumpusSparrowsJanzenStern <- read_table2("BumpusSparrowsJanzenStern.txt")

View(BumpusSparrowsJanzenStern)

# we have several variables including total length, alar extent, weight, 
#length of beak and head, length of humerus, length of femur
# length of tibiotarsus, width of skull, length of keel of sternum, and sex

#notice that coding for males = 1 and females = 0
# In the past, there have been several version of this same dataset
#the column marked fit was used to double check if the data was altered in the past
# we will ignore this column

#Names can be hard to type, let's rename the dataframe for easy coding

bumpus_data<-BumpusSparrowsJanzenStern

#NOTE: our blocks and trts are in number format, this may confuse R 
#into thinking they are ratio scale, let's make them categorical

bumpus_data$sex = as.factor(bumpus_data$sex)

#Now, let's make some summaries of our data:

sum=Summarize(len ~ sex, data = bumpus_data)
sum2=Summarize(wt ~ sex, data = bumpus_data)
sum3=Summarize(stern ~ sex, data = bumpus_data)

### total length by sex
Table = as.table(sum$mean)

rownames(Table) = sum$sex

Table

###total weight by sex
Table2 = as.table(sum2$mean)

rownames(Table2) = sum2$sex

Table2

###length of keel of sternum by sex
Table3 = as.table(sum3$mean)

rownames(Table3) = sum3$sex

Table3

#It's hard to see differences in table form, let's visualize the data:
##Using boxplots()

length<-boxplot(len ~ sex, data = bumpus_data, col = "lightgray")
width<-boxplot(wt ~ sex, data = bumpus_data, col = "lightgray")
sternum<-boxplot(stern ~ sex, data = bumpus_data, col = "lightgray")

##Using barplot()

barplot(Table, ylab="Mean length", xlab="Sex")
barplot(Table2, ylab="Mean width", xlab="Sex")
barplot(Table3, ylab="Mean sternum", xlab="Sex")


## from the graphical outputs its sorta hard to tell how different variables relate to one another
## This is where a principal components analysis (PCA) comes in
## A principal components analysis is a multivariate test 
## That can be used to explore the relationships between variables within a matrix dataset
## It accomplishes this feat with the dimensionality-reduction method
## in other words, reduce the number of variables of dataset 
## while explaining all or most of the variance in it

## PCA is performed using the R base function prcomp()
## It centres the variable by default, so that the mean is zero
## We begin by normalising/standardising the variables to have a standard deviation of 
## one using parameter scale = T. In others words, normalising/standardising allows
## the range of continuous variables to contribute equally to the Variance found in the dataset!

###principal component analysis
# We must first revert the sex factor to a continious variable, prin_comp does not recognize
# factorial variables when it does the analysis in R
# An easy way to convert back into the original format is to recall
# the original data into our object bumpus_data

bumpus_data<-BumpusSparrowsJanzenStern

#then call the variables you are interested in

prin_comp <- prcomp(~len+ext+wt+head+humer+femur+tibio+skull+stern, scale = T, data=bumpus_data)

## Let's see what prin_comp comes with

names(prin_comp)

## It includes computed items like: "sdev"  "rotation" "center"   "scale"    "x"

# The mean and standard deviation of the variables used for normalisation prior to implementing PCA are referred to as centre and scale, respectively.

# Output the mean of variables
prin_comp$center

#outputs the standard deviation of variables
prin_comp$scale

## The principal component loading is determined by the rotation measure
## The principal component loading vector is found in each column of the rotation matrix
## This is the most important metric to pay attention to

prin_comp$rotation 

##This returns the loadings of the principal components. 
## The maximum number of principal component loadings in a data set is a minimum of (n-1, p). 
## These are the first nine main components and 9 rows, we would normally look at the first three PC axes
## We see that most variables have a positive relationship with PC1, while some have positive or negative
## relationships with PC2
##from the look of this output, it is likely the first two Principal components explain the most variation
## let's confirm that observations

##Output the portion of variance explained by the principal components

summary(prin_comp)


### Most of our variation can be attributed to the first and second 
### principal components of 59.31% and 11.13%, respectively, with a total of 70.44%

# It's sometimes hard to look at numbers, let's visualize this output in a screeplot:
# extract the standard deviation of the PC

std_dev <- prin_comp$sdev

#compute variance squared

pr_var <- std_dev^2

#proportion of variance explained

prop_varex <- pr_var/sum(pr_var)

# produce scree plot
plot(prop_varex, xlab = "Principal Component",
     ylab = "Proportion of Variance Explained",
     type = "b")


# we see that 70.44% of the variance can be found in PC1 and PC2


# Now let's produce the biplot using PC1 and PC2 as the the components that explain the 
# most variance in the dataset

biplot(prin_comp, scale = T)
abline(v=0)
abline(h=0)



##A PCA can also be used with a confirmatory analysis, e.g., MANOVA

##That is, are there differences? If so, we can analyze all the variables in question simultaneously

##Doing so eliminates the chance of a biased analysis
## but also deviates from the traditional approach of an "A priori" statistical analysis
##because we know there are some relationships!
  
## Thus, it is no longer an "a priori" statistical analysis
## and cannot rightly be treated so! Instead, as part of the exploratory analysis
## we can confirm if differences exist but do not report the p-values

## This is the basis of using an exploratory analysis for hypothesis formation

# The question we want to know: are there any significant differences in measured variables
# (i.e., total length, alar extent, weight, length of beak and head, length of humerus, length of femur
# length of tibiotarsus, width of skull, length of keel of sternum) between sexes?


#Execute the MANOVA model as follows:
res.man <- manova(cbind(len,ext,wt,head,humer,femur,tibio,skull,stern) ~ sex, data=bumpus_data)
summary(res.man)

# we find that there is a siginficant difference between sexes
# To see which ones, we call the anova summary function
summary.aov(res.man)


# Let's make some publication quality biplot:
bp<-autoplot(prin_comp, data=bumpus_data, colour = 'sex',
         loadings = TRUE, loadings.colour = 'blue',
         loadings.label = TRUE, loadings.label.size = 3)
bp
