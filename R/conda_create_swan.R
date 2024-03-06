
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
    packages = "git+https://github.com/muschellij2/SWaN_accel",
    pip = TRUE, envname = envname, method = "conda")
  invisible(NULL)
}

#' @rdname conda_create_swan
#' @export
use_swan_condaenv = function(envname = "swan") {
  reticulate::use_condaenv(condaenv = envname, required = TRUE)
}

#' @export
#' @rdname conda_create_swan
unset_reticulate_python = function() {
  Sys.unsetenv("RETICULATE_PYTHON")
}



#' @rdname conda_create_swan
#' @export
have_swan_condaenv = function(envname = "swan") {
  reticulate::condaenv_exists(envname = envname)
}

module_version = function(module = "numpy") {
  assertthat::is.scalar(module)
  if (!reticulate::py_module_available(module)) {
    stop(paste0(module, " is not installed!"))
  }
  df = reticulate::py_list_packages()
  df$version[df$package == module]
}

#' @rdname conda_create_swan
#' @export
swan_version = function() {
  module_version("SWaN_accel")
}

#' @rdname conda_create_swan
#' @export
have_swan = function() {
  reticulate::py_module_available("SWaN_accel")
}

#' @rdname conda_create_swan
#' @export
swan_check = function() {
  swan_version = try({
    swan_version()
  }, silent = TRUE)
  have_swan() && !inherits(swan_version, "try-error") &&
    length(swan_version) > 0
}
