#read file
graph <- read.csv('/home/barbara/workspace/graph-problem/edges.dat', header = TRUE, sep = ' ')

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
names <- 1:100

Q <- data.frame(names, distance)

while(length(Q) > 1){
  u <- extract_min(Q)
  adjacents <- which(relational_matrix[u,] == 1, arr.ind = TRUE)
  for(v in adjacents){
    if(Q$distance[v] > Q$distance[u] + 1){
      Q$distance[v] <- Q$distance[u] + 1
      min_path[v] <- Q$distance[v]
    }
  }
  Q <- Q[Q$name[-u],]
}

extract_min <- function(Q){
  Q$name[Q$distance == min(Q$distance)]
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
min_path <- distance
distance <- rep(Inf, 6)

distance[1] <- 0
names <- 1:6



Q <- data.frame(names, distance)

while(length(Q) > 1){
  u <- extract_min(Q)
  adjacents <- which(relational_matrix[u,] == 1, arr.ind = TRUE) 
  adjacents[adjacents %in% Q$name]
  # tenho que excluir os adjacentes que já foram percorridos tbm =/
  # tenho que nomear as colunas da relational_matrix
  for(v in adjacents){
    if(Q$distance[Q$name == v] > Q$distance[Q$name == u] + 1){
      Q$distance[Q$name == v] <- Q$distance[Q$name == u] + 1
      min_path[v] <- Q$distance[Q$name == v]
    }
  }
  Q <- Q[Q$name[-u],]
  relational_matrix[]
}

extract_min <- function(Q){
  Q$name[Q$distance == min(Q$distance)]
}

