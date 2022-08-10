#Randomizing F-values from many permutations of a GLM using sample data
#So results are comparable - have F-value, p-value, and likelihood ratio

#Assign independent variable as factor 
abba$Year <- as.factor(abba$Year)
nreps <- 10000
samp.F <- numeric(nreps)
counter <- 0

#Build GLM and extract F value and p-value 
abbarandomP <- anova(lm(abba$P ~ abba$Year + abba$Site))
obt.F <- abbarandomP$`F value`[1]
obt.p <- abbarandomP$`Pr(>F)`[1]
#Print these values so you know what they are 
obt.F
obt.p

#Randomize data and compute F-distribution 
for (i in 1:nreps){
  newP <- sample(abba$P, 114)
  newabbarandomP <- anova(lm(newP ~ abba$Year + abba$Site))
  samp.F[i] <- newabbarandomP$`F value`[[1]]
  if (samp.F[i] < (-abs(obt.F))){
    counter = counter + 1  
  } 
  else
    if (samp.F[i] > (abs(obt.F))) {
      counter = counter + 1
    }
}

counter
#Compute p-value using counter, if value more extreme than would be expected if 
#null hypothesis were true, it will be added to counter
#Divide counter (number of F-values more extreme than observed value) 
#by number of permutations to obtain the p-value 
abbaPpvalue <- counter/nreps
abbaPpvalue

#Produce histogram of F-distribution
hist(samp.F, breaks = 50, main = "Balsam Fir - Phosphorus (%)",
     xlab = "F value")
legend("topright", paste("Obtained F Value = ", round(obt.F, digits = 4)))
legend("right",paste("p-value = ",round(abbaPpvalue, digits = 4)))
