testthat::test_that("swan gives 3 classes works", {
  testthat::skip_if_not_installed("readr")
  testthat::skip_if(swan::swan_check())
  file = system.file("extdata", "73557_subset.csv.gz", package = "swan")

  df = readr::read_csv(file)
  readr::stop_for_problems(df)
  out = swan(df, sampling_rate = 80L)
  testthat::expect_named(
    out, c("first_pass", "second_pass")
  )
  testthat::expect_true(
    all(out$second_pass$prediction %in% c("Nonwear", "Sleep", "Wear"))
  )
  tab = out$second_pass %>% dplyr::count(prediction)
  att = attributes(tab)
  att$pandas.index = NULL
  attributes(tab) = att

  check_tab = structure(list(
    prediction = c("Nonwear", "Sleep", "Wear"), n = c(121L,
                                                      126L, 353L)),
    row.names = c(NA, 3L), class = c("tbl_df", "tbl",
                                     "data.frame"))
  testthat::expect_equal(tab, check_tab)
})
