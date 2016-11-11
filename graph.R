#read file
graph <- read.csv('~/workspace/graph_challenge/edges.dat', header = TRUE, sep = ' ')

#verify number of rows and columns
rows <- sort(unique(graph$X48))
cols <- sort(unique(graph$X64))

relational_matrix <- matrix(0, nrow = 100, ncol = 100)

for(i in 1:dim(graph)[1]){
  relational_matrix[graph[i,]$X64 + 1, graph[i,]$X48 + 1] <- 1
  relational_matrix[graph[i,]$X48 + 1, graph[i,]$X64 + 1] <- 1
  i <- i + 1 
}

## Dijkstra

distance <- rep(Inf, 100)
distance[1] <- 0
min_path <- distance
names <- 1:100
Q <- data.frame(names, distance)

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

real_min_path <- dijkstra(Q, relational_matrix, min_path)



extract_min <- function(Q){
  Q$name[Q$distance == min(Q$distance)][1]
}

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
distance <- rep(Inf, 6)
min_path <- distance
distance[1] <- 0
names <- 1:6

Q <- data.frame(names, distance)


