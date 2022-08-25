#' Custom theme based off of hrbrthemes::theme_ipsum_rc()
#'
#' @export
theme_bergr <- function(){
  ggplot2::theme_void() +
    hrbrthemes::theme_ipsum_rc() +
    ggplot2::theme(plot.title        = ggplot2::element_text(hjust = 0.5),
                   plot.subtitle     = ggplot2::element_text(hjust = 0.5),
                   axis.title.y      = ggplot2::element_text(hjust = 0.5, size = 12),
                   axis.title.x      = ggplot2::element_text(hjust = 0.5, size = 12),
                   strip.text        = ggplot2::element_text(hjust = 0.5),
                   legend.position   = "bottom",
                   legend.title      = ggplot2::element_blank(),
                   legend.background = ggplot2::element_blank())
}

