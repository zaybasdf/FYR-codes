data {
 int<lower=0> N;
  int<lower=0> y[N];              // count outcomes
  vector<lower=0>[N] E;           // exposure
  vector[N] x;                    // predictor or input
}
transformed data {
  vector[N] log_E = log(E);
}
parameters {
  real beta0; //intercept
  real beta1; // slope
 
  real<lower=0> tau_theta;   // precision of heterogeneous effects

  vector[N] theta;       // heterogeneous effects
}
transformed parameters {
  real<lower=0> sigma_theta = inv(sqrt(tau_theta));  // convert precision to sigma
}
model {
  y ~ poisson_log(log_E + beta0 + beta1*x + theta * sigma_theta);

//  y ~ poisson_log(log_E + beta0 + theta * sigma_theta);

beta0 ~ normal(0,1.2);
beta1 ~ normal(0,1.2);
theta ~ normal(0, 1);
tau_theta ~ normal(0, 0.5);

}

//generated quantities {
  //vector[N] lambda = exp(log_E + beta0 + beta1*x + theta * sigma_theta);
   //vector [N] sSMR = 100 * exp(theta);

// used to create plot for first year review  
  // vector[N] lambda = exp(log_E + beta0 + phi * sigma_phi + theta * sigma_theta);
   //vector [N] sSMR = 100 * exp(beta0 + phi * sigma_phi + theta * sigma_theta);
//}
