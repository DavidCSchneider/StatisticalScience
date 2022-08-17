
HzygM <- glm(HZYG~Elev_km, data=Brussard)
aov(HzygM)
logLik(HzygM)
anova(lm(HzygM))
summary(HzygM)
?AIC
AIC(HzygM)   #reports AIC
?extractAIC 
extractAIC(HzygM)  #reports Equivalent df and AIC
