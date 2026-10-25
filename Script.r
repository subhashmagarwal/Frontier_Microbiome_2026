library(readxl)
library(meta)

data <- data.frame(
  Paper = character(),
  ca_m = numeric(),
  ca_s = numeric(),
  ca_n = integer(),
  co_m = numeric(),
  co_s = numeric(),
  co_n = integer(),
  stringsAsFactors = FALSE
)

columns <- names(data)
i <- 1

repeat {
  cat("\nEntering row:", i, "\n")
  
  paper <- readline("Study: ")
  ca_m <- as.numeric(readline("Mean: "))
  ca_s <- as.numeric(readline("Std: "))
  ca_n <- as.integer(readline("Number: "))
  co_m <- as.numeric(readline("Mean: "))
  co_s <- as.numeric(readline("Std: "))
  co_n <- as.integer(readline("Number: "))
  
  data[i, ] <- list(
    paper, ca_m, ca_s, ca_n,
    co_m, co_s, co_n
  )
  
  i <- i + 1
  
  more <- readline("Add another row? (y/n): ")
  if (tolower(more) != "y") break
}

meta_result <- metacont(n.e = data$ca_n, mean.e = data$ca_m, sd.e = data$ca_s, n.c = data$co_n, mean.c = data$co_m, sd.c = data$co_s,data = data,studlab = data$Paper, sm = "SMD", method.smd = "Hedges", method.tau = "REML", method.random.ci = "HK", comb.fixed = FALSE, comb.random = TRUE)

summary(meta_result)
