% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_ci_lmer.R
\name{add_ci.lmerMod}
\alias{add_ci.lmerMod}
\title{Confidence Intervals for Linear Mixed Model Predictions}
\usage{
\method{add_ci}{lmerMod}(tb, fit, alpha = 0.05, names = NULL,
  yhatName = "pred", type = "parametric", includeRanef = TRUE,
  nSims = 200, ...)
}
\arguments{
\item{tb}{A tibble or data frame of new data.}

\item{fit}{An object of class \code{lmerMod}.}

\item{alpha}{A real number between 0 and 1. Controls the confidence
level of the interval estimates.}

\item{names}{\code{NULL} or character vector of length two. If
\code{NULL}, confidence bounds automatically will be named by
\code{add_ci}, otherwise, the lower confidence bound will be
named \code{names[1]} and the upper confidence bound will be
named \code{names[2]}.}

\item{yhatName}{A string. Name of the predictions vector.}

\item{type}{A string. Must be \code{"parametric"} or \code{"boot"},
If \code{type = "boot"}, then \code{add_ci} calls
\code{lme4::bootMer} to calculate the confidence
intervals. This method may be time consuming, but is applicable
with random slope and random intercept models. The parametric
method is fast, but currently only works well for random
intercept models.}

\item{includeRanef}{A logical. Default is \code{TRUE}. Set whether
the predictions and intervals should be made conditional on the
random effects. If \code{FALSE}, random effects will not be
included.}

\item{nSims}{A positive integer.  Controls the number of bootstrap
replicates if \code{type = "boot"}.}

\item{...}{Additional arguments.}
}
\value{
A tibble, \code{tb}, with predicted values, upper and lower
    confidence bounds attached.
}
\description{
This function is one of the methods for \code{add_ci}, and is
called automatically when \code{add_ci} is used on a \code{fit} of
class \code{lmerMod}. It is recommended that one use parametric
confidence intervals when modeling with a random intercept linear
mixed model (i.e. a fit with a formula such as \code{lmer(y ~ x +
(1|group))}). Otherwise, confidence intervals may be simulated
bootstrapped via \code{lme4::bootMer}.
}
\details{
Bootstrapped intervals are slower to compute, but they are the
recommended method when working with any linear mixed models more
complicated than the random intercept model.
}
\examples{
# Define the data set
dat <- lme4::sleepstudy
# Fit a linear mixed model (random intercept model)
fit <- lme4::lmer(Reaction ~ Days + (1|Subject), data = lme4::sleepstudy)
# Get the fitted values for each observation in dat, and
# append CIs for those fitted values to dat
add_ci(dat, fit, alpha = 0.5)
# Try the parametric bootstrap method, and make prediction at the population level
add_ci(dat, fit, alpha = 0.5, type = "boot", includeRanef = FALSE, nSims = 100)

}
\seealso{
\code{\link{add_pi.lmerMod}} for prediction intervals
    of \code{lmerMod} objects, \code{\link{add_probs.lmerMod}} for
    conditional probabilities of \code{lmerMod} objects, and
    \code{\link{add_quantile.lmerMod}} for response quantiles of
    \code{lmerMod} objects.
}
