# Lab 3 Implementing Cluster Analysis in R
setwd("D:/Foundation of Business Analytics/August 2021/Class 5/")

# read in the data
library(readxl)
cars = read_excel("survey cars.xlsx")

library(cluster)
library(NbClust)
library(factoextra)

# create a matrix to be clustered WITHOUT the ID field
X <- as.matrix(cars[,-1])
X[1:10,]

# Look at some summary statistics for the cars dataset
summary.stats <- cbind(
  apply(X,2,mean),
  apply(X,2,min),
  apply(X,2,max),
  apply(X,2,sd))
colnames(summary.stats) <- c("Avg", "Min", "Max", "Std Dev")
round(summary.stats,2)

# ***IF*** we wanted to standardize the data, we could do it this way
X.std <- scale(X, center=TRUE, scale=TRUE)
round(apply(X.std,2,mean),4) # all means are now 0 for each variable
round(apply(X.std,2,sd),4) # all standard deviations are now 1

# elbow plot for the first 10 clusters
fviz_nbclust(x=X, FUNcluster = kmeans, nstart=100, method="wss", k.max = 10) + 
  labs(title="Optimal Number of Clusters: Elbow Plot") + 
  coord_cartesian(ylim=c(0,12000)) + geom_line(size=2)

# Let's run a K-means cluster analysis on 5 clusters
# we are running the cluster analysis 100 times with nstart = 100
# centers = 5 tells R to run the analysis with 5 clusters
cluster.results = kmeans(x = X, centers = 5, iter.max=1000, nstart=100)

# examine cluster centers
# the cluster centers are used to interpret the results of the segments
t(round(cluster.results$centers,2))

# which cluster is each person assigned to?
cluster.numbers = cluster.results$cluster
cluster.numbers

# create a frequency table summarizing the number of people in each cluster
segment_sizes = table(cluster.numbers)
segment_sizes

# what percent of people are in each cluster?
percentages = round(segment_sizes/sum(segment_sizes), 4)*100
rbind(segment_sizes, percentages)

###
# cluster analysis fit statistics
# rquare for whole sample
r2 = 1 - cluster.results$tot.withinss/cluster.results$totss
round(r2,4)

# advanced techniques for determining the number of clusters

# diagnostic using multiple approaches
nb <- NbClust(X, distance="euclidean", min.nc=2, max.nc=10, method="kmeans")
fviz_nbclust(nb) # barplot

