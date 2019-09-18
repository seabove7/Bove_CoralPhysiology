# Chapter 3 AIC model selection

#################
## Fitting models ~ Total sumtein
#################

#full model
full.model <- lmer(value ~ species * fpco2 * ftemp * reef + (1 | colony), REML=F, data = T90.df.sum)
full.noR.model <- lmer(value ~ species * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.sum)

#removal of single parameters (all combinations)
dropRZ.model <- lmer(value ~ species * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.sum)
dropT.model <- lmer(value ~ species * fpco2 * reef + (1 | colony), REML=F, data = T90.df.sum)
dropP.model <- lmer(value ~ species * ftemp * reef + (1 | colony), REML=F, data = T90.df.sum)
dropS.model <- lmer(value ~ reef * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.sum)

#removal of 2 fixed effects
dropRZT.model <- lmer(value ~ species * fpco2 + (1 | colony), REML=F, data = T90.df.sum)
dropRZP.model <- lmer(value ~ species * ftemp + (1 | colony), REML=F, data = T90.df.sum)
dropPT.model <- lmer(value ~ species * reef + (1 | colony), REML=F, data = T90.df.sum)
dropRZS.model <- lmer(value ~ ftemp * fpco2 + (1 | colony), REML=F, data = T90.df.sum)
dropSP.model <- lmer(value ~ ftemp * reef + (1 | colony), REML=F, data = T90.df.sum)
dropST.model <- lmer(value ~ fpco2 * reef + (1 | colony), REML=F, data = T90.df.sum)

#single fixed effect
onlyS.model <- lmer(value ~ species + (1 | colony), REML=F, data = T90.df.sum)
onlyT.model <- lmer(value ~ ftemp + (1 | colony), REML=F, data = T90.df.sum)
onlyP.model <- lmer(value ~ fpco2 + (1 | colony), REML=F, data = T90.df.sum)
onlyRZ.model <- lmer(value ~ reef + (1 | colony), REML=F, data = T90.df.sum)

#dropping interactions
interaction1 <- lmer(value ~ species * fpco2 * ftemp + reef + (1 | colony), REML=F, data = T90.df.sum) #second best
interaction2 <- lmer(value ~ species * fpco2 * reef + ftemp + (1 | colony), REML=F, data = T90.df.sum)
interaction3 <- lmer(value ~ species * ftemp * reef + fpco2 + (1 | colony), REML=F, data = T90.df.sum)
interaction4 <- lmer(value ~ species * ftemp * fpco2 + reef + (1 | colony), REML=F, data = T90.df.sum)
interaction5 <- lmer(value ~ fpco2 * ftemp * reef + species + (1 | colony), REML=F, data = T90.df.sum)
interaction6 <- lmer(value ~ species * fpco2 + ftemp + reef + (1 | colony), REML=F, data = T90.df.sum)
interaction7 <- lmer(value ~ species + fpco2 + ftemp * reef + (1 | colony), REML=F, data = T90.df.sum)
interaction8 <- lmer(value ~ species + fpco2 * ftemp + reef + (1 | colony), REML=F, data = T90.df.sum)
interaction9 <- lmer(value ~ species * ftemp + reef + fpco2  +(1 | colony), REML=F, data = T90.df.sum) 
interaction10 <- lmer(value ~ species * reef + fpco2 + ftemp +(1 | colony), REML=F, data = T90.df.sum)
interaction11 <- lmer(value ~ fpco2 * reef + species + ftemp +(1 | colony), REML=F, data = T90.df.sum)
interaction12 <- lmer(value ~ species + fpco2 + ftemp + reef +(1 | colony), REML=F, data = T90.df.sum) 

#after removing reef 
noRZ1.model <- lmer(value ~ species * ftemp + fpco2 + (1 | colony), REML=F, data = T90.df.sum) 
noRZ2.model <- lmer(value ~ species + fpco2 + ftemp + (1 | colony), REML=F, data = T90.df.sum)
noRZ3.model <- lmer(value ~ fpco2 * ftemp + species + (1 | colony), REML=F, data = T90.df.sum)
noRZ4.model <- lmer(value ~ species * fpco2 + ftemp + (1 | colony), REML=F, data = T90.df.sum)
final.model <- lmer(value ~ species * (fpco2 + ftemp) + (1 | colony), REML=F, data = T90.df.sum) #best AIC 


# view log likelihood, degrees of freedom, and AIC for all models
model.summary <- cbind(sapply(list(full.model,full.noR.model,dropRZ.model,dropT.model,dropP.model,dropS.model,dropRZT.model,dropRZP.model,dropPT.model,dropRZS.model,dropSP.model,dropST.model,onlyS.model,onlyT.model,onlyP.model,onlyRZ.model,interaction1,interaction2,interaction3,interaction4,interaction5,interaction6,interaction7,interaction8,interaction9,interaction10,interaction11,interaction12,noRZ1.model,noRZ2.model,noRZ3.model,noRZ4.model,final.model
), logLik), AIC(full.model,full.noR.model,dropRZ.model,dropT.model,dropP.model,dropS.model,dropRZT.model,dropRZP.model,dropPT.model,dropRZS.model,dropSP.model,dropST.model,onlyS.model,onlyT.model,onlyP.model,onlyRZ.model,interaction1,interaction2,interaction3,interaction4,interaction5,interaction6,interaction7,interaction8,interaction9,interaction10,interaction11,interaction12,noRZ1.model,noRZ2.model,noRZ3.model,noRZ4.model,final.model
))
colnames(model.summary)[1] <- 'LL'
model.summary

min(model.summary$AIC)


