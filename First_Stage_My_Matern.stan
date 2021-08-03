// My try  Matern 5/2 covariance function 

functions {
  matrix L_cov_exp_quad_ARD(vector[] x,
                            real alpha,
                            vector rho,
                            real delta) {
    int N = size(x);
    matrix[N, N] K;
    real sq_alpha = square(alpha);
    for (i in 1:(N-1)) {
      K[i, i] = sq_alpha + delta;
      for (j in (i + 1):N) {
          K[i, j] = sq_alpha*
  (1 + sqrt(5) * sqrt(dot_self((x[i] - x[j]) ./ rho)) + (sqrt(5.0/3) * dot_self((x[i] - x[j]) ./ rho)))
    * exp(- sqrt(5) * sqrt( dot_self((x[i] - x[j]) ./ rho)));
        K[j, i] = K[i, j];
      }
    }
    K[N, N] = sq_alpha + delta;
    return cholesky_decompose(K);
  }
}

data {
  int<lower=1> N;
  int<lower=1> D;
  vector[D] x[N];
  vector[N] y;
  vector[N] cova;  // vector of covariates 
}
transformed data {
  real delta = 1e-9;
}
parameters {
  real b0;
  real b;
  vector<lower=0>[D] rho;
  real<lower=0> alpha;
    real<lower=0> sigma;
    vector[N] eta;
}
model {
  vector[N] f;
      matrix[N, N] L_K = L_cov_exp_quad_ARD(x, alpha, rho, delta);
    f = L_K * eta;
  
  b0 ~ std_normal();
  b ~ std_normal();
  rho ~ inv_gamma(5, 5);
  alpha ~ std_normal();
  sigma ~ std_normal();
  eta ~ std_normal();
  
  
  y ~ normal(b0 + cova * b + f, sigma);
}

