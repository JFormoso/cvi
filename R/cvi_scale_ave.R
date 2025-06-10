#' Calculates scale-level CVI using the average method
#'
#' This function computes the scale-level Content Validity Index (S-CVI) as the average
#' of the item-level CVIs.
#'
#' @param cvi_df A data frame output from \code{calculate_cvi()}, containing item-level CVIs.
#'
#' @return A data frame with:
#' \describe{
#'   \item{method}{The method used: \code{"average"}}
#'   \item{scale_cvi}{The scale-level CVI (average of item CVIs)}
#'   \item{min_acceptable}{The minimum acceptable CVI value (same criterion as used for items)}
#'   \item{acceptable}{Whether the scale CVI is acceptable}
#' }
#'
#' @export
#'
#' @examples
#' cvi <- calculate_cvi(data = df, judge_id = "judge")
#' cvi_scale_ave(cvi)
cvi_scale_ave <- function(cvi_df) {
  scale_cvi <- mean(cvi_df$cvi, na.rm = TRUE)

  # Se asume que todos los ítems tienen el mismo número de jueces
  avg_judges <- round(mean(cvi_df$n_judges, na.rm = TRUE))

  min_acceptable <- dplyr::case_when(
    avg_judges == 2 ~ 1,
    avg_judges >= 3 & avg_judges <= 5 ~ 0.83,
    avg_judges >= 6 & avg_judges <= 8 ~ 0.83,
    avg_judges >= 9 ~ 0.78,
    TRUE ~ NA_real_
  )

  acceptable <- scale_cvi >= min_acceptable

  tibble::tibble(
    method = "average",
    scale_cvi = scale_cvi,
    min_acceptable = min_acceptable,
    acceptable = acceptable
  )
}
