
#' Create Conda Environmment for `swan`
#'
#' @param envname conda environment name for the modules to be installed
#' @param ... additional arguments to pass to [reticulate::conda_create()]
#'
#' @return Nothing, called for side effects
#' @export
conda_create_swan = function(envname = "swan", ...) {
  reticulate::conda_create(
    envname = envname,
    packages = c("scikit-learn==0.23.2",
                 "pandas==1.1.3",
                 "scipy==1.5.2",
                 "numpy==1.19.2"),
    ...
  )
  reticulate::py_install(
    packages = "git+https://github.com/muschellij2/SWaN",
    pip = TRUE, envname = envname)
  invisible(NULL)
}

#' @rdname conda_create_swan
#' @export
have_swan_condaenv = function(envname = "swan") {
  reticulate::condaenv_exists(envname = envname)
}
