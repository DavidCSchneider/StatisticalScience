rm(list=ls(all=TRUE)) #Removes any previous R environment/data history

#Enter data set
# 1. Click on the "import dataset" in the environment tab
data <- read.csv(file.choose()) # load a .csv (comma separated value) file
data <- read.delim(file.choose()) # load a delimited file
data <- read.csv("C:/folder/file_example.csv", header=TRUE) # load a .csv file with named columns
data <- read.delim("C:/folder/file_example.txt", sep="", header=TRUE)
  # load a delimited file, (sep = "") indicates space delimited
data <- read.delim("clipboard", header=TRUE, sep="") # load data copied to the clipboard

#Sample Calculations 
2*2
2^5

#order of operations
2+3*2
3*2+10/2
3*2+10/2-1

#how to make a vector
x <- c(1,2,3,4,5,6) # c() is the concatenate function
y <- c(2,4,8,16,32,64)
z <- c(1:10) # use the colon to indicate inclusive
a <- c(1:10)

a1 <- seq(1, 4) # seq() is the sequence function
a2 <- seq(1, 4, by=0.5) # add the by= for the increment

Name <- 15 # create a simple object
name # R is case sensitive!

#Components of a vector
a # a is a vector
a[2] # brackets can specify parts of the object/vector

newmat <- matrix(1:9, nrow=3, ncol=3) # create a matrix
newmat # view the matrix
newmat[1,2] # brackets specify parts of the object/matrix
newmat[2,3] # notice how rows come first, then columns

mean(newmat[,2:3]) # Example of selecting rows/columns
# With no row specified before the comma, all are selected

#combine vectors
rbind(x,y) # binding by row
cbind(x,y) # binding by column

#basic plot code
plot(x,y) # plot objects x, then y
plot(y~x) # plot object y on x

plot(y~x, xlab="x axis", ylab="y axis", main="my plot", ylim=c(0,70), xlim=c(0,6), pch=15, col="blue") # example of adding plot specifications

# organization tips
plot(y~x, # if a function takes up space, use new lines for better organization, including tabs/spaces
     xlab="x axis", ylab="y axis", main="my plot", # names of the axes/title
     ylim=c(0,70), xlim=c(0,6), pch=15, col="blue") # x/y limits, pch = symbol type, col = color

#fit a model to points
myline.fit <- lm(y ~ x) # example of a linear model fit

#draw the fit line on the plot
abline(myline.fit2)

#add some more points to the graph
x2 <- c(0.5, 3, 5, 8, 12)
y2 <- c(0.8, 1, 2, 4, 6)

points(x2, y2, pch=16, col="green")

# Some manipulations/calculations
mean(x) # mean
mean(y)
median(x) # median
range(x) # range
sd(x) # standard deviation
sqrt(5) # square root
log(5) # log (natural log default)
log10(5) # log base 10
log(5, 20) # custom log (log base 20)
length(x) # length of an object (useful for # of observations)

b1 <- seq(1, 20, by=2)
b2 <- seq(1, 10, by=1)
b <- data.frame(b1, b2) # data.frame turns objects into data frames

b$b1 # $ selects a variable within a data frame
b$new.column <- seq(1, 30, by=3) # if no column exists, a new one is created
  b$b4 <- b1/b2 # manipulate existing columns into a new column
names(b) <- c("col1", "col2", "col3", "col4") # change the names of a data frame


# Adding a practice component (load dataset, perform some simple tasks) ----

#  1. Import a file as a named data frame
#  2. Change the column names
#  3. Find the mean for each column
#  4. Find the mean of all data points
#  5. Create a new vector and add it to the data frame as a new column
#  6. Calculate the difference between columns 1 and 2 and add it as a new column
#  7. Make a plot of the last 2 columns