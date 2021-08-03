library(bayesplot)
library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

#DATA

datafile = load("C:/Users/monitoringstationsdata_scenario3.RData")
x1=monitoringstations.data$x1 
x2=monitoringstations.data$x2
y=monitoringstations.data$exposure
cova=monitoringstations.data$z
D=2

data = list(N = length(x1), x= cbind(x1 , x2), y, cova)

fit = stan(file='First_Stage.stan', data =data, iter=1500, chains=4)

#fit = stan(file='First_Stage_My_Matern.stan', data =data, iter=50, chains=1)

#fit = stan(file='First_Stage_My_Matern32.stan', data =data, iter=400, chains=4)

pred_params = extract(fit)
