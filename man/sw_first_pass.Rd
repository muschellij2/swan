% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/swan.R
\name{sw_first_pass}
\alias{sw_first_pass}
\title{Run SWaN First Pass Prediction of Non-wear}
\usage{
sw_first_pass(df, sampling_rate)
}
\arguments{
\item{df}{A \code{data.frame} with \code{X/Y/Z} and a time in
\code{HEADER_TIMESTAMP}/\code{HEADER_TIME_STAMP}.}

\item{sampling_rate}{the sampling rate of the data}
}
\value{
A \code{data.frame} of predictions, without names changed
from the Python output
}
\description{
Run SWaN First Pass Prediction of Non-wear
}
