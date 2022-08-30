
n <- 100
set.seed(1)
d <- dplyr::tibble(
  x = runif(n),
  y1 = rpois(n, lambda = exp(1  * x)),
  y2 = rpois(n, lambda = exp(0  * x)),
  y3 = rpois(n, lambda = exp(-1 * x))
)
m <- fixest::fepois(
  c(y1, y2, y3) ~ x,
  data = d
)

vlabs <- c("Depvar 1" = "y1", "Depvar 2" = "y2", "Depvar 3" = "y3")

coefplot_wide(m, "x")
coefplot_wide(m, "x", vlabs)
coefplot_wide(m, "x", vlabs, report_pct = TRUE)
