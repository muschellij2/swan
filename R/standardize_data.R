standardize_data = function(data) {
  HEADER_TIMESTAMP = TIME = HEADER_TIME_STAMP = X = Y = Z = NULL
  rm(list = c("HEADER_TIMESTAMP", "HEADER_TIME_STAMP", "X", "Y", "Z",
              "TIME"))
  if (is.matrix(data)) {
    if (is.numeric(data)) {
      stopifnot(ncol(data) == 3)
      data = as.data.frame(data)
      colnames(data) = c("X", "Y", "Z")
    } else {
      stop("data is a matrix and cannot be coerced to necessary structure")
    }
  }
  # uppercase
  colnames(data) = toupper(colnames(data))
  cn = colnames(data)
  if ("TIME" %in% cn && !"HEADER_TIMESTAMP" %in% cn) {
    data = data %>%
      dplyr::rename(HEADER_TIMESTAMP = TIME)
  }
  if ("HEADER_TIME_STAMP" %in% cn && !"HEADER_TIMESTAMP" %in% cn) {
    data = data %>%
      dplyr::rename(HEADER_TIMESTAMP = HEADER_TIME_STAMP)
  }
  if ("HEADER_TIMESTAMP" %in% colnames(data)) {
    if (is.unsorted(data$HEADER_TIMESTAMP)) {
      stop("Time in data must be sorted before running!")
    }
  }
  data = data %>%
    dplyr::select(HEADER_TIMESTAMP, X, Y, Z)
  tz = lubridate::tz(df$HEADER_TIMESTAMP)
  attr(df$HEADER_TIMESTAMP, "tzone") <- tz
  data = data %>%
    dplyr::rename(HEADER_TIME_STAMP = HEADER_TIMESTAMP,
           X_ACCELERATION_METERS_PER_SECOND_SQUARED = X,
           Y_ACCELERATION_METERS_PER_SECOND_SQUARED = Y,
           Z_ACCELERATION_METERS_PER_SECOND_SQUARED = Z
    )
  data
}

