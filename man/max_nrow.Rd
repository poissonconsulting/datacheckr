% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{max_nrow}
\alias{max_nrow}
\title{Maximum Number of Rows}
\usage{
max_nrow()
}
\value{
A count of the maximum number of possible rows.
}
\description{
A wrapper for \code{2^31 - 1}
which defines the \emph{theoretical}
maximum number of rows in a data.frame.
}
\examples{
max_nrow()
}
