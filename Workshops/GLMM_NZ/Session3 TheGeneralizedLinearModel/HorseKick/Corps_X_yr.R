# Poisson GLM - Two crossed factors.
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
 
# quasi Poisson (not available to Preece 1988) yields same ANODEV table
QuasiMod<- glm(Deaths~Corps + as.factor(Year), family=quasipoisson(link="log"), data=Tab04_1Horsekick)
# Neg Binomial yields same ANODEV table
library(MASS)
NBMod<- glm.nb(Deaths~Corps + as.factor(Year), data=Tab04_1Horsekick)
#  Dispersion parameter for Negative Binomial(8366.651) family taken to be 1)
# Warning while fitting theta: iteration limit reached 
# 2 x log-likelihood:  -563.673
-563.673/2  #  = -281.8
258.57*2 # = 517.14
#  -----------------------------------------------------------------
# Run crossed model --> saturated model,  no plots.
CrossedMod<- glm(Deaths~Corps * as.factor(Year), family=poisson(link="log"), data=Tab04_1Horsekick)
anova(CrossedMod, test="Chisq")
# Interaction term   Dev = 258.6, df = 247, Pr(>Chi) = 0.29
# Corps as random.  Interaction coefficient of no interest
# Corps as rixed.   Interaction terms all less then 1+e
summary(CrossedMod)  # Yields coeffcients.  
# Run crossed model No interactive term.  Preece model
CrossedMod<- glm(Deaths~Corps + as.factor(Year), family=poisson(link="log"), data=Tab04_1Horsekick)
anova(CrossedMod, test="Chisq")
plot(CrossedMod)
summary(CrossedMod)
