#' Custom coefficient plot for many fixest models
#'
#' @param models one or more fixest models 
#' @param treat_var a single independent variable. 
#' `coefplot_wide()` returns the coefficient on this variable
#' @param var_labels a named vector of dependent variables, one for each model. 
#' The dependent variable is labeled according to its label.
#' @param report_pct whether to report percent changes for coefficients. Only use for
#' non-linear models. Default is FALSE.
#' 
#' @export
#' 
coefplot_wide <- function(models,
                          treat_var,
                          var_labels = NULL,
                          report_pct = FALSE
                          ){
  
  
  # Create data to plot
  estimate_df <- models %>% 
    purrr::map(as.list) %>% 
    dplyr::tibble(model = .) %>% 
    dplyr::mutate(depvar = as.character(purrr::map(model, ~ .$fml[[2]])),
                  estimates = purrr::map(model, broom::tidy, conf.int = TRUE)) %>% 
    tidyr::unnest(estimates) %>% 
    dplyr::select(-model) %>% 
    dplyr::filter(term == treat_var)
  
  # Create crosswalk of dependent variables to labels
  if(is.null(var_labels)){
    var_label_xwalk <- data.frame(depvar = estimate_df$depvar, 
                                  label = estimate_df$depvar)  
  } else {
    var_label_xwalk <- data.frame(depvar = var_labels, 
                                  label = names(var_labels))  
  }
  

  # Format data
  formatted_df  <- 
    estimate_df %>% 
    dplyr::left_join(var_label_xwalk, by = c("depvar")) %>%
    dplyr::mutate(
                  # Add plus sign if positive
                  sign = ifelse(estimate > 0, "+", ""),
                  
                  # Calculate exponentiated coefficients for percent changes
                  across(c(estimate, conf.low, conf.high), ~ 100 * (exp(.) - 1),
                         .names = "pct_{.col}"),
                  
                  # Obtain formatted estimate
                  report_pct = report_pct,
                  formatted_estimate = ifelse(report_pct,
                                              paste0(sign,
                                                     round(pct_estimate, 1), "% [",
                                                     round(pct_conf.low, 1), "%, ",
                                                     round(pct_conf.high, 1), "%]"),
                                              paste0(round(estimate, 3),
                                                     " (", round(std.error, 3), ")")),
                                              
                  # Label variable
                  var_label = forcats::fct_rev(
                    forcats::fct_inorder(paste0(label, "\n", formatted_estimate)))
                  )
  
  # Plot
  ggplot(formatted_df, ggplot2::aes(x = estimate, y = var_label, 
               parse = TRUE)) +
    ggplot2::geom_point() +
    ggplot2::geom_vline(xintercept = 0, linetype = "dashed", color = "gray50") +
    ggplot2::geom_linerange(ggplot2::aes(xmin = conf.low, xmax = conf.high)) +
    ggplot2::labs(x = "Coefficient", y = "") +
    ggplot2::theme(legend.position = "none")
}
