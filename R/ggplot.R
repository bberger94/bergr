#' ggplot with bergr theme and Dark2 color scheme
#'
#' @param ... Arguments to be passed on to ggplot2::ggplot.
#' 
#' @export
#' 
ggplot <- function(...){
  ggplot2::ggplot(...) +
    ggplot2::scale_color_brewer(palette = "Dark2") +
    ggplot2::scale_fill_brewer(palette = "Dark2") +
    theme_bergr()
}

#' ggiplot with bergr theme and Dark2 color scheme
#'
#' @param ... Arguments to be passed on to ggiplot::ggiplot.
#'
#' @export
#' 
ggiplot <- function(...){
  suppressMessages({
    ggiplot::ggiplot(...) +
      ggplot2::theme_void() +
      theme_bergr() +
      ggplot2::scale_color_brewer(palette = "Dark2") +
      ggplot2::scale_fill_brewer(palette = "Dark2")  
  })
}

