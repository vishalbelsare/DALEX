% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predict_diagnostics.R
\name{predict_diagnostics}
\alias{predict_diagnostics}
\alias{individual_diagnostics}
\title{Instance Level Residual Diagnostics}
\usage{
predict_diagnostics(
  explainer,
  new_observation,
  variables = NULL,
  ...,
  nbins = 20,
  neighbors = 50,
  distance = gower::gower_dist
)

individual_diagnostics(
  explainer,
  new_observation,
  variables = NULL,
  ...,
  nbins = 20,
  neighbors = 50,
  distance = gower::gower_dist
)
}
\arguments{
\item{explainer}{a model to be explained, preprocessed by the 'explain' function}

\item{new_observation}{a new observation for which predictions need to be explained}

\item{variables}{character - name of variables to be explained}

\item{...}{other parameters}

\item{nbins}{number of bins for the histogram. By default 20}

\item{neighbors}{number of neighbors for histogram. By default 50.}

\item{distance}{the distance function, by default the \code{gower_dist()} function.}
}
\value{
An object of the class 'predict_diagnostics'.
It's a data frame with calculated distribution of residuals.
}
\description{
This function performs local diagnostic of residuals.
For a single instance its neighbors are identified in the validation data.
Residuals are calculated for neighbors and plotted against residuals for all data.
Find information how to use this function here: \url{https://ema.drwhy.ai/localDiagnostics.html}.
}
\examples{
\donttest{
library("ranger")
titanic_glm_model <- ranger(survived ~ gender + age + class + fare + sibsp + parch,
                     data = titanic_imputed)
explainer_glm <- explain(titanic_glm_model,
                         data = titanic_imputed,
                         y = titanic_imputed$survived)
johny_d <- titanic_imputed[24, c("gender", "age", "class", "fare", "sibsp", "parch")]

id_johny <- predict_diagnostics(explainer_glm, johny_d, variables = NULL)
id_johny
plot(id_johny)

id_johny <- predict_diagnostics(explainer_glm, johny_d,
                       neighbors = 10,
                       variables = c("age", "fare"))
id_johny
plot(id_johny)

id_johny <- predict_diagnostics(explainer_glm,
                       johny_d,
                       neighbors = 10,
                       variables = c("class", "gender"))
id_johny
plot(id_johny)
}

}
\references{
Explanatory Model Analysis. Explore, Explain, and Examine Predictive Models. \url{https://ema.drwhy.ai/}
}
