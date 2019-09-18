# Chapter 3 AIC model selection

#################
## Fitting models ~ Total carbtein
#################

#full model
full.model <- lmer(value ~ species * fpco2 * ftemp * reef + (1 | colony), REML=F, data = T90.df.carb)
full.noR.model <- lmer(value ~ species * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.carb)

#removal of single parameters (all combinations)
dropRZ.model <- lmer(value ~ species * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.carb)
dropT.model <- lmer(value ~ species * fpco2 * reef + (1 | colony), REML=F, data = T90.df.carb)
dropP.model <- lmer(value ~ species * ftemp * reef + (1 | colony), REML=F, data = T90.df.carb)
dropS.model <- lmer(value ~ reef * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.carb)

#removal of 2 fixed effects
dropRZT.model <- lmer(value ~ species * fpco2 + (1 | colony), REML=F, data = T90.df.carb)
dropRZP.model <- lmer(value ~ species * ftemp + (1 | colony), REML=F, data = T90.df.carb)
dropPT.model <- lmer(value ~ species * reef + (1 | colony), REML=F, data = T90.df.carb)
dropRZS.model <- lmer(value ~ ftemp * fpco2 + (1 | colony), REML=F, data = T90.df.carb)
dropSP.model <- lmer(value ~ ftemp * reef + (1 | colony), REML=F, data = T90.df.carb)
dropST.model <- lmer(value ~ fpco2 * reef + (1 | colony), REML=F, data = T90.df.carb)

#single fixed effect
onlyS.model <- lmer(value ~ species + (1 | colony), REML=F, data = T90.df.carb)
onlyT.model <- lmer(value ~ ftemp + (1 | colony), REML=F, data = T90.df.carb)
onlyP.model <- lmer(value ~ fpco2 + (1 | colony), REML=F, data = T90.df.carb)
onlyRZ.model <- lmer(value ~ reef + (1 | colony), REML=F, data = T90.df.carb)

#dropping interactions
interaction1 <- lmer(value ~ species * fpco2 * ftemp + reef + (1 | colony), REML=F, data = T90.df.carb)
interaction2 <- lmer(value ~ species * fpco2 * reef + ftemp + (1 | colony), REML=F, data = T90.df.carb)
interaction3 <- lmer(value ~ species * ftemp * reef + fpco2 + (1 | colony), REML=F, data = T90.df.carb)
interaction4 <- lmer(value ~ species * ftemp * fpco2 + reef + (1 | colony), REML=F, data = T90.df.carb)
interaction5 <- lmer(value ~ fpco2 * ftemp * reef + species + (1 | colony), REML=F, data = T90.df.carb)
interaction6 <- lmer(value ~ species * fpco2 + ftemp + reef + (1 | colony), REML=F, data = T90.df.carb)
interaction7 <- lmer(value ~ species + fpco2 + ftemp * reef + (1 | colony), REML=F, data = T90.df.carb)
interaction8 <- lmer(value ~ species + fpco2 * ftemp + reef + (1 | colony), REML=F, data = T90.df.carb)
interaction9 <- lmer(value ~ species * ftemp + reef + fpco2  +(1 | colony), REML=F, data = T90.df.carb) 
interaction10 <- lmer(value ~ species * reef + fpco2 + ftemp +(1 | colony), REML=F, data = T90.df.carb)
interaction11 <- lmer(value ~ fpco2 * reef + species + ftemp +(1 | colony), REML=F, data = T90.df.carb)
interaction12 <- lmer(value ~ species + fpco2 + ftemp + reef +(1 | colony), REML=F, data = T90.df.carb) #second best

#after removing reef 
noRZ1.model <- lmer(value ~ species * ftemp + fpco2 + (1 | colony), REML=F, data = T90.df.carb) 
noRZ2.model <- lmer(value ~ species + fpco2 + ftemp + (1 | colony), REML=F, data = T90.df.carb) #best AIC without only temp interacting with species
noRZ3.model <- lmer(value ~ fpco2 * ftemp + species + (1 | colony), REML=F, data = T90.df.carb)
noRZ4.model <- lmer(value ~ species * fpco2 + ftemp + (1 | colony), REML=F, data = T90.df.carb)
final.model <- lmer(value ~ species * (fpco2 + ftemp) + (1 | colony), REML=F, data = T90.df.carb) 


# view log likelihood, degrees of freedom, and AIC for all models
model.summary <- cbind(sapply(list(full.model,full.noR.model,dropRZ.model,dropT.model,dropP.model,dropS.model,dropRZT.model,dropRZP.model,dropPT.model,dropRZS.model,dropSP.model,dropST.model,onlyS.model,onlyT.model,onlyP.model,onlyRZ.model,interaction1,interaction2,interaction3,interaction4,interaction5,interaction6,interaction7,interaction8,interaction9,interaction10,interaction11,interaction12,noRZ1.model,noRZ2.model,noRZ3.model,noRZ4.model,final.model
), logLik), AIC(full.model,full.noR.model,dropRZ.model,dropT.model,dropP.model,dropS.model,dropRZT.model,dropRZP.model,dropPT.model,dropRZS.model,dropSP.model,dropST.model,onlyS.model,onlyT.model,onlyP.model,onlyRZ.model,interaction1,interaction2,interaction3,interaction4,interaction5,interaction6,interaction7,interaction8,interaction9,interaction10,interaction11,interaction12,noRZ1.model,noRZ2.model,noRZ3.model,noRZ4.model,final.model
))
colnames(model.summary)[1] <- 'LL'
model.summary

min(model.summary$AIC)


