PSMod<- lm(Length~Treatment, data = Box9_4)
hist(Box9_4$Length)  #The "Data" are not normally distributed
# The histogram shows data distribution relative to the overall mean
# The assumption for GLM anova are that the data are normally distributed
#   relative to the model parameters.
# Equivalently, that the residuals are normal
hist(PSMod$residuals)
# We see that that residuals are normally distributed
# Evaluate homogeneity with residual vs fit plot
plot(PSMod)
# The residuals are homogeneous (uniform band in residual fit plot)
# THe residuals are normal in the qq plot
anova(PSMod)
# When we run the anova (with the correct data set) 
# We see the results shown in Ch10.3 presentation