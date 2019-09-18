# Chapter 3 AIC model selection

#################
## Fitting models ~ Total dentein
#################

#full model
full.model <- lmer(value ~ species * fpco2 * ftemp * reef + (1 | colony), REML=F, data = T90.df.den)
full.noR.model <- lmer(value ~ species * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.den)

#removal of single parameters (all combinations)
dropRZ.model <- lmer(value ~ species * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.den)
dropT.model <- lmer(value ~ species * fpco2 * reef + (1 | colony), REML=F, data = T90.df.den)
dropP.model <- lmer(value ~ species * ftemp * reef + (1 | colony), REML=F, data = T90.df.den)
dropS.model <- lmer(value ~ reef * fpco2 * ftemp + (1 | colony), REML=F, data = T90.df.den)

#removal of 2 fixed effects
dropRZT.model <- lmer(value ~ species * fpco2 + (1 | colony), REML=F, data = T90.df.den)
dropRZP.model <- lmer(value ~ species * ftemp + (1 | colony), REML=F, data = T90.df.den)
dropPT.model <- lmer(value ~ species * reef + (1 | colony), REML=F, data = T90.df.den)
dropRZS.model <- lmer(value ~ ftemp * fpco2 + (1 | colony), REML=F, data = T90.df.den)
dropSP.model <- lmer(value ~ ftemp * reef + (1 | colony), REML=F, data = T90.df.den)
dropST.model <- lmer(value ~ fpco2 * reef + (1 | colony), REML=F, data = T90.df.den)

#single fixed effect
onlyS.model <- lmer(value ~ species + (1 | colony), REML=F, data = T90.df.den)
onlyT.model <- lmer(value ~ ftemp + (1 | colony), REML=F, data = T90.df.den)
onlyP.model <- lmer(value ~ fpco2 + (1 | colony), REML=F, data = T90.df.den)
onlyRZ.model <- lmer(value ~ reef + (1 | colony), REML=F, data = T90.df.den)

#dropping interactions
interaction1 <- lmer(value ~ species * fpco2 * ftemp + reef + (1 | colony), REML=F, data = T90.df.den)
interaction2 <- lmer(value ~ species * fpco2 * reef + ftemp + (1 | colony), REML=F, data = T90.df.den)
interaction3 <- lmer(value ~ species * ftemp * reef + fpco2 + (1 | colony), REML=F, data = T90.df.den)
interaction4 <- lmer(value ~ species * ftemp * fpco2 + reef + (1 | colony), REML=F, data = T90.df.den)
interaction5 <- lmer(value ~ fpco2 * ftemp * reef + species + (1 | colony), REML=F, data = T90.df.den)
interaction6 <- lmer(value ~ species * fpco2 + ftemp + reef + (1 | colony), REML=F, data = T90.df.den)
interaction7 <- lmer(value ~ species + fpco2 + ftemp * reef + (1 | colony), REML=F, data = T90.df.den)
interaction8 <- lmer(value ~ species + fpco2 * ftemp + reef + (1 | colony), REML=F, data = T90.df.den)
interaction9 <- lmer(value ~ species * ftemp + reef + fpco2  +(1 | colony), REML=F, data = T90.df.den) 
interaction10 <- lmer(value ~ species * reef + fpco2 + ftemp +(1 | colony), REML=F, data = T90.df.den)
interaction11 <- lmer(value ~ fpco2 * reef + species + ftemp +(1 | colony), REML=F, data = T90.df.den)
interaction12 <- lmer(value ~ species + fpco2 + ftemp + reef +(1 | colony), REML=F, data = T90.df.den) #second best

#after removing reef 
noRZ1.model <- lmer(value ~ species * ftemp + fpco2 + (1 | colony), REML=F, data = T90.df.den) 
noRZ2.model <- lmer(value ~ species + fpco2 + ftemp + (1 | colony), REML=F, data = T90.df.den) #best AIC 
noRZ3.model <- lmer(value ~ fpco2 * ftemp + species + (1 | colony), REML=F, data = T90.df.den)
noRZ4.model <- lmer(value ~ species * fpco2 + ftemp + (1 | colony), REML=F, data = T90.df.den)
final.model <- lmer(value ~ species * (fpco2 + ftemp) + (1 | colony), REML=F, data = T90.df.den) 


# view log likelihood, degrees of freedom, and AIC for all models
model.summary <- cbind(sapply(list(full.model,full.noR.model,dropRZ.model,dropT.model,dropP.model,dropS.model,dropRZT.model,dropRZP.model,dropPT.model,dropRZS.model,dropSP.model,dropST.model,onlyS.model,onlyT.model,onlyP.model,onlyRZ.model,interaction1,interaction2,interaction3,interaction4,interaction5,interaction6,interaction7,interaction8,interaction9,interaction10,interaction11,interaction12,noRZ1.model,noRZ2.model,noRZ3.model,noRZ4.model,final.model
), logLik), AIC(full.model,full.noR.model,dropRZ.model,dropT.model,dropP.model,dropS.model,dropRZT.model,dropRZP.model,dropPT.model,dropRZS.model,dropSP.model,dropST.model,onlyS.model,onlyT.model,onlyP.model,onlyRZ.model,interaction1,interaction2,interaction3,interaction4,interaction5,interaction6,interaction7,interaction8,interaction9,interaction10,interaction11,interaction12,noRZ1.model,noRZ2.model,noRZ3.model,noRZ4.model,final.model
))
colnames(model.summary)[1] <- 'LL'
model.summary

min(model.summary$AIC)


