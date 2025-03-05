# Reproduce ANODEV in Preece 1988  
# 14 different corps
# Year as categorical

library(readxl)
Tab04_1Horsekick <- read_excel("Tab04_1Horsekick.xlsx", sheet = "ModelFormat")
View(Tab04_1Horsekick)
# Run Preece two term model.
PoisMod<- glm(Deaths~Corps +as.factor(Year), family=poisson(link="log"), data=Tab04_1Horsekick)
plot(PoisMod)   
summary(PoisMod)
anova(PoisMod)    #Exactly matches Preece tabulation
# mean deviance = 
258.59/247  # = 1.047    No overdispersion.
 
# Run with quasi Poisson (not available to Preece 1988)
QuasiMod<- glm(Deaths~Corps + as.factor(Year), family=quasipoisson(link="log"), data=Tab04_1Horsekick)
plot(QuasiMod)   
summary(QuasiMod)
anova(QuasiMod)  # Same result as Poisson model.  
# Extra parameter makes no difference
  258.59/247 #   = 1.047   No overdispersion.
# Preece shows fit of frequency distribution to gamma distribution
# Preece shows improvement in fit due to NB compared to Poisson
  0.004144 * 280 # = 1.16 less than 3.84 critical value on 1 df
  1-pchisq(1.16,1)  #  = 0.28
# What sample size is needed to reach critical value on 1 df
  0.004144 * 927  # = 3.84 critical value on 1 df
# Run with Neg Binomial (cf Preece 1988)
library(MASS)
NBMod<- glm.nb(Deaths~Corps + as.factor(Year), data=Tab04_1Horsekick)
plot(NBMod)   
summary(NBMod)
#  Dispersion parameter for Negative Binomial(8366.651) family taken to be 1)
# Warning while fitting theta: iteration limit reached 
# 2 x log-likelihood:  -563.673
-563.673/2  #  = -281.8
258.57*2 # = 517.14
anova(NBMod, test="Chisq")    # Same table as Poisson. 
# Extra parameter makes no difference
# Preece calculates sample size to detect significant (P<0.05) improvement
0.004144 * 927 # = 3.84 critical value on 1 df
