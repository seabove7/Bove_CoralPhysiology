# Chapter 3 AIC model selection

#################
## Fitting models ~ Total chlatein
#################

#full model
full.model <- lmer(value ~ species * fpco2 * ftemp * reef + (1 | colony), REML=F, data = T90.df.chla)
full.noR.model <- lmer(value ~ species * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.chla)  #best AIC 

#removal of single parameters (all combinations)
dropRZ.model <- lmer(value ~ species * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.chla)
dropT.model <- lmer(value ~ species * fpco2 * reef + (1 | colony), REML=F, data = T90.df.chla)
dropP.model <- lmer(value ~ species * ftemp * reef + (1 | colony), REML=F, data = T90.df.chla)
dropS.model <- lmer(value ~ reef * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.chla)

#removal of 2 fixed effects
dropRZT.model <- lmer(value ~ species * fpco2 + (1 | colony), REML=F, data = T90.df.chla)
dropRZP.model <- lmer(value ~ species * ftemp + (1 | colony), REML=F, data = T90.df.chla)
dropPT.model <- lmer(value ~ species * reef + (1 | colony), REML=F, data = T90.df.chla)
dropRZS.model <- lmer(value ~ ftemp * fpco2 + (1 | colony), REML=F, data = T90.df.chla)
dropSP.model <- lmer(value ~ ftemp * reef + (1 | colony), REML=F, data = T90.df.chla)
dropST.model <- lmer(value ~ fpco2 * reef + (1 | colony), REML=F, data = T90.df.chla)

#single fixed effect
onlyS.model <- lmer(value ~ species + (1 | colony), REML=F, data = T90.df.chla)
onlyT.model <- lmer(value ~ ftemp + (1 | colony), REML=F, data = T90.df.chla)
onlyP.model <- lmer(value ~ fpco2 + (1 | colony), REML=F, data = T90.df.chla)
onlyRZ.model <- lmer(value ~ reef + (1 | colony), REML=F, data = T90.df.chla)

#dropping interactions
interaction1 <- lmer(value ~ species * fpco2 * ftemp + reef + (1 | colony), REML=F, data = T90.df.chla) #second best
interaction2 <- lmer(value ~ species * fpco2 * reef + ftemp + (1 | colony), REML=F, data = T90.df.chla)
interaction3 <- lmer(value ~ species * ftemp * reef + fpco2 + (1 | colony), REML=F, data = T90.df.chla)
interaction4 <- lmer(value ~ species * ftemp * fpco2 + reef + (1 | colony), REML=F, data = T90.df.chla)
interaction5 <- lmer(value ~ fpco2 * ftemp * reef + species + (1 | colony), REML=F, data = T90.df.chla)
interaction6 <- lmer(value ~ species * fpco2 + ftemp + reef + (1 | colony), REML=F, data = T90.df.chla)
interaction7 <- lmer(value ~ species + fpco2 + ftemp * reef + (1 | colony), REML=F, data = T90.df.chla)
interaction8 <- lmer(value ~ species + fpco2 * ftemp + reef + (1 | colony), REML=F, data = T90.df.chla)
interaction9 <- lmer(value ~ species * ftemp + reef + fpco2  +(1 | colony), REML=F, data = T90.df.chla) 
interaction10 <- lmer(value ~ species * reef + fpco2 + ftemp +(1 | colony), REML=F, data = T90.df.chla)
interaction11 <- lmer(value ~ fpco2 * reef + species + ftemp +(1 | colony), REML=F, data = T90.df.chla)
interaction12 <- lmer(value ~ species + fpco2 + ftemp + reef +(1 | colony), REML=F, data = T90.df.chla) 

#after removing reef 
noRZ1.model <- lmer(value ~ species * ftemp + fpco2 + (1 | colony), REML=F, data = T90.df.chla) 
noRZ2.model <- lmer(value ~ species + fpco2 + ftemp + (1 | colony), REML=F, data = T90.df.chla)
noRZ3.model <- lmer(value ~ fpco2 * ftemp + species + (1 | colony), REML=F, data = T90.df.chla)
noRZ4.model <- lmer(value ~ species * fpco2 + ftemp + (1 | colony), REML=F, data = T90.df.chla)
final.model <- lmer(value ~ species * (fpco2 + ftemp) + (1 | colony), REML=F, data = T90.df.chla) 


# view log likelihood, degrees of freedom, and AIC for all models
model.summary <- cbind(sapply(list(full.model,full.noR.model,dropRZ.model,dropT.model,dropP.model,dropS.model,dropRZT.model,dropRZP.model,dropPT.model,dropRZS.model,dropSP.model,dropST.model,onlyS.model,onlyT.model,onlyP.model,onlyRZ.model,interaction1,interaction2,interaction3,interaction4,interaction5,interaction6,interaction7,interaction8,interaction9,interaction10,interaction11,interaction12,noRZ1.model,noRZ2.model,noRZ3.model,noRZ4.model,final.model
), logLik), AIC(full.model,full.noR.model,dropRZ.model,dropT.model,dropP.model,dropS.model,dropRZT.model,dropRZP.model,dropPT.model,dropRZS.model,dropSP.model,dropST.model,onlyS.model,onlyT.model,onlyP.model,onlyRZ.model,interaction1,interaction2,interaction3,interaction4,interaction5,interaction6,interaction7,interaction8,interaction9,interaction10,interaction11,interaction12,noRZ1.model,noRZ2.model,noRZ3.model,noRZ4.model,final.model
))
colnames(model.summary)[1] <- 'LL'
model.summary

min(model.summary$AIC)


