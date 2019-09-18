# Chapter 3 AIC model selection

#################
## Fitting models ~ Total Protein
#################

#full model
full.model <- lmer(value ~ species * fpco2 * ftemp * reef + (1 | colony), REML=F, data = T90.df.pro)
full.noR.model <- lmer(value ~ species * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.pro)

#removal of single parameters (all combinations)
dropRZ.model <- lmer(value ~ species * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.pro)
dropT.model <- lmer(value ~ species * fpco2 * reef + (1 | colony), REML=F, data = T90.df.pro)
dropP.model <- lmer(value ~ species * ftemp * reef + (1 | colony), REML=F, data = T90.df.pro)
dropS.model <- lmer(value ~ reef * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.pro)

#removal of 2 fixed effects
dropRZT.model <- lmer(value ~ species * fpco2 + (1 | colony), REML=F, data = T90.df.pro)
dropRZP.model <- lmer(value ~ species * ftemp + (1 | colony), REML=F, data = T90.df.pro)
dropPT.model <- lmer(value ~ species * reef + (1 | colony), REML=F, data = T90.df.pro)
dropRZS.model <- lmer(value ~ ftemp * fpco2 + (1 | colony), REML=F, data = T90.df.pro)
dropSP.model <- lmer(value ~ ftemp * reef + (1 | colony), REML=F, data = T90.df.pro)
dropST.model <- lmer(value ~ fpco2 * reef + (1 | colony), REML=F, data = T90.df.pro)

#single fixed effect
onlyS.model <- lmer(value ~ species + (1 | colony), REML=F, data = T90.df.pro)
onlyT.model <- lmer(value ~ ftemp + (1 | colony), REML=F, data = T90.df.pro)
onlyP.model <- lmer(value ~ fpco2 + (1 | colony), REML=F, data = T90.df.pro)
onlyRZ.model <- lmer(value ~ reef + (1 | colony), REML=F, data = T90.df.pro)

#dropping interactions
interaction1 <- lmer(value ~ species * fpco2 * ftemp + reef + (1 | colony), REML=F, data = T90.df.pro)
interaction2 <- lmer(value ~ species * fpco2 * reef + ftemp + (1 | colony), REML=F, data = T90.df.pro)
interaction3 <- lmer(value ~ species * ftemp * reef + fpco2 + (1 | colony), REML=F, data = T90.df.pro)
interaction4 <- lmer(value ~ species * ftemp * fpco2 + reef + (1 | colony), REML=F, data = T90.df.pro)
interaction5 <- lmer(value ~ fpco2 * ftemp * reef + species + (1 | colony), REML=F, data = T90.df.pro)
interaction6 <- lmer(value ~ species * fpco2 + ftemp + reef + (1 | colony), REML=F, data = T90.df.pro)
interaction7 <- lmer(value ~ species + fpco2 + ftemp * reef + (1 | colony), REML=F, data = T90.df.pro)
interaction8 <- lmer(value ~ species + fpco2 * ftemp + reef + (1 | colony), REML=F, data = T90.df.pro)
#interaction9 <- lmer(value ~ species * ftemp + reef + fpco2  +(1 | colony), REML=F, data = T90.df.pro) #second best
interaction10 <- lmer(value ~ species * reef + fpco2 + ftemp +(1 | colony), REML=F, data = T90.df.pro)
interaction11 <- lmer(value ~ fpco2 * reef + species + ftemp +(1 | colony), REML=F, data = T90.df.pro)
interaction12 <- lmer(value ~ species + fpco2 + ftemp + reef +(1 | colony), REML=F, data = T90.df.pro)

#after removing reef 
#noRZ1.model <- lmer(value ~ species * ftemp + fpco2 + (1 | colony), REML=F, data = T90.df.pro) 
noRZ2.model <- lmer(value ~ species + fpco2 + ftemp + (1 | colony), REML=F, data = T90.df.pro) 
noRZ3.model <- lmer(value ~ fpco2 * ftemp + species + (1 | colony), REML=F, data = T90.df.pro)
noRZ4.model <- lmer(value ~ species * fpco2 + ftemp + (1 | colony), REML=F, data = T90.df.pro)
final.model <- lmer(value ~ species * (fpco2 + ftemp) + (1 | colony), REML=F, data = T90.df.pro) #best AIC without only temp interacting with species


# view log likelihood, degrees of freedom, and AIC for all models
model.summary <- cbind(sapply(list(full.model,full.noR.model,dropRZ.model,dropT.model,dropP.model,dropS.model,dropRZT.model,dropRZP.model,dropPT.model,dropRZS.model,dropSP.model,dropST.model,onlyS.model,onlyT.model,onlyP.model,onlyRZ.model,interaction1,interaction2,interaction3,interaction4,interaction5,interaction6,interaction7,interaction8,interaction9,interaction10,interaction11,interaction12,noRZ1.model,noRZ2.model,noRZ3.model,noRZ4.model,final.model
), logLik), AIC(full.model,full.noR.model,dropRZ.model,dropT.model,dropP.model,dropS.model,dropRZT.model,dropRZP.model,dropPT.model,dropRZS.model,dropSP.model,dropST.model,onlyS.model,onlyT.model,onlyP.model,onlyRZ.model,interaction1,interaction2,interaction3,interaction4,interaction5,interaction6,interaction7,interaction8,interaction9,interaction10,interaction11,interaction12,noRZ1.model,noRZ2.model,noRZ3.model,noRZ4.model,final.model
))
colnames(model.summary)[1] <- 'LL'
model.summary

min(model.summary$AIC)


