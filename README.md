# Shortest path problem

## The solution

To generate a graph using the R language I chose to use a matrix to represent the graph. In this representation when there is an edge between two nodes (x, y), the matrix[x,y] = 1, and it has a 0 otherwise.

The functions responsible for doing this are `relational_matrix` and `new_edge`.

Since R starts the vectors with 1, not with 0, there is a different function to use in those cases: `new_edge_with_zero`, because the code `matrix[0,2]` won't work on this language. Also, in those cases the response will always be summed by one, so in the given example the final graph has nodes from 1 to 100 instead of 0 to 99.

To calculate the min_path I used the `dijkstra` function, that implements the dijkstra algorithm. The inputs are the graph (`relational_matrix`), `min_path` vector to be used as response and `Q` helper data frame that safes the node and the distances.

To generate a matrix with the distances from all nodes to all nodes I used the `generate_distance_matrix` function. It runs the dijkstra algorithm for each node from the graph, and appends to a new matrix, the distance_matrix.

Using the distance matrix is easy to calculate the centrality. With the `closeness` function I just used the `rowSums` function (R native) to calculate it.

All the implemented functions are in the `graph_functions.R` file.

The `graph.R` file has examples on how to use these functions. The first example is running these functions in the given graph (the edges.dat file). The second example is using a random graph, generated for test purposes.


## To run the code

 - Open an R console in the same path where the files are.

 - The examples are in the `graph.R` file. To run the distance function from the file in the given graph just type:
 `graph <- read.csv('edges.dat', header = TRUE, sep = ' ')`

 - To generate a graph using a matrix represetation you need to type:
 `final_matrix <- relational_matrix(graph)`

 - To calculate the distance from all nodes
  `final_distance_matrix <- generate_distance_matrix(final_matrix, data.frame())`

 - To calculate the centrality from all nodes
  `closeness(final_distance_matrix)`




