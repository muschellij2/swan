.onLoad <- function(libname, pkgname) {
  reticulate::py_require(
    packages = c(
      "git+https://github.com/muschellij2/SWaN_accel",
      "scikit-learn==0.23.2",
      "pandas==1.1.3",
      "scipy==1.5.2",
      "numpy==1.19.2"),
    python_version = "3.8")
}
