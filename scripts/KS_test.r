#!/usr/bin/Rscript
# Import poweRlaw library
library(poweRlaw)

# declaring vectors used
repo_names <- c("atom","cask","Dancer2","django", "docker", "ejabberd", "fission", "mojo", "Moose", "rakudo", "scalatra", "tensorflow", "tpot", "tty", "vue", "webpack")
p_values_2017 <- c()
p_values_2019 <- c()

# Analysis for the 2017 repos
for (repo_name in repo_names){
  repo = paste("lines_",repo_name,"_2017.csv",sep="")
  data_2017 <- read.csv(repo) # import data
  data_2017 <- data_2017[data_2017>0] # erase commits with 0 changes
  final_data = data.matrix(data_2017) # Update vector type
  m_m = displ$new(final_data) # Declare fit object
  est=estimate_xmin(m_m) # Estimate x_min
  m_m$setXmin(est) # Set x_min as calculated
  est_1=estimate_pars(m_m) # estimate parameters
  bs_p = bootstrap_p(m_m, no_of_sims=500, threads=15) #Execute bootstrapin to test powerlaw hypotehsis.
  p_values_2017 <- c(p_values_2017, bs_p$p) # add values to a vector
} 

final_dataframe <- data.frame(repo_names,p_values_2017) # add all  information to a dataframe
write.csv(final_dataframe, file="P-values_2017.csv") # create a file with it.


# Analysis for the 2019 repos 
# Same comments as above
for (repo_name in repo_names){
  repo = paste("lines_",repo_name,"_2019.csv",sep="")
  data_2019 <- read.csv(repo)
  data_2019 <- data_2019[data_2019>0]
  final_data = data.matrix(data_2019)
  m_m = displ$new(final_data)
  est=estimate_xmin(m_m)
  m_m$setXmin(est)
  est_1=estimate_pars(m_m)
  bs_p = bootstrap_p(m_m, no_of_sims=500, threads=15)
  p_values_2019 <- c(p_values_2019, bs_p$p)
} 

final_dataframe <- data.frame(repo_names,p_values_2019)
write.csv(final_dataframe, file="P-values_2019.csv")

