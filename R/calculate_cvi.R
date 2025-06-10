#' Calculates Content Validity Index (CVI) for each item.
#'
#' This function computes the Content Validity Index (CVI) for a set of items rated by multiple judges.
#' It recodes item ratings such that scores of 1 and 2 are considered not valid (0),
#' and scores of 3 and 4 are considered valid (1). Then, it calculates the proportion
#' of valid ratings (1) out of total non-missing ratings per item.
#'
#' Additionally, it evaluates whether each item's CVI is acceptable based on the number of judges,
#' following common recommendations in the literature:
#' \itemize{
#'   \item 2 judges: CVI must be 1
#'   \item 3–5 judges: CVI ≥ 0.83
#'   \item 6–8 judges: CVI ≥ 0.83
#'   \item 9 or more judges: CVI ≥ 0.78
#' }
#'
#' @param data A data frame with one row per judge and one column per item. One column must identify the judge.
#' @param judge_id A string indicating the column name that identifies each judge.
#'
#' @return A data frame with one row per item and the following columns:
#' \describe{
#'   \item{item}{Item name}
#'   \item{n_judges}{Number of judges who rated the item}
#'   \item{n_valid}{Number of judges who rated the item as valid (3 or 4)}
#'   \item{cvi}{Content Validity Index: \code{n_valid / n_judges}}
#'   \item{min_acceptable}{Minimum acceptable CVI threshold for that number of judges}
#'   \item{acceptable}{Logical value indicating whether the item meets the acceptable threshold}
#' }
#'
#' @export
#'
#' @examples
#' df <- data.frame(
#'   judge = c("A", "B", "C"),
#'   item1 = c(4, 3, 2),
#'   item2 = c(1, 4, NA),
#'   item3 = c(3, 2, 3)
#' )
#' calculate_cvi(data = df, judge_id = "judge")

calculate_cvi <- function(data = NULL, judge_id = NULL) {
  # Verificaciones básicas
  if (is.null(data) || is.null(judge_id)) {
    stop("Debes proveer un dataframe y el nombre de la columna que identifica a los jueces.")
  }

  # Verifica que judge_id esté en los nombres del dataframe
  if (!judge_id %in% names(data)) {
    stop("La columna indicada como judge_id no está en el dataframe.")
  }

  # Selecciona solo las columnas que son ítems
  item_cols <- setdiff(names(data), judge_id)

  # Recodifica los puntajes: 1 y 2 → 0, 3 y 4 → 1, NA → NA
  data_recoded <- data |>
    dplyr::mutate(dplyr::across(dplyr::all_of(item_cols), ~ dplyr::case_when(
      .x %in% c(3, 4) ~ 1,
      .x %in% c(1, 2) ~ 0,
      TRUE ~ NA_real_
    )))

  # Pasa a formato largo y calcula el CVI
  resultado <- data_recoded |>
    tidyr::pivot_longer(cols = dplyr::all_of(item_cols),
                        names_to = "item",
                        values_to = "score") |>
    dplyr::group_by(item) |>
    dplyr::summarise(
      n_judges = sum(!is.na(score)),
      n_valid = sum(score, na.rm = TRUE),
      cvi = n_valid / n_judges,
      .groups = "drop"
    ) |>
    dplyr::mutate(
      min_acceptable = dplyr::case_when(
        n_judges == 2 ~ 1,
        n_judges >= 3 & n_judges <= 5 ~ 0.83,
        n_judges >= 6 & n_judges <= 8 ~ 0.83,
        n_judges >= 9 ~ 0.78,
        TRUE ~ NA_real_
      ),
      acceptable = cvi >= min_acceptable
    )

  return(resultado)
}
