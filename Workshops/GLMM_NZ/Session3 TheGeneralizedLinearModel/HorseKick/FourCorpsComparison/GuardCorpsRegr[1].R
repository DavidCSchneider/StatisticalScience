Guard$Count<-as.integer(Guard$Count)
KickMod<- glm(Count~Year, family=poisson(link="log"), data=Guard)
summary(KickMod)
Anova(KickMod)

Guard$Year<- (Guard$Year-1875)
KickMod<- glm(Count~Year, family=poisson(link="log"), data=Guard)
summary(KickMod)
Anova(KickMod)
exp(-0.0341)  # slope  %/yr
exp(-0.0341) - 1  # annual loss
exp(0.08152)  # intercept  1875 = 0
