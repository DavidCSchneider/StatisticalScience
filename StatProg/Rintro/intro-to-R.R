# ---- Introduction to R ----
# Quantitative Methods in Biology 4605/7220
## conducted by Emilie Geissinger on September 28, 2021

# Now that you have opened R, you see 4 boxes.  
# The box you are reading is the script box.  
# You'll be learning to use it to set up and execute analyses in this course.
# The box below has 3 settings, the one you see is the console.
# This is where results are displayed.
# The box to the right and up is set to Environment.  You'll find this useful.
# The box to the right and down is set to Files.
# Set it to Packages to see your library of R routines
# Set it to Plots to see plots from R

# ------------------------------------------------------------------
# We'll start by using R as a calculator from the console.

# Type 2+2 in the console box (the box below)

# With you cursor still in the Console press [Enter] or click the  -->Run button above
# Now do some more calculations.
4-2
4*2
4/2
sin(4)
exp(4)
log(4)

#### R Script ####
# Using an R script allows you to save your work and come back to it later.
# To start, put you cursor on one of the code lines above.
# Press Ctrl+Enter or click Run button.
# The result appears in the Console Box (below).
# On the blank line below, type your own calculation, then execute it.

#
# Everything in R is an object. In R we work with objects.  
# We'll start by assigning a single value to an object named x, 
# To run the code from here in the script box, use Ctrl+Enter or Run Button (above) 
# Run the code on the next line to define the object labelled x.
x <- 5     # The arrow defines the object.
# To see what is in the object called x, run the next line from the script box.
x

# You can manipulate those objects.  Run the next line and display it.
x+5
#Run the next line and display the result.
x*2

# You can store multiple values in objects called a vector.
y <- c(2,4,6,8)     # use c() to create a vector, c means 'concatenate.'
y         # run this line to display the vector in the console box.

# You can apply a function to the entire vector.
# Run the next line from here in the script box, and display it.
y*2

# You can add objects together (one vector, one value).
# Run the next line from here in the script box, then display it.  
y+x


# ---- Data types ----
# In R, data are stored as different types.
# The vector y (above) is a numeric vector (numbers with decimals).
# Here is a vector with categorical values (not numbers).
Group <- c("1", "2", "3")  # These are labels, not addable numbers.
Group

# what happens when you mix datatypes in single vector?
# Create two vectors for comparison.
y <- c(1,2,"three") 
x <- c(5:10)
# Now inspect and compare them.
str(x)
typeof(x)

str(y)
typeof(y)


# ---- Combining vectors to make dataframes -----
# Begin by creating 2 vectors with the same length (5).
Unit<- c(1:5)                    # a vector from 1 to 5

Ydata<- c(1.1,1.2,1.3,1.4,1.5)   # a vector with 5 numbers

X<- c("A","B","C","D","Control") # a vector with 5 labels
Unit     # view your vector
Ydata    # view your vector
X        # view your vector

# Now look at the Environment Box, over on the upper right.
# Compare what you see displayed in the Console box to the Environment Box.
# 

# Combine the three vectors into a matrix of vectors (data frame).
mydata<- cbind(Unit,Ydata,X)  # cbind means combine columns.
mydata

# look at the first two columns.
head(mydata,2)

# look at the last two columns.
tail(mydata,2)

# open the object in a separate window.
# This will open the dataframe in the console box.
# To get back to the script. look for (above) and click on intro-to-R
View(mydata)

# look at the structure of the object.
str(mydata)

# checking structure is very important. What do you notice about the structure of this?
# It isn't a dataframe. The two vectors are put together, and are more similar to a matrix.
# So how do we create a dataframe?

mydataframe<-data.frame(Unit,Ydata,X) # use the data.frame() function to combine vectors into a dataframe
str(mydataframe)                      # see the difference?
# use summary() to check basic summary stats on your data                
summary(mydataframe) 

# We have been using an arrow to define an object
# The equal sign also defines an object. <- or =
z=0
z<- 0
# <- and = do the same thing. 
# Many style guides advocate <-  
# but do keep spaces around <- assignments or they can become quite hard to interpret.

# --- Packages ----
# Packages are an important part of R. 
# Packages contain different functions (depending on the package) that might be useful

# the first step to getting a package is to install it in R
# Important: you only ever need to run these lines once on your computer

install.packages("car")
install.packages("MASS")

# after you have installed a package you will still need to load it into your R environment
library(car)
library(MASS)
# notice the difference between the two inputs of install.packages() vs. library()


# --- l=Loading data using code---
setwd("C:/Users/username/Desktop/") # path to your directory
# Go to Files (box to the right and down) and copy the filename.
# For a csv file use:
data<-read.csv("filename.csv")
data
head(data)

# --- loading data using the Environment Box - Click on Import Dataset.
# csv files can be read here as text files. Excel files can be read here.


# ---- Getting help ----
?Anova
??Anova
help(Anova)

# Google is a great resource as well.
# Search:  difference between = and "<-" in r