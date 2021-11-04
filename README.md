# Bayesian Analysis of Lyme Disease and Sleep Deprivation

There are 2 independent projects that use Bayesian data analysis techniques. The detailed analysis and results can be found in the report. Below are the brief summaries of these projects.

## Project A - Lyme Disease
100 ticks are collected from field and grasslands. It is found that 12 of them carry Borrelia bacteria. In a previous experiment, 10 ticks were collected and it was found that 2 of them carry Borrelia bacteria. The random variable is the occurrence of Borrelia bacteria.

Analysis steps:
- Likelihood for the historical data is found (binomial) and the kernel of it is matched with a known density function to find the prior distribution (beta).
- Using the prior distribution and likelihood funcion, posterior distribution is found (beta).
- Posterior summary measures (mode, mean, median, variance and credible interval) are calculated.
- Predictions are calculated using posterior predictive distributions (PPD).

## Project B - Sleep Deprivation
The data describes the effect of sleep deprivation on cognitive performance. 18 subjects were
restricted to 3 hours of sleep. Their reaction time to a visual stimulus (in ms) was measured. Markov Chain Monte Carlo (MCMC) simulation techniques are used.

Analysis steps:
- Non-informative priors are used.
- The initial values selected are based on maximum likelihood parameter estimates and standard errors, and the initial values are randomly sampled from their corresponding distributions.
- The model is updated with 1000 runs and diagnostic measures of convergence are examined. The diagnostic plots are created.
- The posterior probability that reaction time is increased by 10ms per day is calculated as 0.3 (30%).
- Posterior predictive distributions at days 0-9 are obtained from the same sampling model. Distributions as OpenBUGS output are visualized.
- An alternative method is compared. However, the methods are not significantly different.
