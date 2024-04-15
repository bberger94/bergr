#' Recursively save elements of a list of strings
#' @description
#' Save a nested list of strings in a directory with the same structure. Works great for latex tables!
#'
#' @param x A list of character vectors that you wish to save to disk as individual files.
#' @param root Character of length 1 that specifies the root directory. Your files will be saved in `root` or in subdirectories thereof.
#' @param ext Character of length 1 that specifies the file extension. "tex" by default.
#' @param verbose Set to FALSE if you do not wish to print file paths as they save.
#'
#' @return NULL
#' @export
#'
#' @examples
#' # Make list of tables
#' library(bergr)
#' library(knitr)
#' library(fs)
#' d1 <- head(mtcars)
#' d2 <- tail(mtcars)
#' my_list <- list(
#'   a = knitr::kable(d1, format = "latex"),
#'   b = list(c = knitr::kable(d2, format = "latex"))
#' )
#' # Set temporary root directory
#' temp <- tempdir()
#' root <- paste0(temp, "/tabs")
#' dir.create(root, showWarnings = FALSE)
#' # Save files
#' save_tabs(my_list, root = root)
#' dir_tree(root)
save_tabs <- function(x, root, ext = "tex",
                      verbose = T){
  purrr::walk2(x, names(x), \(el, name){
    if(is.character(el)){
      path <- paste0(root, "/", name, ".", ext)
      if(verbose) print(path)
      writeLines(el, path)
    } 
    else{
      path <- paste0(root, "/", name)
      dir.create(path, showWarnings = F)
      save_tabs(el, path)
    }
  })
  return(NULL)
}
