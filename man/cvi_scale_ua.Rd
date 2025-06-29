% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cvi_scale_ua.R
\name{cvi_scale_ua}
\alias{cvi_scale_ua}
\title{Calculates scale-level CVI using the universal agreement method}
\usage{
cvi_scale_ua(cvi_df)
}
\arguments{
\item{cvi_df}{A data frame output from \code{calculate_cvi()}, containing item-level CVIs.}
}
\value{
A data frame with:
\describe{
\item{method}{The method used: \code{"universal_agreement"}}
\item{scale_cvi}{The scale-level CVI (proportion of items with CVI = 1)}
\item{min_acceptable}{The minimum acceptable CVI value (same criterion as used for items)}
\item{acceptable}{Whether the scale CVI is acceptable}
}
}
\description{
This function computes the scale-level Content Validity Index (S-CVI) based on universal agreement,
i.e., the proportion of items rated as valid (CVI = 1) by all judges.
}
\examples{
cvi <- calculate_cvi(data = df, judge_id = "judge")
cvi_scale_ua(cvi)
}
