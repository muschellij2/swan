#' Run SWaN First Pass Prediction of Non-wear
#' @inheritParams swan
#' @export
#' @return A `data.frame` of predictions, without names changed
#' from the Python output
#' @examples
sw_first_pass = function(df, sample_rate) {
  sw = swan_base()
  df = standardize_data(df)
  tzone = attr(df$HEADER_TIME_STAMP, "tzone")
  out = sw$swan_first_pass$estimate_nonwear(df = df,
                                            sampling_rate = sample_rate)
  if (!is.null(out)) {
    attr(out$HEADER_TIME_STAMP, "tzone") = tzone
    attr(out$STOP_TIME, "tzone") = tzone
    attr(out$START_TIME, "tzone") = tzone
  }
  return(out)
}

#' Run SWaN Correction/Smoothing of Predictions
#'
#' @inheritParams swan
#' @export
#' @return A `data.frame` of corrected predictions, without names changed
#' from the Python output
#' @examples
sw_second_pass = function(df) {
  sw = swan_base()
  tzone = attr(df$HEADER_TIME_STAMP, "tzone")
  out = sw$swan_second_pass$correct_nonwear_predictions(df = df)
  attr(out$HEADER_TIME_STAMP, "tzone") = tzone
  attr(out$STOP_TIME, "tzone") = tzone
  attr(out$START_TIME, "tzone") = tzone
  return(out)
}


#' Run SWaN
#'
#' @param df A `data.frame` with `X/Y/Z` and a time in
#' `HEADER_TIMESTAMP`/`HEADER_TIME_STAMP`.
#' @param sample_rate the sampling rate of the data
#'
#' @return A `data.frame` of predictions.
#' @export
#' @examples
#' if (swan_check()) {
#'   file = system.file("extdata", "73557_subset.csv.gz", package = "swan")
#'   if (requireNamespace("readr", quietly = TRUE)) {
#'     df = readr::read_csv(file)
#'     readr::stop_for_problems(df)
#'   } else {
#'     df = read.csv(file)
#'     df = df %>%
#'       dplyr::mutate(
#'         HEADER_TIMESTAMP = sub("Z$", "", HEADER_TIMESTAMP),
#'         HEADER_TIMESTAMP = strptime(HEADER_TIMESTAMP,
#'                                     "%Y-%m-%dT%H:%M:%OS")) %>%
#'       dplyr::as_tibble()
#'   }
#'   out = swan(df, sample_rate = 80L)
#'   out$second_pass %>% dplyr::count(prediction)
#' }
swan = function(df, sample_rate) {
  header_time_stamp = predicted = prediction = NULL
  rm(list = c("header_time_stamp", "predicted", "prediction"))
  assertthat::assert_that(
    is.data.frame(df),
    assertthat::is.count(sample_rate)
  )
  nonwear = sw_first_pass(df = df, sample_rate = sample_rate)
  if (is.null(nonwear) || nrow(nonwear) == 0) {
    stop("First pass did not detect any data/features, cannot get non-wear")
  }
  corrected = sw_second_pass(df = nonwear)
  nonwear = janitor::clean_names(nonwear)
  nonwear = dplyr::as_tibble(nonwear)
  nonwear = nonwear %>%
    dplyr::select(header_time_stamp, predicted, dplyr::everything())
  corrected = janitor::clean_names(corrected)
  corrected = dplyr::as_tibble(corrected)
  corrected = corrected %>%
    dplyr::select(header_time_stamp, prediction, predicted,
                  dplyr::everything())
  list(
    first_pass = nonwear,
    second_pass = corrected
  )
}
