# Repeat analyses used in lecture notes.  
# 4 different corps, 2 corps/duty
# Year as categorical and as trend

library(readxl)
Kick4Corps <- read_excel("Kick4Corps.xls",sheet = "ModelFormat")
View(Kick4Corps)
# Compare 4 Corps that differ in duty.
KickMod<- glm(Deaths~as.factor(Year)*Corps, family=poisson(link="log"), data=Kick4Corps)
# Saturated model.  no plot(KickMod)   
summary(KickMod)
anova(KickMod)
#  By duty, ligher duty for Guard and First
KickMod<- glm(Deaths~as.factor(Year)*Duty, family=poisson(link="log"), data=Kick4Corps)
plot(KickMod)   
summary(KickMod)
anova(KickMod)
#  Run year as trend instead of factor
KickMod<- glm(Deaths~Year*Corps, family=poisson(link="log"), data=Kick4Corps)
plot(KickMod)   
summary(KickMod)
anova(KickMod)
#  By duty, lighter duty for Guard and First
KickMod<- glm(Deaths~Year*Duty, family=poisson(link="log"), data=Kick4Corps)
plot(KickMod)   
summary(KickMod)
anova(KickMod)

exp(-0.0341)  # slope  %/yr
exp(-0.0341) - 1  # annual loss
exp(0.08152)  # intercept  1875 = 0
