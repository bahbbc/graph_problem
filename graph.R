source('graph_functions.R')

####
# challenge file
###

#read file
graph <- read.csv('edges.dat', header = TRUE, sep = ' ')

#generates the graph
final_matrix <- relational_matrix(graph)

#calculates the distance from all nodes
print(final_distance_matrix <- generate_distance_matrix(final_matrix, data.frame()))

#calculates closeness centrality from all nodes
print(closeness(final_distance_matrix))

####
# test 1 - Random graph
###

X48 <- c(1, 2, 2, 3, 4, 1, 4)
X64 <- c(2, 3, 4, 4, 5, 5, 6)

graph <- data.frame(X48, X64)

relational_matrix <- relational_matrix(graph)

distance_matrix <- data.frame()

final_distance_matrix <- generate_distance_matrix(relational_matrix, distance_matrix)
closeness(final_distance_matrix)







