#' Recursively save elements of a list of ggplots
#' @description
#' Save a nested list of ggplots in a directory with the same structure. 
#'
#' @param x A list of ggplots that you wish to save to disk as individual files.
#' @param root Character of length 1 that specifies the root directory. Your files will be saved in `root` or in subdirectories thereof.
#' @param ext Character of length 1 that specifies the file extension. "png" by default.
#' @param verbose Set to FALSE if you do not wish to print file paths as they save.
#' @param remove_title Set to TRUE if you wish to remove titles from each plot.

#' @param ... Arguments to pass to ggplot.
#'
#' @return NULL
#' @export
#'
#' @examples
#' # Make list of plots
#' library(ggplot2)
#' library(fs)
#' p1 <- ggplot(head(mtcars), aes(x = cyl, y = mpg))
#' p2 <- ggplot(tail(mtcars), aes(x = cyl, y = mpg))
#' my_list <- list(
#'   a = p1,
#'   b = list(c = p2)
#' )
#' # Set temporary root directory
#' temp <- tempdir()
#' root <- paste0(temp, "/plots")
#' dir.create(root, showWarnings = FALSE)
#' # Save files
#' save_plots(my_list, root = root, height = 4, width = 6)
#' dir_tree(root)
save_plots <- function(x, root, ext = "png", 
                       verbose = T,
                       remove_title = F,
                       ...){
  purrr::walk2(x, names(x), \(el, name){
    # Save ggplot
    if(ggplot2::is.ggplot(el)){
      path <- paste0(root, "/", name, ".", ext)
      if(verbose) print(path)
      if(remove_title) el <- el + ggplot2::labs(title = NULL, subtitle = NULL)
      ggplot2::ggsave(path, el, ...)
    } 
    # Or descend into list
    else{
      path <- paste0(root, "/", name)
      dir.create(path, showWarnings = F)
      save_plots(el, path, ext = ext,
                 remove_title = remove_title,
                 verbose = verbose,
                 ...)  
    }
  })
  return(NULL)
}
