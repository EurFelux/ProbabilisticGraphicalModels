install.packages("readxl")
install.packages("bnlearn")
install.packages("dplyr")
install.packages("rmarkdown")

# In order to install the Rgraphviz package.
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("Rgraphviz")

install.packages("rlist")
install.packages("DescTools")
