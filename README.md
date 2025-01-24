<p align="center">
<img src="https://www.yworks.com/assets/images/landing-pages/demo-clustering-k-means.4c1937a892.png"  height="40%" width="50%" alt="Clustering Analysis"/>
</p>

<h1>Clustering Analysis in R</h1>
This project implements K-Means clustering to analyze a dataset of cars, using R to determine optimal clusters and evaluate customer segmentation characteristics.<br />

<h2>Video Demonstration</h2>

- ### [YouTube: K-Means Clustering in R](https://www.youtube.com/watch?v=wNsKf7wSqhQ)

<h2>Environments and Technologies Used</h2>

- R Programming
- RStudio
- Clustering Libraries (`cluster`, `NbClust`, `factoextra`)
- Visual Studio Code

<h2>Operating Systems Used </h2>

- Windows 11

<h2>List of Prerequisites</h2>

Before running this project, ensure you have:
- R and RStudio installed.
- Required R libraries: `readxl`, `cluster`, `NbClust`, `factoextra`.
- Dataset (`survey cars.xlsx`).

<h2>Installation Steps</h2>

### 1. Install Required Libraries
```r
install.packages(c("readxl", "cluster", "NbClust", "factoextra"))
```

### 2. Load and Prepare Data
```r
library(readxl)
cars <- read_excel("survey cars.xlsx")
X <- as.matrix(cars[,-1]) # Exclude ID column
```

### 3. Data Summary and Statistics
```r
summary.stats <- cbind(
  apply(X,2,mean),
  apply(X,2,min),
  apply(X,2,max),
  apply(X,2,sd)
)
colnames(summary.stats) <- c("Avg", "Min", "Max", "Std Dev")
round(summary.stats, 2)
``` 
<p> <img src="https://github.com/user-attachments/assets/data_summary.png" height="80%" width="80%" alt="Summary Stats"/> </p>

### 4. Standardize the Data (Optional)
```r
X.std <- scale(X, center=TRUE, scale=TRUE)
``` 

### 5. Determine Optimal Clusters (Elbow Method)
```r
library(factoextra)
fviz_nbclust(x=X, FUNcluster=kmeans, nstart=100, method="wss", k.max=10) + 
  labs(title="Optimal Number of Clusters: Elbow Plot") + 
  coord_cartesian(ylim=c(0,12000)) + geom_line(size=2)
``` 
<p> <img src="https://github.com/user-attachments/assets/elbow_plot.png" height="80%" width="80%" alt="Elbow Plot"/> </p>

### 6. Run K-Means Clustering
```r
cluster.results <- kmeans(x = X, centers = 5, iter.max=1000, nstart=100)
```

### 7. Interpret Cluster Results

<p>Cluster Centers</p>

```r
t(round(cluster.results$centers, 2))
```

<p>Cluster Memberships</p>

```r
cluster.numbers <- cluster.results$cluster
table(cluster.numbers)
```

<p>Cluster Percentages</p>

```r
percentages <- round(table(cluster.numbers)/sum(table(cluster.numbers)), 4) * 100
rbind(table(cluster.numbers), percentages)
```
<p> <img src="https://github.com/user-attachments/assets/cluster_results.png" height="80%" width="80%" alt="Cluster Results"/> </p>

### 8. Evaluate Clustering Fit (R-Squared)
```r
r2 <- 1 - cluster.results$tot.withinss/cluster.results$totss
round(r2, 4)
```

### 9. Advanced Cluster Validation
```r
library(NbClust)
nb <- NbClust(X, distance="euclidean", min.nc=2, max.nc=10, method="kmeans")
fviz_nbclust(nb)
```
<p> <img src="https://github.com/user-attachments/assets/nbclust_results.png" height="80%" width="80%" alt="Cluster Validation"/> </p> 

### 10. Conclusion
- The Elbow Method helped determine the optimal number of clusters.
- K-Means clustering was implemented to segment data into five meaningful clusters.
- Cluster centers provide insights into segment characteristics.
- The R² value shows how well the clustering explains data variation.
- The NbClust method validates the chosen number of clusters.

<h2>Future Improvements</h2>
- Explore hierarchical clustering or DBSCAN for alternative segmentations.
- Apply Principal Component Analysis (PCA) for dimensionality reduction.
- Use Silhouette Analysis to validate cluster separability.






