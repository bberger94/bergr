# bergr

## Overview

bergr is a package of useful functions and defaults for analyzing data in R. Its particular emphasis is providing tools for common data manipulation, data visualization, and modeling tasks for causal inference. Currently it includes wrappers for `ggplot` and `ggiplot` that improve upon the default theme and color scheme. It also includes a function `coefplot_wide()` for plotting a single coefficient across many fixest models. 

To install `bergr` you'll need to first install the `devtools` package. 

``` r
# Install bergr from github
devtools::install_github("bberger94/bergr")
```
