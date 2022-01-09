#data<-read.csv("C:\\Users\\ritag\\Documents\\UNI STATISTICA\\MODELLI LINEARI GENERALIZZATI\\PRIMA PRESENTAZIONE\\Life Expectancy Data.csv", header = T, stringsAsFactors = F)
View(data)

dati<-data[-which(data$Year!=2015), -c(2,6, 7, 8,14, 21)]
aspettativa<-na.omit(dati)

for (i in 1:nrow(aspettativa)){
  if(aspettativa[i,2]=="Developing"){aspettativa[i,2] = as.numeric(0)} else {aspettativa[i,2]=as.numeric(1)}  }

which.min(aspettativa$Life.expectancy) #51
aspettativa[107, ]
which.max(aspettativa$Life.expectancy) #85
aspettativa[28, ]

m <- mean(aspettativa$Life.expectancy)
std <- sqrt(var(aspettativa$Life.expectancy))
plot(density(aspettativa[, 3]), xlab = "")
curve(dnorm(x, mean = m, sd = std), col="red", add=T)


round(cor(aspettativa[, -c(1, 2)]), digits=3)

cor(as.numeric(aspettativa$Status), aspettativa$Schooling)


dataset<-aspettativa[, -c(10, 14)] 

mod_full<-lm(Life.expectancy~Status + Adult.Mortality + GDP + BMI + Hepatitis.B + Polio + Schooling + HIV.AIDS + Measles+ thinness.5.9.years+ Population + under.five.deaths, data = dataset)
summary(mod_full)

mod1<-lm(Life.expectancy~Status + Adult.Mortality + under.five.deaths+ GDP + BMI + Population + Schooling, data = dataset)
summary(mod1)

library(leaps)
status_BMI <- as.numeric(aspettativa$Status) * aspettativa$BMI
status_gdp <- as.numeric(aspettativa$Status) * aspettativa$GDP
formula <- Life.expectancy~Status + Adult.Mortality + GDP + BMI + Hepatitis.B + Polio + Schooling + HIV.AIDS + Measles+ thinness.5.9.years+ Population + under.five.deaths

modsub=regsubsets(formula,data=dataset, nbest = 1, nvmax = NULL, force.in = NULL, force.out = NULL, method = "exhaustive")
best.sub=summary(modsub)
# BIC
plot(-best.sub$bic,pch=19,cex=1.5,type="b",las=1,col="dodgerblue", xlab = "")
# Variable selection
plot(modsub,scale="bic",las=1,col="dodgerblue")
plot(modsub, scale = "adjr2", las=1, col="pink")

mod_consigliato <- lm(Life.expectancy~ Adult.Mortality +Polio + Schooling + HIV.AIDS, data = dataset)
summary(mod_consigliato)


mod_prova <- lm(Life.expectancy~ Status + Adult.Mortality  + Polio + Schooling + HIV.AIDS, data = dataset)
summary(mod_prova)

res1 <- t(mod_prova$residuals)%*% mod_prova$residuals
res2 <- t(mod_consigliato$residuals)%*%mod_consigliato$residuals
(res1 -res2)/(res2/(130-4))

mod_forse <- lm(Life.expectancy~Status + Adult.Mortality + GDP + BMI + Hepatitis.B + Polio + Schooling + HIV.AIDS + thinness.5.9.years, data = dataset)
summary(mod_forse)

mod_finale <- mod_consigliato
summary(mod_finale)
plot(mod_finale)
library(lmtest)
bptest(mod_finale)
dwtest(mod_finale)

hist(mod_finale$residuals, freq = F)
lines(density(mod_finale$residuals), col= "red")
qqnorm(mod_finale$residuals)

data[2923, ]
data[2907, ]
data[1475, ]
cook <- cooks.distance(mod_finale)
summary(cook)
which.max(cook) 
plot(cook)
identify(cook)
modello_noleva <- lm(Life.expectancy~ Adult.Mortality +Polio + Schooling + HIV.AIDS, data = dataset[-c(130, 129), ])
summary(modello_noleva)
dataset[c(68, 129, 130), ]


mean(dataset$Life.expectancy) #70.74154
mean(dataset$Adult.Mortality) #158.68
mean(dataset$Polio) #81.12308
mean(dataset$HIV.AIDS) #0.7853846
mean(dataset$Schooling) #12.74692

mod_prova1 <- lm(Life.expectancy~Status + Adult.Mortality + Hepatitis.B + Polio + Schooling + HIV.AIDS + thinness.5.9.years, data = dataset)
AIC(mod_prova1)
summary(mod_prova1)

confint(mod_finale, level = 0.99)
predict <- predict(mod_finale, level=0.99, interval = "prediction")
plot(predict)

status_BMI <- as.numeric(dataset$Status) * dataset$BMI
status_gdp <- as.numeric(dataset$Status) * dataset$GDP
status_adultmort <- as.numeric(dataset$Status) * dataset$Adult.Mortality
status_hepatitis <- as.numeric(dataset$Status) * dataset$Hepatitis.B
status_polio <- as.numeric(dataset$Status) * dataset$Polio
status_schooling <- as.numeric(dataset$Status) * dataset$Schooling
status_hiv <- as.numeric(dataset$Status) * dataset$HIV.AIDS
status_measles <- as.numeric(dataset$Status) * dataset$Measles
status_thinness <- as.numeric(dataset$Status) * dataset$thinness.5.9.years
status_pop <- as.numeric(dataset$Status) * dataset$Population
status_underfive <- as.numeric(dataset$Status) * dataset$under.five.deaths
mod_full1<-lm(Life.expectancy~Status + Adult.Mortality + GDP + BMI + Hepatitis.B + Polio + Schooling + HIV.AIDS + Measles+ thinness.5.9.years+ 
                Population + under.five.deaths + status_adultmort + status_gdp + status_BMI + status_hepatitis + status_polio
              + status_schooling + status_hiv + status_measles + status_thinness + status_pop + status_underfive, data = dataset)
summary(mod_full1)
