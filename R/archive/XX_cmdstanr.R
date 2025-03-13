install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
cmdstanr::check_cmdstan_toolchain(fix = TRUE)


# we recommend running this is a fresh R session or restarting your current session
install.packages("cmdstanr", repos = c('https://stan-dev.r-universe.dev', getOption("repos")))
cmdstanr::install_cmdstan()
library(cmdstanr)

set_cmdstan_path("C:/Users/vanandkuma/.cmdstan/cmdstan-2.36.0/cmdstan-2.36.0")

cmdstan_path()
cmdstan_version()
Sys.setenv(CMDSTAN="C:/Users/vanandkuma/.cmdstan/cmdstan-2.36.0/cmdstan-2.36.0")
