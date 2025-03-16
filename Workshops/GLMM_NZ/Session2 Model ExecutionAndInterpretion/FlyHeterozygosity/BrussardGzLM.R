HzygMod1<-lm(H~SP*Elev_km, data=Brussard)
res <- resid(HzygMod1)
fits <- fitted(HzygMod1)
plot(fits,res)
hist(res, col=NULL, border = "black", breaks=c(-.1125,-.0875,-0.0625,-0.0375,-0.0125,0.0125,0.0375,0.0625))
hist(res,col=NULL, border="Black",breaks=7)
qqnorm(res)
lag.plot(res)
lag.plot(res,1,layout=c(1,1),asp=NA, diag = FALSE, do.lines = FALSE)
plot(Brussard$Elev_km,res)
km_Lbl <- c(1,3,5,6,8,9,10,1, 3, 5, 6, 8, 9, 10)
km_Lbl <- as.character(km_Lbl)
lag.plot(res,1,layout=c(1,1),asp=NA, diag = FALSE, do.lines = FALSE,labels=km_Lbl)
anova(HzygMod1)              #Sequential
install.packages("MASS")
library(MASS, car)
Anova(HzygMod1, type="II")   #Adjusted
Anova(HzygMod1, type="III")  #Adjusted
# Run GLM model as special case of GzLM
HzygMod2<-glm(H~SP*Elev_km, data=Brussard)
anova(HzygMod2)              #Sequential
Anova(HzygMod2, type="II")   #Adjusted
Anova(HzygMod2, type="III")  #ADjusted

