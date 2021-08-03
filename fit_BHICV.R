library(rstan) 
 
options(mc.cores = parallel::detectCores())  


source("BHICV_DATA.R")
y = data$y;
E = data$E;
x = data$x

BHICV_stanfit = stan("PHM.stan",data=list(N,y,E,x), iter=500);


#print(BHICV_stanfit,
 #     pars=c("lp__", "sigma_theta", "tau_theta", "beta0"),
  #    probs=c(0.025, 0.5, 0.975),digits=3)

#print(BHICV_stanfit, pars = "sSMR")

print(BHICV_stanfit)
#print(lambda)
#}
#used to create plot for the first year review report

#mat <- as.matrix(COPD_stanfit, pars = "sSMR")
#matrix <- as.matrix(colMeans(mat))
#write.table(matrix, file="mymatrixforbymsSMR.txt", row.names=TRUE, col.names=TRUE)

