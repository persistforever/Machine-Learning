function PCAanlysis(dataSet)
[lowDm, reconData] = PCA(dataSet) ;
plotData(dataSet, reconData) ;
end