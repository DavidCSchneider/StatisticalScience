# Run diagnostics with nested Anova
# Use fixed effects GzLModel to extract components.
# Cage and Fly have numeric labels so we use factor() 
# factor(Flynested) has nested labelling, 1-12
# factor(FlyCrossed) has crossed labelling, 1-4 in each cage
DDef <- Brussard
GzLMod<-aov(H ~ SP + Elev_km +  SP*Elev_km, DDef)
Residuals <-resid(GzLMod)
FittedValues <-fitted(GzLMod)
plot(FittedValues,Residuals, xlab="Fitted Values", ylab="Residuals")
# main="ANCOVA. Fly heterozygosity data from Brussard1")
hist(Residuals,breaks = 7,col="lightgray",border="black")
qqnorm(Residuals, main="")
lag.res <- lag(Residuals)
lag.plot(Residuals,1,layout=c(1,1),asp=NA, diag = FALSE, do.lines = FALSE)
#
anova(GzLMod, test="F")
summary(GzLMod)
# Run GzLM
GzLMod<-glm(H ~ SP + Elev_km + SP*Elev_km, family=gaussian(link = identity), data= DDef)
Residuals <-resid(GzLMod)
FittedValues <-fitted(GzLMod)
plot(FittedValues,Residuals, xlab="Fitted Values", ylab="Residuals")
# main="ANCOVA. Fly heterozygosity data from Brussard1")
hist(Residuals)
qqnorm(Residuals, main="")
lag.res <- lag(Residuals)
lag.plot(Residuals,1,layout=c(1,1),asp=NA, diag = FALSE, do.lines = FALSE)
# 
logLik(GzLMod)
anova(GzLMod, test = "LRT")
anova.glm(GzLMod)   # could not find function "anova.glm
effects(GzLMod)
summary.glm(GzLMod)
install.packages("car")
library(car)
Anova(GzLMod, type = "III")

install.packages("stats")
library(stats)
sasLM(GzLMod) # Gives error message: could not find function "sasLM"
