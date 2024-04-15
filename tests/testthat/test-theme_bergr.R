# Test that plot renders
library(ggplot2)

test_that("creates a plot", {
  p <- ggplot(mtcars) +
    geom_point(aes(x = cyl, y = mpg)) +
    theme_bergr()
  expect_true(is.ggplot(p))
})