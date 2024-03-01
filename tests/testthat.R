# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

library(testthat)
library(swan)
rtp = Sys.getenv("RETICULATE_PYTHON")
unset_reticulate_python()
remove_swan_condaenv = FALSE
if (!have_swan_condaenv()) {
  remove_swan_condaenv = TRUE
  swan::conda_create_swan(envname = "swan")
}
use_swan_condaenv()

test_check("swan")
Sys.setenv("RETICULATE_PYTHON" = rtp)
if (remove_swan_condaenv) {
  reticulate::conda_remove(envname = "swan")
}
