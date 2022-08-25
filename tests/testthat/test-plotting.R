
set.seed(1)
n <- 20
tau <- 6
data <- expand.grid(i = 1:n,
                    t = 1:tau) 

data$g <- data$i > n/2
data$x <- sample(1:5, n * tau, T)
data$y <- data$g + rnorm(n * tau)


data %>% 
  ggplot(ggplot2::aes(x = x, y = y, color = g)) +
  ggplot2::geom_point() 

fit <- fixest::feols(y ~ i(x) |  t, data, split = ~g)

ggiplot(fit)

