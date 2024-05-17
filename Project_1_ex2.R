# Load the necessary libraries
library(bnlearn)

# Create DAG
dag <- empty.graph(nodes = c("A", "S", "E", "O", "R", "T"))
dag <- set.arc(dag, from = "A", to = "E")
dag <- set.arc(dag, from = "S", to = "E")
dag <- set.arc(dag, from = "E", to = "O")
dag <- set.arc(dag, from = "E", to = "R")
dag <- set.arc(dag, from = "O", to = "T")
dag <- set.arc(dag, from = "R", to = "T")
print(dag)

