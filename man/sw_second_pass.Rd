% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/swan.R
\name{sw_second_pass}
\alias{sw_second_pass}
\title{Run SWaN Correction/Smoothing of Predictions}
\usage{
sw_second_pass(df)
}
\arguments{
\item{df}{A \code{data.frame} with \code{X/Y/Z} and a time in
\code{HEADER_TIMESTAMP}/\code{HEADER_TIME_STAMP}.}
}
\value{
A \code{data.frame} of corrected predictions, without names changed
from the Python output
}
\description{
Run SWaN Correction/Smoothing of Predictions
}
