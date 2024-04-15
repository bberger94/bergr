
test_that("Can recursively save tables", {
  # Make list of tables
  d1 <- head(mtcars)
  d2 <- tail(mtcars)
  my_list <- list(
    a = knitr::kable(d1, format = "latex"),
    b = list(c = knitr::kable(d2, format = "latex"))
    )
  # Set temporary root directory
  temp <- tempdir()
  root <- paste0(temp, "/tabs")
  dir.create(root, showWarnings = FALSE)
  # Save files
  save_tabs(my_list, root = root)
  fs::dir_tree(root)
  # Define paths
  paths <- c(
    paste0(root, "/a.tex"),
    paste0(root, "/b/c.tex")
  )
  # Check if all exist
  expect_true(all(file.exists(paths)))
})
