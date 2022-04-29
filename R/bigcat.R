#' Print a string surrounded by stars
#'
#' @param x A character vector with one element.
#'
#' @export
#'
#' @examples
#' bigcat("Load the data")
bigcat <- function(x){
  nc <- nchar(x)
  stars <- rep("*", nc + 3)
  cat(stars, "\n", x, "\n", stars, sep = "")
}