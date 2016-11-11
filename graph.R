#read file
new_edge <- function(empty_matrix){
  empty_matrix[graph[i,]$X64 + 1, graph[i,]$X48 + 1] <- 1
  empty_matrix[graph[i,]$X48 + 1, graph[i,]$X64 + 1] <- 1
  empty_matrix
}

## Dijkstra

extract_min <- function(Q){
  Q$name[Q$distance == min(Q$distance)][1]
}

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

centrality <- function(distance_matrix){
  1/rowSums(distance_matrix)
}

graph <- read.csv('~/workspace/graph_challenge/edges.dat', header = TRUE, sep = ' ')

distance <- rep(Inf, 100)
distance[1] <- 0
min_path <- distance
names <- 1:100
Q <- data.frame(names, distance)

#verify number of rows and columns
rows <- sort(unique(graph$X48))
cols <- sort(unique(graph$X64))

relational_matrix <- matrix(0, nrow = 100, ncol = 100)

for(i in 1:dim(graph)[1]){
  relational_matrix <- new_edge(relational_matrix)
  i <- i + 1 
}

final_distance_matrix <- generate_distance_matrix(relational_matrix, distance_matrix)
centrality(final_distance_matrix)

####
# test 1
###

X48 <- c(1, 2, 2, 3, 4, 1, 4)
X64 <- c(2, 3, 4, 4, 5, 5, 6)

graph <- data.frame(X48, X64)

relational_matrix <- matrix(0, nrow = 6, ncol = 6)

for(i in 1:dim(graph)[1]){
  relational_matrix[graph[i,]$X64, graph[i,]$X48] <- 1
  relational_matrix[graph[i,]$X48, graph[i,]$X64] <- 1
  i <- i + 1 
}

relational_matrix

distance_matrix <- data.frame()

final_distance_matrix <- generate_distance_matrix(relational_matrix, distance_matrix)








