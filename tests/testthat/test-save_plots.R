test_that("Can recursively save plots", {
  # Make list of plots
  p1 <- ggplot2::ggplot(head(mtcars), ggplot2::aes(x = cyl, y = mpg))
  p2 <- ggplot2::ggplot(tail(mtcars), ggplot2::aes(x = cyl, y = mpg))
  my_list <- list(
    a = p1,
    b = list(c = p2)
  )
  # Set temporary root directory
  temp <- tempdir()
  root <- paste0(temp, "/plots")
  dir.create(root, showWarnings = FALSE)
  # Save files
  save_plots(my_list, root = root, height = 4, width = 6)
  fs::dir_tree(root)
  # Define paths
  paths <- c(
    paste0(root, "/a.png"),
    paste0(root, "/b/c.png")
  )
  # Check if all exist
  expect_true(all(file.exists(paths)))
})
