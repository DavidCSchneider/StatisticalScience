#Turn on the packages:

library(readxl)


library(readxl)
library(Rcpp)
library(lme4)


# set your working directory
setwd("C:\Users\Victor\Downloads\2020-01-30_Desktop_Uni_file\PhD_UoM\R workshop\Stats-examples\RCBD script")

# Import and rename your excel sheet

X2021_02_25_Salicyclic_acid_VV <- read_excel("2021-02-25-Salicyclic acid-VV.xlsx")

sa_data<-X2021_02_25_Salicyclic_acid_VV 


# Let's import some data we can analyze
##### NOTES: We have two explanatory variables (blocks and treatments)
##### COnsisting of 4 blocks and 6 treatments of Salicylic acid application
##### replicated thrice within each block
##### Treatments 1,2,3,4,5 and 6 of salicylic acid applications
##### are 1, 1.5, 2, 2,5. 3 and 3.5 mM (micro Mole) respectively
##### We have one response variable (tomato plant leaves)


#Names can be hard to type, let's rename for easy coding

names(sa_data)=c("b","trt","leaves")

#NOTE: our blocks and trts are in number format, this may confuse R 
#into thinking they are ratio scale, let's make them categorical

sa_data$b = factor(sa_data$b)
sa_data$trt = factor(sa_data$trt)


# A linear mixed model is an extension of the linear model which is used to analyze
# multilevel/hierarchial datasets. The LMM allows both fixed and random effects, like that found by blocking
# which will be included in this analysis. For more information on LMM look at Chapter 19 from "Crawley The R book" 
# For this model we are interested in the fixed (salicyclic acid applications) effects with random (blocks) effects included 

model4 <- lm(leaves ~ b+trt,data = sa_data)

# notice we did "b+trt" to reflect the randomized complete block (RCB) procedure; it is analyzed as unreplicated factorial ANOVAs 

# In this analysis we assume there is NO interactive effect between our treatments and block on our response
# Later we'll look at when we DO NOT assume this 
#Let's test the assumptions of normality:

Res<- resid(model4)
Fit<- fitted(model4)

#Now let's plot our residual vs fit plot, look at the spread from left to right 

plot(Fit,Res, xlab="Fits", ylab = "Residuals", main = "Residual vs. Fits plot for normality")

abline(h=0, col="red")

#Assumption of Homoscedasticity or homogeneous errors: Use the same plot above
# But looking at the spread of the points above and below the line


#ASsumption of independent errors or autocorrelation: lets make a lagplot 

lag.plot(Res, do.lines=FALSE, diag.=FALSE)

#assumption of normality: let's make a qq plot and histogram

qqnorm(Res)
qqline(Res)

histogram<-hist(Res)
xfit<-seq(min(Res),max(Res),length=40)
yfit<-dnorm(xfit,mean=mean(Res),sd=sd(Res))
yfit <- yfit*diff(histogram$mids[1:2])*length(Res)
lines(xfit, yfit, col="blue", lwd=2) 

#Everything seems GOOD! Let's pull up the ANOVA
anova(model4)

# R should  calculate the correct F-ratio by dividing the mean sq of the fixed (treatment) term by  
# The mean sq of the  residual term, which includes the negligible interaction (b*trt) and the error) 

# We see no significant effect of our fixed (treatment) term relative to the residual (error and b*trt) term!



##################### What if we had some variation due to the interaction term (b*trt) #####################
# Why would we want to be interested? Let's think about a randomized compelte block (RCB), it assumes that our
# blocks have no or nearly no interactive effect on the treatment term, and  thus there should be no variation attributed to it
# This SCENARIO is perfectly acceptable for lab experiments, where we can control all of the variation among blocks

# For agriculture, environmental or any other experiments that is subject to spatial or temporal forces, then we no 
# longer have much control on the variation due to blocks, and thus we assume there is some effect of block on our treatment term


# If replicates are possible within each combination of block and treatment, then we have a generalized
# randomized complete block design (GCB) whose advantages over the usual randomized block design include:

# 1. no need for any assumption of additivity,
# 2. separation of interaction effects from residual which may result in smaller MSResidual and more powerful test of treatments (Potvin 1993), and
# 3. better handling of missing values

#### Please refer to  Quinn and Keough, 2002 "Experimental design and data analysis for biologists" for more information ##### 


# Let's double check how the interaction term may affect our model

model5 <- lm(leaves ~ trt*b, data = sa_data)
anova(model5)

# WE notice we have nearly the same output as our RCB above
# However, the correct F-ratio for the GCB with the fixed (treatment) term would use the interaction term 
# in the denominator. The model we ran tests over the residual (error) not the interaction term

# Now, let's determine if R computes the right F-ratio by dividing the fixed term mean squares by the interaction term mean sq

F<-2.122/0.848
F
 Now, determine the p-value?

1-  pf(F,5,15) 

# We see that our p-value is very different from output given by R
# Instead of dividing by the correction mean sq denominator (variation by b*trt interaction)
# R is computing the F-ratio by dividing by the residual mean sq as the denominator; this is not good! 

#####################ANOTHER APPROACH
# lm() uses ordinary least squares as the methodology for calculating the ANOVA table  
# In other words, we can easily calculate all the SS, MS, F, by hand if we wanted to (e.g., above)
# When adding a random effect into our models we need to take a slightly different approach
# Ordinary least squares cannot make these calculations

# For this we can  use both the lme4 or lmerTest package, the only difference is that the latter gives you more details 
# about the anova() output from the lmer() function. For more information on lmer() look at Chapter 19 from "Crawley The R book"

# Let's use lmerTest


model6 <- lmer(leaves ~ (1|b) * trt, data = sa_data)

# The "1|b" notation lets R know that the block effect is a random effect in our model

# Let's call the ANOVA


anova(model6)


# Notice the model6 ANOVA is similar to the ANOVAs for model4 and model5 !!
# We still get the wrong f-ratio when we compare it to our computed version, moreover lmer and lmerTest does not
# Give us the full ANOVA output to determine what it uses as the denominator mean sq to compute the F-ratio

# Let's try a different way of calling our random effect using the aov() function
# The difference here compared to the other models is the output; the aov() function changes our linear model (lm) to 
# an ANOVA straight away. Moreover, When computing the F-ratios We call and let R know the corrected error term 

# by using the Error () function. In aov(), the "factor A / factor B" notation lets R know that the 
# block effect (factor A) is the biggest spatial attribute in our model, and the treatments (factor B) is within blocks

##  For more information on this notation look at pages 469 to 480 from "Crawley The R book"

## We can use the summary() function to call the ANOVA output

summary(aov(leaves~trt+Error(b/trt), sa_data))

# If we compare the model to our computed F-ratio, we finally get the right F-ratio!

# Take away message, even though R is great for producing our graphs, we must always be vigilant about 
# Computing the right F-ratios! Asking for advice from your PI, prof or colleagues, and doing your own calculations 
# are always a great way to make sure you understand your experimental designs and getting the right output
# Additionally, take some time to think about the SCENARIO of the RCB experimental design, and its assumptions
# Is it in the lab or in the field? Can we completely control our experimental variation or is it subject to the environment?
