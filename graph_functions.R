#function to add edges to a graph
new_edge_with_zero <- function(matrix, x, y){
  matrix[x + 1, y + 1] <- 1
  matrix[y + 1, x + 1] <- 1
  matrix
}

new_edge <- function(matrix, x, y){
  matrix[x, y] <- 1
  matrix[y, x] <- 1
  matrix
}

#generates a graph using a matrix representation
relational_matrix <- function(edges){
  #merge both nodes, and count the uniques - to create all the graph nodes
  nodes <- unique(append(edges[[1]], edges[[2]]))
  size <- length(nodes)
  relational_matrix <- matrix(0, nrow = size, ncol = size)
  has_zero <- sort(nodes)[1] == 0
  for(i in 1:dim(edges)[1]){
    x <- edges[[1]][i]
    y <- edges[[2]][i]
    if(has_zero){
      relational_matrix <- new_edge_with_zero(relational_matrix, x, y)
    }else{
      relational_matrix <- new_edge(relational_matrix, x, y)
    }
    
    i <- i + 1
  }
  relational_matrix
}


#extract min distance from a vector
extract_min <- function(Q){
  Q$name[Q$distance == min(Q$distance)][1]
}

## Dijkstra - min path algorithm
dijkstra <- function(Q, relational_matrix, min_path){
  while(dim(Q)[1] > 1){
    u <- extract_min(Q)
    adjacents <- which(relational_matrix[u,] == 1, arr.ind = TRUE)
    adjacents <- adjacents[adjacents %in% Q$name]
    for(v in adjacents){
      if(Q$distance[Q$name == v] > Q$distance[Q$name == u] + 1){
        Q$distance[Q$name == v] <- Q$distance[Q$name == u] + 1
        min_path[v] <- Q$distance[Q$name == v]
      }
    }
    Q <- Q[Q$name != u,]
  }
  min_path
}

#Runs dijkstra for each node of the graph
generate_distance_matrix <- function(relational_matrix, distance_matrix){
  for(j in 1:dim(relational_matrix)[1]){
    distance <- rep(Inf, dim(relational_matrix)[1])
    distance[j] <- 0
    names <- 1:dim(relational_matrix)[1]
    min_path <- distance
    
    Q <- data.frame(names, distance)
    
    real_min_path <- dijkstra(Q, relational_matrix, min_path)
    distance_matrix <- rbind(distance_matrix, real_min_path)
  }
  colnames(distance_matrix) <- 1:dim(relational_matrix)[1]
  distance_matrix
}

#calculates closeness centrality
closeness <- function(distance_matrix){
  1/rowSums(distance_matrix)
}
