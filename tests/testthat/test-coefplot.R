
n <- 100
set.seed(1)
d <- dplyr::tibble(
  x = runif(n),
  y1 = 1 * x + rnorm(n),
  y2 = 0 * x + rnorm(n),
  y3 = -1 * x + rnorm(n)
)
m <- fixest::feols(
  c(y1, y2, y3) ~ x,
  data = d
)

vlabs <- c("Depvar 1" = "y1", "Depvar 2" = "y2", "Depvar 3" = "y3")

coefplot_wide(m, "x")
coefplot_wide(m, "x", vlabs)
